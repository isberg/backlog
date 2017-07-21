import Update exposing (update)
import Model exposing (init)
import View exposing (view)

import Html exposing (program)

main =
  program { init = init, view = view, update = update , subscriptions = (\_ -> Sub.none)}

