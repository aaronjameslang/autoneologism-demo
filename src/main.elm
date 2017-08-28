import Html
import Autoneologism as Anl
import View

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

view : Model -> Html.Html Msg
view model = View.view model.params model.result TextInMsg
