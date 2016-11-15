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

{-| Things in here mostly take the same stuff in, and mostly it matches the `Html` library with the
key difference being the addition of a `List Property` as the first argument.

# Basic elements
@docs h1, h2, h3, h4, h5, h6, p, span, form, div, span, thead, tbody

# Elements that take specific properties
@docs button, td, tr, th, table

# Higher level elements
@docs formGroup, formInput, inputGroup, formLabel, container, fluidContainer, responsiveTable

# Building blocks
@docs column, row, element
-}

import Html exposing (Html)
import Bootstrap.Properties as Properties


{-| Helper alias that represents the normal html functions that
the elm `Html` module exposes.
-}
type alias StandardElmHtmlFunction a =
    List (Html.Attribute a) -> List (Html a) -> Html a


{-| Base of most of the functions in `Bootstrap.Elements`. This is exposed so that you can implement
anything that isn't already implemented. For reference, this is how you would create something like
a button.

    element Html.button (List.map Properties.Button (Properties.BaseButton :: properties)) attributes html

It refers to the functions in the core `Html` library through the type alias
`StandardElmHtmlFunction`. It just calls those functions after converting the supplied properties
into attributes for the `Html` module.
-}
element : StandardElmHtmlFunction a -> List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
element htmlFn properties attributes html =
    htmlFn (Properties.combineToAttributes (properties) attributes) html


{-| Create a button.

    button [ Properties.SuccessButton ] [] [ Html.text "Good Button" ]
    button [ Properties.SuccessButton, Properties.LargeButton ] [] [ Html.text "Big, Good Button" ]
-}
button : List (Properties.ButtonProperty) -> List (Html.Attribute a) -> List (Html a) -> Html a
button properties attributes html =
    element Html.button (List.map Properties.Button (Properties.BaseButton :: properties)) attributes html


{-| Create an html form that lays its fields out horizontally. It is intended to
house `formInput` elements in `formGroup`s.

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


{-| Create an input group. Wrapping these around input fields is what allows them to generate
prefix/addon sections. This is used to implement `Boostrap.Components.textEntry`.
-}
inputGroup : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
inputGroup properties attributes html =
    element Html.div (Properties.InputGroup :: properties) attributes html


{-| Create a form input section. This should be used to wrap an individual form input
field, like a name text entry box inside of a `form` body. It is used to implement the
`Bootstrap.Components.textEntry`. Without this, you may find that your forms don't align properly in
all sizes.
-}
formInput : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
formInput properties attributes html =
    element Html.input (Properties.FormControl :: properties) attributes html


{-| Create a form input label section. This is similar to `formInput`, but it should be used on the
`label` for an input instead of the `input` itself.
-}
formLabel : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
formLabel properties attributes html =
    element Html.label (Properties.FormLabel :: properties) attributes html


{-| Represents an `Html.table` element that accepts `Properties.TableProperty`,
converting them into the appropriate attributes.
-}
table : List (Properties.TableProperty) -> List (Html.Attribute a) -> List (Html a) -> Html a
table properties attributes html =
    element Html.table (List.map Properties.Table (Properties.BaseTable :: properties)) attributes html


{-| Like `table` but responsive. This will cause your table to scroll horizontally if the screen
shrinks too far instead of just squishing the columns down further.
-}
responsiveTable : List (Properties.TableProperty) -> List (Html.Attribute a) -> List (Html a) -> Html a
responsiveTable properties attributes html =
    div [ Properties.ResponsiveTableContainer ]
        []
        [ element Html.table (List.map Properties.Table (Properties.BaseTable :: properties)) attributes html
        ]


{-| Represents an `Html.tbody` element that accepts `Properties.Property`,
converting them into the appropriate attributes.
-}
tbody : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
tbody properties attributes html =
    element Html.tbody properties attributes html


{-| Represents an `Html.thead` element that accepts `Properties.Property`,
converting them into the appropriate attributes.
-}
thead : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
thead properties attributes html =
    element Html.thead properties attributes html


{-| Represents an `Html.tr` element that accepts `Properties.TableRowProperty`,
converting them into the appropriate attributes.
-}
tr : List (Properties.TableRowProperty) -> List (Html.Attribute a) -> List (Html a) -> Html a
tr properties attributes html =
    element Html.tr (List.map Properties.TableRow properties) attributes html


{-| Represents an `Html.td` element that accepts `Properties.TableCellProperty`,
converting them into the appropriate attributes.
-}
td : List (Properties.TableCellProperty) -> List (Html.Attribute a) -> List (Html a) -> Html a
td properties attributes html =
    element Html.td (List.map Properties.TableCell properties) attributes html


{-| Represents an `Html.th` element that accepts `Properties.TableCellProperty`,
converting them into the appropriate attributes.
-}
th : List (Properties.TableCellProperty) -> List (Html.Attribute a) -> List (Html a) -> Html a
th properties attributes html =
    element Html.th (List.map Properties.TableCell properties) attributes html


{-| Represents an `Html.div` element that accepts `Properties.Property`,
converting them into the appropriate attributes.
-}
div : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
div properties attributes html =
    element Html.div properties attributes html


{-| Represents an `Html.span` element that accepts `Properties.Property`,
converting them into the appropriate attributes.
-}
span : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
span properties attributes html =
    element Html.span properties attributes html


{-| Represents an `Html.p` element that accepts `Properties.Property`,
converting them into the appropriate attributes.
-}
p : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
p properties attributes html =
    element Html.p properties attributes html


{-| Represents an `Html.h1` element that accepts `Properties.Property`,
converting them into the appropriate attributes.
-}
h1 : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
h1 properties attributes html =
    element Html.h1 properties attributes html


{-| Represents an `Html.h2` element that accepts `Properties.Property`,
converting them into the appropriate attributes.
-}
h2 : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
h2 properties attributes html =
    element Html.h2 properties attributes html


{-| Represents an `Html.h3` element that accepts `Properties.Property`,
converting them into the appropriate attributes.
-}
h3 : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
h3 properties attributes html =
    element Html.h3 properties attributes html


{-| Represents an `Html.h4` element that accepts `Properties.Property`,
converting them into the appropriate attributes.
-}
h4 : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
h4 properties attributes html =
    element Html.h4 properties attributes html


{-| Represents an `Html.h5` element that accepts `Properties.Property`,
converting them into the appropriate attributes.
-}
h5 : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
h5 properties attributes html =
    element Html.h5 properties attributes html


{-| Represents an `Html.h6` element that accepts `Properties.Property`,
converting them into the appropriate attributes.
-}
h6 : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
h6 properties attributes html =
    element Html.h6 properties attributes html


{-| Create a row that can have columns inside of it. You'll probably be usig this along with `row`
very often in bootstrap. Rows can store columns and columns can be anywhere from 1 to 12 grid units
wide, where their width can vary depending on the current size of the browser. The example below
will create a row that has two columns. The first column will take up 12 units (the entire row) if
the screen is currently using the "extra small" media query, which means it is below some threshold
in pixel width. If it is in the range of "medium", it will only take up 4 units. Similarly, the
second column will take up the entire row when the screen is small, but it will fill in that missing
8 grid unit slot if the screen is bigger.

Make sure to read the Bootstrap CSS documentation for more on how the grid system works. In the end,
a row is just going to create a div with the right class for you. Make sure you nest this element
inside of an `Bootstrap.Elements.container` as well. It doesn't have to be the first child or
anything, it just has to be inside of one somewhere on the page in order for Bootstrap to actually
work.

    Elements.row [ Attributes.style [ ( "margin-bottom", "15px" ) ] ]
        [ Elements.column
            [ Properties.Column <| Properties.ExtraSmallColumn 12
            , Properties.Column <| Properties.MediumColumn 4
            , Properties.Background Properties.InfoBackground
            ]
            []
            [ Elements.h3 [] [] [ Html.text "first column" ] ]
        , Elements.column
            [ Properties.Column <| Properties.ExtraSmallColumn 12
            , Properties.Column <| Properties.MediumColumn 8
            ]
            []
            [ Elements.h3 [] [] [ Html.text "second column" ] ]
        ]
-}
row : List (Html.Attribute a) -> List (Html a) -> Html a
row attributes html =
    element Html.div [ Properties.Row ] attributes html


{-| Create a column. See `Bootstrap.Elements.row` for an example.
-}
column : List (Properties.Property) -> List (Html.Attribute a) -> List (Html a) -> Html a
column properties attributes html =
    element Html.div properties attributes html


{-| Create a container. For anything to actually work, it has to be inside of a container at some
point. You only need to have one container on the page; you shouldn't be nesting them inside of each
other.
-}
container : List (Html.Attribute a) -> List (Html a) -> Html a
container attributes html =
    element Html.div [ Properties.Container ] attributes html


{-| Like container, but but it uses the `.container-fluid` class instead, which fills the entire
view port and is apparently more responsive.
-}
fluidContainer : List (Html.Attribute a) -> List (Html a) -> Html a
fluidContainer attributes html =
    element Html.div [ Properties.FluidContainer ] attributes html
