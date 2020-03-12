port module MainTablePort exposing (..)

import Browser
import Html exposing (Attribute, Html, br, button, div, table, td, text, tr)
import Html.Attributes exposing (class, disabled, style)
import Html.Events exposing (onClick)
import List exposing (foldl)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Row =
    { id : Int, name : String, num : Int }


type alias Model =
    List Row


type Msg
    = Increment Int
    | Decrement Int
    | SendMsg String


port sendData : String -> Cmd msg


port receiveData : (Int -> msg) -> Sub msg


init : () -> ( Model, Cmd Msg )
init _ =
    ( rows, Cmd.none )


rows : List Row
rows =
    [ { id = 0, name = "ala", num = 1 }
    , { id = 1, name = "zula", num = 21 }
    , { id = 2, name = "bela", num = 3 }
    , { id = 3, name = "ula", num = 5 }
    , { id = 4, name = "ala1", num = 2 }
    , { id = 5, name = "ola", num = 8 }
    ]


subscriptions : Model -> Sub Msg
subscriptions e =
    receiveData changeRowValue


changeRowValue : Int -> Msg
changeRowValue id =
    Increment id


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment id ->
            ( rowUpdate model id (+), Cmd.none )

        Decrement id ->
            ( rowUpdate model id (-), Cmd.none )

        SendMsg message ->
            ( model, sendData message )


rowUpdate : Model -> Int -> (Int -> Int -> Int) -> Model
rowUpdate model id fun =
    let
        updateElem elem =
            if elem.id == id then
                { elem | num = fun elem.num 1 }

            else
                elem

        items =
            List.map updateElem model
    in
    items


view : Model -> Html Msg
view model =
    div []
        [ table border (List.map printRow model)
        , br [] []
        , button [ onClick (SendMsg "message to JS") ] [ text "sendData" ]
        ]


border : List (Attribute msg)
border =
    [ style "border-width" "1px", style "border-style" "solid", style "width" "320px" ]


printRow : Row -> Html Msg
printRow elem =
    tr border
        [ td border [ text elem.name ]
        , td border [ button [ onClick (Decrement elem.id), disabled (elem.num <= 0), class "navbar-toggle" ] [ text "-" ] ]
        , td border [ text (String.fromInt elem.num) ]
        , td border [ button [ onClick (Increment elem.id) ] [ text "+" ] ]
        ]
