port module Update exposing (update, init, subscriptions)

import Model exposing (Model, Msg(..), Story)
import Dom
import Task


init =
    ( { backlog = [ "Story 1", "Story 2" ]
      , new = ""
      }
    , load ()
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg { backlog, new } =
    case msg of
        Add ->
            Model (new :: backlog) ""
                ! [ focusInput, storeAll (new :: backlog) ]

        ChangeNew newer ->
            Model backlog newer
                ! [ focusInput ]

        Remove story ->
            let
                backlog_ =
                    List.filter (\x -> x /= story) backlog
            in
                Model backlog_ story
                    ! [ focusInput, storeAll backlog_ ]

        NoOp ->
            Model backlog new
                ! []

        Loaded stories ->
            Model stories ""
                ! []


focusInput : Cmd Msg
focusInput =
    let
        ignoreResult =
            always NoOp
    in
        Dom.focus "newStory" |> Task.attempt ignoreResult


port storeAll : List Story -> Cmd msg


port load : () -> Cmd msg


port loaded : (List Story -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    loaded Loaded
