module Update exposing (update)

import Model exposing (Model, Msg(..))
import Dom
import Task


update: Msg -> Model -> (Model, Cmd Msg)
update msg { backlog, new } = 
  case msg of
    Add ->
      Model (new :: backlog) "" 
      ! [ focusInput ]

    Change newer ->
      Model backlog newer 
      ! [ focusInput ]

    Remove story ->
      let
        backlog_ = List.filter (\x -> x /= story) backlog
      in
        Model backlog_ story 
        ! [ focusInput ]

    NoOp ->
      Model backlog new
      ! []


focusInput: Cmd Msg
focusInput =
  let
    ignoreResult = always NoOp
  in
    Dom.focus "newStory" |> Task.attempt ignoreResult
