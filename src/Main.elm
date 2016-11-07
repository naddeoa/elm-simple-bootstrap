module Main exposing (..)

import Html exposing (Html)
import Html.App
import Html.Attributes as Attributes
import Bootstrap.Elements as Elements
import Bootstrap.Components as Components
import Bootstrap.Properties as Properties


type alias Model =
    { label : String
    , text : String
    }


type Msg
    = NoOp


demoBox : String -> List (Html a) -> Html a
demoBox description content =
    Elements.row [ Attributes.style [ ( "margin-bottom", "15px" ) ] ]
        [ Elements.column
            [ Properties.Column <| Properties.ExtraSmallColumn 12
            , Properties.Column <| Properties.MediumColumn 4
            ]
            []
            [ Elements.h3 [] [] [ Html.text description ] ]
        , Elements.column
            [ Properties.Column <| Properties.ExtraSmallColumn 12
            , Properties.Column <| Properties.MediumColumn 8
            , Properties.Background Properties.InfoBackground
            ]
            []
            content
        ]


view : Model -> Html Msg
view model =
    Elements.container []
        [ Elements.h1 [] [] [ Html.text "Demo of simple-bootstrap" ]
        , demoBox
            "Title with an optional subtitle"
            [ Components.titleWithSub "Simple Boostrap" <| Just "An Elm module for outputing bootstrap markup" ]
        , demoBox
            "Forms"
            [ Elements.form []
                []
                [ Elements.formGroup []
                    []
                    [ Components.textEntry "Field 1" "field-1" "Enter text" [] []
                    , Components.textEntry "Field 2" "field-2" "Enter text" [] []
                    ]
                ]
            ]
        , demoBox
            "Form with overriden width"
            [ Elements.form []
                []
                [ Elements.formGroup []
                    []
                    [ Components.textEntry "Field 1" "field-1" "Enter text" [] [ ( Properties.Column <| Properties.ExtraSmallColumn 6, Properties.Column <| Properties.ExtraSmallColumn 6 ) ]
                    , Components.textEntry "Field 2" "field-2" "Enter text" [] [ ( Properties.Column <| Properties.ExtraSmallColumn 6, Properties.Column <| Properties.ExtraSmallColumn 6 ) ]
                    ]
                ]
            ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : ( Model, Cmd Msg )
init =
    ( Model "Name f" "Placeholder", Cmd.none )


main : Program Never
main =
    Html.App.program
        { update = update
        , view = view
        , init = init
        , subscriptions = subscriptions
        }
