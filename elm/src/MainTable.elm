module MainTable exposing (..)

import Browser
import Html exposing (Attribute, Html, button, div, table, td, text, tr)
import Html.Attributes exposing (class, disabled, style)
import Html.Events exposing (onClick)

main : Program () Model Msg
main = Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Row = {id1: Int, name:String, num: Int}

type alias Model = List Row

type Msg
    = Increment Row
    | Decrement Row

subscriptions : Model -> Sub msg
subscriptions model = Sub.none

init : () ->(Model, Cmd Msg)
init _ = (rows, Cmd.none)

rows : List Row
rows = [{id1 = 0, name = "ala", num = 1},
    {id1 = 1, name = "zula", num = 21},
    {id1 = 2, name = "bela", num = 3},
    {id1 = 3, name = "ula", num = 5},
    {id1 = 4, name = "ala1", num = 2},
    {id1 = 5, name = "ola", num = 8}]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
        Increment idx->
            (rowUpdate model idx (+), Cmd.none)
        Decrement idx->
            (rowUpdate model idx (-), Cmd.none)

rowUpdate : Model -> Row -> (Int -> Int -> Int)-> Model
rowUpdate model idx fun =
    let
        updateElem elem =
            if(elem == idx) then
                {elem | num = fun elem.num 1 }
            else
                elem

        items = List.map updateElem model
    in
         items

view : Model -> Html Msg
view model =
    div []
    [ table border  (List.map printRow model)]

border : List (Attribute msg)
border = [style "border-width" "1px", style "border-style" "solid", style "width" "320px"]

printRow : Row -> Html Msg
printRow elem =
        tr border
            [td border [text elem.name],
             td border [button [ onClick (Decrement elem), disabled (elem.num <= 0) ,class "navbar-toggle"] [ text "-" ]],
             td border [text (String.fromInt elem.num)],
             td border [button [ onClick (Increment  elem) ] [ text "+" ]]]

