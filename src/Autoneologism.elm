port module Autoneologism exposing (Params, Result, generateWords, generatedWords)

import Json.Decode exposing (..) -- Hack

type alias Params =
    { words: List String }

type alias Result =
    { attempts: Int
    , efficiency: Float
    , words: List String
}

port generateWords : Params -> Cmd msg
port generatedWords: (Result -> msg) -> Sub msg
