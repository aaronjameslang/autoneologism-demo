port module Autoneologism exposing (Parameters, Results, generateWords, generatedWords)

import Json.Decode exposing (..) -- Hack

type alias Parameters =
  { wordsIn: List String
  , linkLength: Int
  }

type alias Results =
  { attempts: Int
  , efficiency: Float
  , words: List String
  }

port generateWords : Parameters -> Cmd msg
port generatedWords: (Results -> msg) -> Sub msg
