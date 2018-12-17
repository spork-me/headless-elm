module IngredientParser exposing (Ingredient, parse)

import Parser exposing ((|.), (|=), Parser, Step, chompWhile, float, getChompedString, loop, spaces, succeed, symbol)


type alias Ingredient =
    { quantity : String
    , unit : String
    , desc : String
    }


parseLine : Parser Ingredient
parseLine =
    succeed Ingredient
        |= (getChompedString <| chompWhile Char.isDigit)
        |. spaces
        |= (getChompedString <| chompWhile (\c -> c /= ' '))
        |. spaces
        |= (getChompedString <| chompWhile (\c -> c /= '\n' || c /= '\u{000D}'))


parse : String -> Ingredient
parse input =
    case Parser.run parseLine input of
        Err err ->
            Ingredient "A" "B" "C"

        Ok result ->
            result