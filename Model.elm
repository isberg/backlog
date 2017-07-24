module Model exposing (Model, Msg(..), Story)


type alias Model =
    { backlog : List Story, new : String }


type alias Story =
    String


type Msg
    = Add
    | ChangeNew String
    | Remove Story
    | NoOp
    | Loaded (List Story)
