module Model exposing (Model, Msg(..))


type alias Model =
    { backlog : List String, new : String }


type Msg
    = Add
    | ChangeNew String
    | Remove String
    | NoOp
    | Loaded (List String)
