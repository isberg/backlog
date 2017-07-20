import Html exposing (beginnerProgram, div, button, text, h1, ul, li, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (value)


main =
  beginnerProgram { model = model, view = view, update = update }

type alias Model = { backlog : List String, new : String }
model = 
  { backlog = [ "Story 1", "Story 2"]
  , new = "" 
  }

view model =
  div []
    [ h1 [] [ text "Backlog" ]
    , storiesView model.backlog
    , input [onInput Change, value model.new] []
    , button [onClick Add ] [text "Add"]
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


update msg { backlog, new } = 
  case msg of
    Add ->
      Model (new :: backlog) "" 

    Change newer ->
      Model backlog newer 

    Remove story ->
      let
        backlog_ = List.filter (\x -> x /= story) backlog
      in
        Model backlog_ story 
