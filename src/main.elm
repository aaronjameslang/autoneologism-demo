import Html exposing (Html, button, div, text, li, ul, p)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Autoneologism as Anl

main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Anl.generatedWords AnlResultMsg
    }

-- MODEL

type alias Model =
    { textIn : TextIn
    , anlResult : Maybe Anl.Result
}

type alias TextIn = String

init : (Model, Cmd msg)
init =
  let
    initialMsg : Msg
    initialMsg = TextInMsg "another open penmanship answer"
    emptyModel : Model
    emptyModel = Model "" Nothing
  in
    update initialMsg emptyModel


-- UPDATE

type Msg = TextInMsg TextIn | AnlResultMsg Anl.Result

update : Msg -> Model -> (Model, Cmd msg)
update msg model =
  case msg of
    TextInMsg textIn -> (Model textIn Nothing, Anl.generateWords (String.words textIn))
    AnlResultMsg anlResult -> ({ model | anlResult = Just anlResult }, Cmd.none)

-- VIEW

view : Model -> Html Msg
view model =
  div [] [
    Html.form [] [
      Html.textarea [ cols 100, rows 20, onInput TextInMsg ] [ text model.textIn ]
    ],
    resultView model.anlResult
  ]

resultView: Maybe Anl.Result -> Html msg
resultView anlResult =
  case anlResult of
    Nothing -> p [] [text "Caculating"]
    Just result -> div []
      [ p [] [text ("Efficiency " ++ floatToPercentage result.efficiency)]
      , p [] [text <| String.join " " result.words]
    ]

floatToPercentage: Float -> String
floatToPercentage f = String.left 2 (toString <| f * 100)  ++ "%"
