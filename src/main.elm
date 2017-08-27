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
    { params : Anl.Params
    , result : Maybe Anl.Result
}

init : (Model, Cmd msg)
init =
  let
    initialMsg : Msg
    initialMsg = TextInMsg "another open penmanship answer"
    emptyModel : Model
    emptyModel = Model ( Anl.Params [] ) Nothing
  in
    update initialMsg emptyModel


-- UPDATE

type Msg = TextInMsg String | AnlResultMsg Anl.Result

update : Msg -> Model -> (Model, Cmd msg)
update msg model =
  case msg of
    TextInMsg textIn ->
        ( Model { words = String.words textIn } Nothing
        , Anl.generateWords { words = String.words textIn }
      )
    AnlResultMsg result ->
      ({ model | result = Just result }
      , Cmd.none
    )

-- VIEW

view : Model -> Html Msg
view model =
  div [] [
    Html.form [] [
      Html.textarea [ cols 100, rows 20, onInput TextInMsg ] [ text <| String.join " " model.params.words ]
    ],
    resultView model.result
  ]

resultView: Maybe Anl.Result -> Html msg
resultView anlResult =
  case anlResult of
    Nothing -> p [] [text "Caculating"]
    Just result -> div []
      [ p [efficiencyColourAttribute result.efficiency] [text ("Efficiency " ++ floatToPercentage result.efficiency)]
      , p [] [text <| String.join " " result.words]
    ]

floatToPercentage: Float -> String
floatToPercentage f = String.left 2 (toString <| f * 100)  ++ "%"

efficiencyColourAttribute : Float -> Html.Attribute msg
efficiencyColourAttribute f = Html.Attributes.style [("background-color", "hsl(" ++ toString(round <| f*360) ++ ", 100%, 75%)")]
