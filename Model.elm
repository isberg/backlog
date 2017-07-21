module Model exposing (Model, Msg(..), init)

import Dom

type alias Model = { backlog : List String, new : String }

type Msg 
  = Add 
  | Change String 
  | Remove String
  | NoOp


init = 
  ( { backlog = [ "Story 1", "Story 2"]
    , new = "" 
    }
  , Cmd.none
  )

