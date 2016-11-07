module Bootstrap.Components
    exposing
        ( titleWithSub
        , textEntry
        , FormColumnSizes
        , contextBox
        )

{-| Docs

@docs titleWithSub
@docs textEntry
@docs FormColumnSizes
@docs contextBox

-}

import Html exposing (Html)
import Html.Attributes as Attributes
import Bootstrap.Properties as Properties
import Bootstrap.Elements as Elements
import String


{-| Docs
-}
titleWithSub : String -> Maybe String -> Html a
titleWithSub titleText subTextMaybe =
    let
        subTextHtml =
            case subTextMaybe of
                Nothing ->
                    []

                Just subText ->
                    [ Html.small [] [ Html.text (" " ++ subText) ] ]
    in
        Elements.fluidContainer []
            [ Html.h1 []
                [ Html.text titleText
                , Html.i [ Attributes.style [ ( "whiteSpace", "noWrap" ) ] ] subTextHtml
                ]
            ]


{-| Docs
-}
transitionEverything : List Properties.Property
transitionEverything =
    [ Properties.HtmlAttribute <| Properties.Class "sb-transition" ]


{-| Docs
-}
hidden : List Properties.Property
hidden =
    [ Properties.HtmlAttribute <| Properties.Class "sb-hidden" ]


{-| Docs
-}
contextBox : String -> Properties.BackgroundProperty -> Html a
contextBox message background =
    let
        visibility =
            case String.isEmpty message of
                True ->
                    hidden

                False ->
                    []

        backgroundStyle =
            case background of
                Properties.PrimaryBackground ->
                    [ ( "backgroundColor", "#fff" ) ]

                _ ->
                    []
    in
        Elements.p
            ([ Properties.Background background ] ++ visibility ++ transitionEverything)
            [ Attributes.style ([ ( "padding", "15px" ) ] ++ backgroundStyle) ]
            [ Html.text message ]


{-| Docs TODO where do you pass in onInput? This has to change
-}
type alias FormColumnSizes =
    List ( Properties.Property, Properties.Property )


{-| Create a text entry that can be placed inside of a form. This create a
`formSection` with a left and right column.

    textEntry "Some label" "html-id" "Placeholder value"  [...]
        [(Column <| ExtraSmallColumn 4, Column ExtraSmallColumn 8)]

The `[...]` are just the typical `Html.Attributes` that are in the core `Html`
library already. The second list is a pair of ( Property, Property ), where the
first `Property` will be applied to the left hand side (the label) and the
second property is applied to the right hand side (the actual text box).

See `formSection` docs for more details. This list is just passed into that funciton.
-}
textEntry : String -> String -> String -> List (Html.Attribute a) -> FormColumnSizes -> Html a
textEntry label id placeholder attributes customSizes =
    formSection customSizes
        [ Elements.formLabel [] [ Attributes.for id ] [ Html.text label ] ]
        [ Elements.formInput [] (attributes ++ [ Attributes.id id, Attributes.placeholder placeholder ]) [] ]


{-| Create a formSection that renders a left hand side and a right hand side.

    formSection
        [(Column <| ExtraSmallColumn 4, Column <| ExtraSmallColumn 8)]
        [...]
        [...]

The `[...]` are just the typical `Html` that are in the core `Html` library
already. The first one is rendered into the left and the second is rendered
into the right.

In the example, you would get something like this, assuming the screen size was
using extra small media queries defined in bootstrap.

         4                8
    ----------------------------------
    First Html |     Second Html
    ----------------------------------

If no `FormColumnSizes` are given then the defaults are used;

    ( [ Properties.Column <| Properties.MediumColumn 4 ]
    , [ Properties.Column <| Properties.MediumColumn 8 ]
    )

This generates pretty typical responsive forms that work well on browsers and phones.
-}
formSection : FormColumnSizes -> List (Html a) -> List (Html a) -> Html a
formSection customSizes leftHandContent rightHandContent =
    let
        ( customLabelSizes, customInputSizes ) =
            case List.isEmpty customSizes of
                True ->
                    ( [ Properties.Column <| Properties.MediumColumn 4 ]
                    , [ Properties.Column <| Properties.MediumColumn 8 ]
                    )

                False ->
                    List.unzip customSizes
    in
        Elements.formGroup []
            []
            [ Elements.column customLabelSizes [] leftHandContent
            , Elements.column customInputSizes [] rightHandContent
            ]
