module MainStaticPage exposing (..)

import Html exposing (Html, button, div, text)

main : Html msg
main = "Button"
    |> text
    |> \elem1 -> button [] [elem1]
    |> \elem -> div [] [elem]

