module Bootstrap.Elements
    exposing
        ( button
        , form
        , formGroup
        , inputGroup
        , formInput
        , formLabel
        , div
        , span
        , column
        , row
        , h1
        , h2
        , h3
        , h4
        , h5
        , h6
        , container
        , fluidContainer
        , element
        , table
        , tbody
        , responsiveTable
        , thead
        , td
        , tr
        , th
        , p
        )

{-| Docs

Things in here mostly take the same stuff in, and mostly it matchhes the `Html` library with the key difference being the addition of a List Property as the first argument.

# Core elements
@docs button, form, div, span, h1, h2, h3, h4, h5, h6, thead, td, tr, th, p, table, tbody

# Higher level elements
@docs formGroup, formInput, inputGroup, formLabel, column, row, container, fluidContainer, responsiveTable

# Building blocks
@docs element
-}

import Html exposing (Html)
import Bootstrap.Properties as Properties


{-| Helper alias that represents the normal html functions that
the elm `Html` module exposes.
-}
type alias StandardElmHtmlFunction a =
    List (Html.Attribute a) -> List (Html a) -> Html a


{-| Docs private
-}
element : StandardElmHtmlFunction a -> List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
element htmlFn properties attributes html =
    htmlFn (Properties.merge (properties) attributes) html


{-| Create a button.

    button [ Properties.SuccessButton ] [] [ Html.text "Good Button" ]
    button [ Properties.SuccessButton, Properties.LargeButton ] [] [ Html.text "Big, Good Button" ]
-}
button : List (Properties.ButtonProperty) -> List (Html.Attribute a) -> List (Html a) -> Html a
button properties attributes html =
    element Html.button (List.map Properties.Button (Properties.BaseButton :: properties)) attributes html


{-| Create an html form that lays its fields out horizontally. It was intended to house `formInput` elements in `formGruops`

    form []
        []
        [ Elements.formGroup []
            [ Attributes.style [ ( "padding", "15px" ) ] ]
            [ Components.textEntry "Field 1" "field-1" "Enter text" [] []
            , Components.textEntry "Field 2" "field-2" "Enter text" [] []
            ]
        ]
-}
form : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
form properties attributes html =
    element Html.form (Properties.HorizontalFormGroup :: properties) attributes html


{-| Create a form group. It is intended to wrap a `formInput`. See `form` for an example.
-}
formGroup : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
formGroup properties attributes html =
    element Html.div (Properties.FormGroup :: properties) attributes html

{-| Create a form group. It is intended to wrap a `formInput`. See `form` for an example.
-}
inputGroup : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
inputGroup properties attributes html =
    element Html.div (Properties.InputGroup :: properties) attributes html


{-| TODO support input-group-addon for prefix symbols
-}
formInput : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
formInput properties attributes html =
    element Html.input (Properties.FormControl :: properties) attributes html


{-| Docs
-}
formLabel : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
formLabel properties attributes html =
    element Html.label (Properties.FormLabel :: properties) attributes html


{-| Docs
-}
table : List (Properties.TableProperty) -> List (Html.Attribute a) -> List (Html a) -> Html a
table properties attributes html =
    element Html.table (List.map Properties.Table (Properties.BaseTable :: properties)) attributes html


{-| Docs
-}
responsiveTable : List (Properties.TableProperty) -> List (Html.Attribute a) -> List (Html a) -> Html a
responsiveTable properties attributes html =
    div [ Properties.ResponsiveTableContainer ]
        []
        [ element Html.table (List.map Properties.Table (Properties.BaseTable :: properties)) attributes html
        ]


{-| Docs
-}
tbody : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
tbody properties attributes html =
    element Html.tbody properties attributes html


{-| Docs
-}
thead : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
thead properties attributes html =
    element Html.thead properties attributes html


{-| Docs
-}
tr : List (Properties.TableRowProperty) -> List (Html.Attribute a) -> List (Html a) -> Html a
tr properties attributes html =
    element Html.table (List.map Properties.TableRow properties) attributes html


{-| Docs
-}
td : List (Properties.TableCellProperty) -> List (Html.Attribute a) -> List (Html a) -> Html a
td properties attributes html =
    element Html.td (List.map Properties.TableCell properties) attributes html


{-| Docs
-}
th : List (Properties.TableCellProperty) -> List (Html.Attribute a) -> List (Html a) -> Html a
th properties attributes html =
    element Html.th (List.map Properties.TableCell properties) attributes html


{-| Docs
-}
div : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
div properties attributes html =
    element Html.div properties attributes html

{-| Docs
-}
span : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
span properties attributes html =
    element Html.span properties attributes html

{-| Docs
-}
p : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
p properties attributes html =
    element Html.p properties attributes html


{-| Docs
-}
h1 : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
h1 properties attributes html =
    element Html.h1 properties attributes html


{-| Docs
-}
h2 : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
h2 properties attributes html =
    element Html.h2 properties attributes html


{-| Docs
-}
h3 : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
h3 properties attributes html =
    element Html.h3 properties attributes html


{-| Docs
-}
h4 : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
h4 properties attributes html =
    element Html.h4 properties attributes html


{-| Docs
-}
h5 : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
h5 properties attributes html =
    element Html.h5 properties attributes html


{-| Docs
-}
h6 : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
h6 properties attributes html =
    element Html.h6 properties attributes html


{-| Docs
-}
row : List (Html.Attribute a) -> List (Html a) -> Html a
row attributes html =
    element Html.div [ Properties.Row ] attributes html


{-| Docs
-}
column : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
column properties attributes html =
    element Html.div properties attributes html


{-| TODO make classes enum
-}
container : List (Html.Attribute a) -> List (Html a) -> Html a
container attributes html =
    element Html.div [ Properties.Container ] attributes html


{-| TODO make classes enum
-}
fluidContainer : List (Html.Attribute a) -> List (Html a) -> Html a
fluidContainer attributes html =
    element Html.div [ Properties.Container ] attributes html
