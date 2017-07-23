module View exposing (view)

import Model exposing (Model, Msg(..))
import Html exposing (Html, div, button, text, h1, ul, li, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (value, autofocus, id)


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Backlog" ]
        , storiesView model.backlog
        , input [ onInput ChangeNew, value model.new, autofocus True, id "newStory" ] []
        , button [ onClick Add ] [ text "Add" ]
        ]


storiesView model =
    let
        storyView item =
            li [] [ text item, button [ onClick (Remove item) ] [ text "X" ] ]
    in
        ul [] (List.map storyView model)