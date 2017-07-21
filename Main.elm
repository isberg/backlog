import Html exposing (program, div, button, text, h1, ul, li, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (value, autofocus, id)
import Dom
import Task


main =
  program { init = init, view = view, update = update , subscriptions = (\_ -> Sub.none)}

init = 
  ( { backlog = [ "Story 1", "Story 2"]
    , new = "" 
    }
  , Cmd.none
  )


type alias Model = { backlog : List String, new : String }
model = 
  { backlog = [ "Story 1", "Story 2"]
  , new = "" 
  }

view model =
  div []
    [ h1 [] [ text "Backlog" ]
    , storiesView model.backlog
    , input [onInput Change, value model.new, autofocus True, id "newStory"] []
    , button [onClick Add] [text "Add"]
    ]

storiesView model = 
  let
    storyView item = li[onClick (Remove item)] [text item]
  in
    ul [] (List.map storyView model)
  

type Msg 
  = Add 
  | Change String 
  | Remove String
  | FocusResult (Result Dom.Error ())


update msg { backlog, new } = 
  case msg of
    Add ->
      Model (new :: backlog) "" 
      ! [ Dom.focus "newStory" |> Task.attempt FocusResult ]

    Change newer ->
      Model backlog newer 
      ! [ Dom.focus "newStory" |> Task.attempt FocusResult ]

    Remove story ->
      let
        backlog_ = List.filter (\x -> x /= story) backlog
      in
        Model backlog_ story 
        ! [ Dom.focus "newStory" |> Task.attempt FocusResult ]

    FocusResult result ->
      -- handle success or failure here
      case result of
        Err (Dom.NotFound id) ->
          -- unable to find dom 'id'
          Model backlog new
          ! [ Cmd.none ]
        Ok () ->
          -- successfully focus the dom
          Model backlog new
          ! [ Cmd.none ]
