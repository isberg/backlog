module Main exposing (main)

import Update exposing (update, init, subscriptions)
import View exposing (view)
import Html exposing (program)


main =
    program { init = init, view = view, update = update, subscriptions = subscriptions }
