module ResultsApp exposing (main)

import Html exposing (Html, button, div, text, li, ul, p)
import Html.Attributes as Attr exposing (..)
import Autoneologism as Anl

main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Anl.generatedWords Msg
    }

type alias Model = Maybe Anl.Results
type Msg = Msg Anl.Results

init : (Model, Cmd msg)
init = (Nothing, Cmd.none)

update : Msg -> Model -> (Model, Cmd msg)
update msg _ =
  case msg of
    Msg result ->
      ( Just result, Cmd.none )

view : Model -> Html msg
view mr =
  case mr of
    Nothing -> p [] [text "Calculating..."]
    Just r -> viewResult r

viewResult : Anl.Results -> Html msg
viewResult result =
    div [] [efficiencyToHtml result.efficiency, wordsOutToHtml result.words]

efficiencyToHtml : Float -> Html msg
efficiencyToHtml e = p [floatToColourAttr e] [text <| "Efficiency " ++ floatToPercentage e]

wordsOutToHtml : List String -> Html msg
wordsOutToHtml w = p [] [text <| String.join " " w]

floatToPercentage: Float -> String
floatToPercentage =
     (*) 100
  >> round
  >> toString
  >> flip (++) "%"

floatToHue : Float -> Int
floatToHue = round << (*) 360 -- try <|

floatToColourAttr : Float -> Html.Attribute msg
floatToColourAttr f =
  Attr.style [(
    "background-color",
    "hsl(" ++ toString (floatToHue f) ++ ", 100%, 75%)"
  )]
