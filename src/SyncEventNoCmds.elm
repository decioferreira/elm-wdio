module SyncEventNoCmds exposing (main)

import Browser
import Html exposing (Html, button, div, form, input, text)
import Html.Attributes exposing (id, type_)
import Html.Events exposing (custom, onBlur)
import Json.Decode as Decode
import Task
import Time


type Model
    = StepA
    | StepB
    | StepC Time.Posix


type Msg
    = Submit
    | Now Time.Posix
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Submit ->
            ( StepB, Task.perform Now Time.now )

        Now timeNow ->
            ( StepC timeNow, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    case model of
        StepA ->
            div [ id "step-a" ]
                [ form
                    [ custom "submit"
                        (Decode.succeed
                            { message = Submit
                            , stopPropagation = True
                            , preventDefault = True
                            }
                        )
                    ]
                    [ input [ type_ "text", id "text-input", onBlur NoOp ] []
                    , input [ type_ "submit" ] [ text "submit" ]
                    ]
                ]

        StepB ->
            div [ id "step-b" ] [ text "This means it did not work!" ]

        StepC timeNow ->
            div [ id "step-c" ] [ text <| String.fromInt <| Time.posixToMillis timeNow ]


main : Program () Model Msg
main =
    Browser.element
        { init = always ( StepA, Cmd.none )
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
