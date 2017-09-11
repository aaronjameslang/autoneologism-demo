module ParametersApp exposing (main)

import Html exposing (Html, button, div, text, li, ul, p)
import Html.Attributes as Attr exposing (..)
import Html.Events as Events
import Autoneologism as Anl

main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }

type alias Model = Anl.Parameters
type Msg = TextInMsg String | LinkLengthMsg Int

init : (Model, Cmd msg)
init =
    update
      --<| TextInMsg "another open penmanship answer"
      ( TextInMsg "another open penmanship answer" )
      <| Anl.Parameters [] 3

update : Msg -> Model -> (Model, Cmd msg)
update msg model =
  let
    newModel = updateModel msg model
  in
    ( newModel
    , Anl.generateWords newModel
    )

updateModel : Msg -> Model -> Model
updateModel msg model =
  case msg of
    TextInMsg textIn ->
      { model | wordsIn = String.words textIn }
    LinkLengthMsg linkLength ->
      { model | linkLength = linkLength }

view : Model -> Html Msg
view p = Html.form []
  [ Html.textarea
      [ cols 100, rows 20, Events.onInput TextInMsg ]
      [ text <| String.join " " p.wordsIn ]
  , viewRadioButton 3
  , viewRadioButton 4
  , viewRadioButton 5
  ]

viewRadioButton : Int -> Html.Html Msg
viewRadioButton value =
  Html.input
    [ Attr.type_ "radio"
    , Attr.name "link-length"
    , Attr.value <| toString value
    , Events.onClick <| LinkLengthMsg value
    ]
    [ Html.text <| toString value ]
