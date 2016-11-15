module Bootstrap.Properties
    exposing
        ( Property(..)
        , ColumnProperty(..)
        , ButtonProperty(..)
        , AttributeProperty(..)
        , TableProperty(..)
        , TableRowProperty(..)
        , TableCellProperty(..)
        , BackgroundProperty(..)
        , toAttributes
        , combineToAttributes
        )

{-| Docs


@docs Property
@docs ColumnProperty
@docs ButtonProperty
@docs AttributeProperty
@docs TableProperty
@docs TableRowProperty
@docs TableCellProperty
@docs BackgroundProperty
@docs toAttributes
@docs combineToAttributes


-}

import Html
import Html.Attributes as Attributes


{-| This is the main type of the bootstraplibrary. Utlimately, everything that
is mapped onto `Html` elements is represented as a proeprty. Something like
`Property.Row` will get mapped onto the class string `row` so that the twitter
bootstrap CSS treats it as a row. You probably should't start with this type
though. You'll probably start with one of the types in `Bootstrap.Elements` or
`Bootstrap.Components` and give it whatever it can take. For example, if you
need a button then you'll use `Bootstrap.Elements.button`, whose first argument
happens to be a `ButtonProperty`. Then, you'll just pass it whateer
`ButtonProperty` you want.

If you want to make something more general then you may use
`Bootstrap.Elements.elements`. You can create `button` yourself in that way. It
would look like the following.

    Bootstrap.Elements.element Html.button (List.map Properties.Button (Properties.BaseButton :: properties)) attributes html

It is just a fancy wrapper over a function that maps a bunch of `ButtonProperty`
into `Button` and passes it into `Bootstrap.Elements.element`.

-}
type Property
    = Column ColumnProperty
    | Button ButtonProperty
    | HtmlAttribute AttributeProperty
    | Table TableProperty
    | TableRow TableRowProperty
    | TableCell TableCellProperty
    | Background BackgroundProperty
    | Row
    | Container
    | FluidContainer
    | FormLabel
    | FormControl
    | FormGroup
    | InputGroup
    | InputGroupAddon
    | HorizontalFormGroup
    | ResponsiveTableContainer


{-| This type reprents the different background classes in bootstrap css. i.w.,
bg-danger, bg-info, etc.
-}
type BackgroundProperty
    = PrimaryBackground
    | SuccessBackground
    | InfoBackground
    | WarningBackground
    | DangerBackground


{-| This type allows you to specify aritrary attributes from the `Html` library.
This is needed because all of the properties in bootstrap have to map back to
html classes in the end. That means that internally, this library has to use
`Html.Attributes.class` to set class values. That also means that I end upd
clobering your class values in the process.

It is very important that you specify html classes with `Properties.Class
"my-class"` instead of using attriutes. Otherwise, class that comes second
(mine) will win and the one you provdided will be lost.
-}
type AttributeProperty
    = Class String


{-| Docs
-}
type ColumnProperty
    = MediumColumn Int
    | MediumOffsetColumn Int
    | MediumPullColumn Int
    | MediumPushColumn Int
    | LargeColumn Int
    | LargeOffsetColumn Int
    | LargePullColumn Int
    | LargePushColumn Int
    | SmallColumn Int
    | SmallOffsetColumn Int
    | SmallPullColumn Int
    | SmallPushColumn Int
    | ExtraSmallColumn Int
    | ExtraSmallOffsetColumn Int
    | ExtraSmallPullColumn Int
    | ExtraSmallPushColumn Int


{-| Docs
-}
type ButtonProperty
    = PrimaryButton
    | NormalButton
    | LargeButton
    | SmallButton
    | ExtraSmallButton
    | BaseButton
    | SuccessButton


{-| Docs
-}
type TableProperty
    = BorderedTable
    | HoverTable
    | CondensedTable
    | StripedTable
    | BaseTable


{-| Docs
-}
type TableRowProperty
    = SuccessRow
    | ActiveRow
    | InfoRow
    | WarningRow
    | DangerRow


{-| Docs
-}
type TableCellProperty
    = SuccessCell
    | ActiveCell
    | InfoCell
    | WarningCell
    | DangerCell


{-| Docs
-}
type alias AttributeBundle =
    { classes : String
    }


{-| Docs
-}
emptyBundle : AttributeBundle
emptyBundle =
    { classes = "" }


{-| Docs
-}
generateAttributes : AttributeBundle -> List (Html.Attribute a)
generateAttributes bundle =
    [ Attributes.class bundle.classes ]


{-| Convert a `List Property` to a `List (Html.Attribute a)`. Everything in this module is a
`Property` that ultimately has to turn into some kind of `Html.Attribute` in order to be output onto
the dom in Elm. What attributes each property turn into is an implementation detail. Some may just
map to a single class, some may map to multiple different attributes.
-}
toAttributes : List Property -> List (Html.Attribute a)
toAttributes property =
    generateAttributes <| generateAttributeBundles property


{-| Convenience function that calls `toAttributes` and then concats the resulting list with the
supplied `List (Html.Attribute a)`.
-}
combineToAttributes : List Property -> List (Html.Attribute a) -> List (Html.Attribute a)
combineToAttributes properties attributes =
    toAttributes properties ++ attributes


{-| Docs
-}
combineBundles : AttributeBundle -> AttributeBundle -> AttributeBundle
combineBundles a b =
    { classes = a.classes ++ " " ++ b.classes }


{-| Docs
-}
generateAttributeBundles : List Property -> AttributeBundle
generateAttributeBundles properties =
    let
        bundles =
            List.map generateAttributeBundle properties
    in
        List.foldr combineBundles emptyBundle bundles


{-| Docs
-}
generateAttributeBundle : Property -> AttributeBundle
generateAttributeBundle property =
    case property of
        Column columnType ->
            { classes = columnClass columnType }

        Row ->
            { classes = "row" }

        Container ->
            { classes = "container" }

        FluidContainer ->
            { classes = "container-fluid" }

        FormLabel ->
            { classes = "control-label" }

        FormControl ->
            { classes = "form-control" }

        FormGroup ->
            { classes = "form-group" }

        InputGroup ->
            { classes = "input-group" }

        InputGroupAddon ->
            { classes = "input-group-addon" }

        HorizontalFormGroup ->
            { classes = "form-horizontal" }

        Button buttonType ->
            { classes = buttonClass buttonType }

        HtmlAttribute attribute ->
            { classes = htmlAttributeClass attribute }

        Table property ->
            { classes = tableClass property }

        TableRow property ->
            { classes = tableRowClass property }

        ResponsiveTableContainer ->
            { classes = "table-responsive" }

        TableCell property ->
            { classes = tableCellClass property }

        Background property ->
            { classes = backgroundClass property }


{-| Docs
-}
backgroundClass : BackgroundProperty -> String
backgroundClass property =
    case property of
        PrimaryBackground ->
            "bg-primary"

        SuccessBackground ->
            "bg-success"

        InfoBackground ->
            "bg-info"

        WarningBackground ->
            "bg-warning"

        DangerBackground ->
            "bg-danger"


{-| Docs
-}
tableCellClass : TableCellProperty -> String
tableCellClass property =
    case property of
        SuccessCell ->
            "success"

        ActiveCell ->
            "active"

        InfoCell ->
            "info"

        WarningCell ->
            "warning"

        DangerCell ->
            "danger"


tableRowClass : TableRowProperty -> String
tableRowClass property =
    case property of
        SuccessRow ->
            "success"

        ActiveRow ->
            "active"

        InfoRow ->
            "info"

        WarningRow ->
            "warning"

        DangerRow ->
            "danger"


tableClass : TableProperty -> String
tableClass property =
    case property of
        BorderedTable ->
            "table-bordered"

        HoverTable ->
            "table-hover"

        CondensedTable ->
            "table-condensed"

        StripedTable ->
            "table-striped"

        BaseTable ->
            "table"


{-| Docs
-}
htmlAttributeClass : AttributeProperty -> String
htmlAttributeClass attribute =
    case attribute of
        Class class ->
            class


{-| Docs
-}
columnClass : ColumnProperty -> String
columnClass columnType =
    let
        ( prefix, size ) =
            case columnType of
                MediumColumn size ->
                    ( "col-md-", size )

                MediumOffsetColumn size ->
                    ( "col-md-offset-", size )

                MediumPullColumn size ->
                    ( "col-md-pull-", size )

                MediumPushColumn size ->
                    ( "col-md-pull-", size )

                LargeColumn size ->
                    ( "col-lg-", size )

                LargeOffsetColumn size ->
                    ( "col-lg-offset-", size )

                LargePullColumn size ->
                    ( "col-lg-pull-", size )

                LargePushColumn size ->
                    ( "col-lg-pull-", size )

                SmallColumn size ->
                    ( "col-sm-", size )

                SmallOffsetColumn size ->
                    ( "col-sm-offset-", size )

                SmallPullColumn size ->
                    ( "col-sm-pull-", size )

                SmallPushColumn size ->
                    ( "col-sm-pull-", size )

                ExtraSmallColumn size ->
                    ( "col-xs-", size )

                ExtraSmallOffsetColumn size ->
                    ( "col-xs-offset-", size )

                ExtraSmallPullColumn size ->
                    ( "col-xs-offset-", size )

                ExtraSmallPushColumn size ->
                    ( "col-xs-offset-", size )
    in
        prefix ++ toString size


{-| Docs
-}
buttonClass : ButtonProperty -> String
buttonClass buttonType =
    case buttonType of
        BaseButton ->
            "btn"

        PrimaryButton ->
            "btn-primary"

        NormalButton ->
            "btn-default"

        LargeButton ->
            "btn-lg"

        SmallButton ->
            "btn-sm"

        ExtraSmallButton ->
            "btn-xs"

        SuccessButton ->
            "btn-success"
