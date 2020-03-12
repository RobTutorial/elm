module MainJson exposing (..)

import Browser
import Html exposing (Html, text)
import Http
import Json.Decode exposing (Decoder)

main : Program () Model Msg
main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = \_ -> Sub.none
    , view = view
    }

type alias User =
    { id : String,
     value : String}

type Model
  = Failure Http.Error
  | Loading
  | Success String

type Msg
    = GotResult (Result Http.Error User)

init : () -> (Model, Cmd Msg)
init _ =
  ( Loading, fetchCatImageUrl )

fetchCatImageUrl : Cmd Msg
fetchCatImageUrl =
    Http.get
        { url =  "http://localhost:8000/i1.html"
        , expect = Http.expectJson GotResult usersDecoder
        }

usersDecoder : Decoder User
usersDecoder =
    Json.Decode.map2
    User
    (Json.Decode.at [ "id" ] Json.Decode.string)
    (Json.Decode.at [ "value" ] Json.Decode.string)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GotResult result ->
      case result of
        Ok fullText ->
          (Success fullText.value, Cmd.none)

        Err err ->
          (Failure err, Cmd.none)

view : Model -> Html Msg
view model =
  case model of
    Failure err ->
      text ("I was unable to load your book: " ++ Debug.toString err )

    Loading ->
      text "Loading..."

    Success fullText ->
        text fullText

