module LinkPreventDefault exposing (main)

import Browser
import Browser.Navigation
import Html exposing (Html, a, b, div, li, p, text, ul)
import Html.Attributes exposing (href, id, target)
import Html.Events exposing (preventDefaultOn)
import Json.Decode as Decode
import Url



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


type alias Model =
    { key : Browser.Navigation.Key
    , url : Url.Url
    , clicked : Bool
    }


init : () -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url False, Cmd.none )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | OnClick


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Browser.Navigation.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Browser.Navigation.load href )

        UrlChanged url ->
            ( { model | url = url }, Cmd.none )

        OnClick ->
            ( { model | clicked = True }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "URL Interceptor"
    , body =
        [ div [ id "link-prevent-default" ]
            [ p []
                [ text "The current URL is: "
                , b [ id "current-url" ] [ text (Url.toString model.url) ]
                ]
            , p []
                [ text "Clicked: "
                , b [ id "clicked" ]
                    [ if model.clicked then
                        text "yes"

                      else
                        text "no"
                    ]
                ]
            , ul []
                [ li []
                    [ a
                        [ id "click-me"
                        , href "#click-me"
                        , preventDefaultOn "click" (Decode.succeed ( OnClick, True ))
                        ]
                        [ text "click me" ]
                    ]
                , li []
                    [ a
                        [ id "workaround"
                        , href "#workaround"
                        , preventDefaultOn "click" (Decode.succeed ( OnClick, True ))

                        -- WORKAROUND
                        , target "_self"
                        ]
                        [ text "workaround" ]
                    ]
                ]
            ]
        ]
    }


viewLink : String -> Html Msg
viewLink path =
    li [] [ a [ href path, preventDefaultOn "click" (Decode.succeed ( OnClick, True )) ] [ text path ] ]
