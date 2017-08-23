port module Autoneologism exposing (Result, generateWords, generatedWords)

type alias Result =
    { attempts: Int
    , efficiency: Float
    , words: List String
}

port generateWords : List String -> Cmd msg

port generatedWords: (Result -> msg) -> Sub msg


