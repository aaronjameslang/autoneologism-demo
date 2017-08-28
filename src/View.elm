module View exposing (view)

import Html exposing (Html, button, div, text, li, ul, p)
import Html.Attributes exposing (..)
import Html.Events
import Autoneologism as Anl
import Bootstrap.Grid as Grid

view : Anl.Params -> Maybe Anl.Result -> (String -> msg) -> Html msg
view p mr handler =
  Grid.container [] [
    Grid.row [] [
      Grid.col [] [paramsToHtml p handler]
    ], Grid.row [] [
      Grid.col [] [maybeResultToHtml mr]
    ]
  ]

paramsToHtml : Anl.Params -> (String -> msg) -> Html msg
paramsToHtml p handler = Html.textarea
  [ cols 100, rows 20, Html.Events.onInput handler ]
  [ text <| String.join " " p.words ]

maybeResultToHtml : Maybe Anl.Result -> Html msg
maybeResultToHtml mr =
  case mr of
    Nothing -> p [] [text "Calculating..."]
    Just r -> resultToHtml r

resultToHtml : Anl.Result -> Html msg
resultToHtml result =
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
  Html.Attributes.style [(
    "background-color",
    "hsl(" ++ toString (floatToHue f) ++ ", 100%, 75%)"
  )]
