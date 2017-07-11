import Html exposing (beginnerProgram, div, button, text, h1, ul, li, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (value)


main =
  beginnerProgram { model = model, view = view, update = update }


model = { backlog = [ "Story 1", "Story 2"], new = "" }

view model =
  div []
    [ h1 [] [ text "Backlog" ]
    , storyListView model.backlog
    , input [onInput Change, value model.new] []
    , button [onClick Add ] [text "Add"]
    ]

storyListView model = 
  let
    itemView item = li[onClick (Remove item)] [text item]
  in
    ul [] (List.map itemView model)
  

type Msg = Add | Change String | Remove String


update msg model = 
  case msg of
    Add ->
      {model | backlog = model.new :: model.backlog, new = "" }
    Change new ->
      {model | new = new }
    Remove story ->
      {model | backlog = (List.filter (\x -> x /= story) model.backlog), new = story}
