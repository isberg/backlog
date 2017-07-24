module View exposing (view)

import Model exposing (Model, Msg(..))
import Html exposing (Html, div, button, text, h1, ul, li, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (value, autofocus, id, type_)


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Backlog" ]
        , storiesView model.backlog
        , input [ onInput ChangeNew, value model.new, autofocus True, id "newStory" ] []
        , input [ type_ "button", onClick Add, value "Add" ] []
        ]


storiesView model =
    let
        storyView item =
            li []
                [ input [ type_ "button", onClick (Up item), value "+" ] []
                , text item
                , input [ type_ "button", onClick (Remove item), value "x" ] []
                ]
    in
        ul [] (List.map storyView model)
