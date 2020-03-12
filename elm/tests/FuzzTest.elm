module FuzzTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


staticTest : Test
staticTest =
    describe "Test suite"
        [ test "Implement our first test. See https://package.elm-lang.org/packages/elm-explorations/test/latest for how to do this!"
            (\_ -> Expect.equal 4 (2 + 2))
        , test "two plus two equals four"
            (\_ -> Expect.equal 4 (2 + 2))
        ]


addOneTests : Test
addOneTests =
    describe "addOne"
        [ fuzz int "adds 1 to any integer" <|
            \num ->
                addOne num |> Expect.equal (num + 1)
        ]


addOne : Int -> Int
addOne x =
    1 + x



addOneAndOneTests : Test
addOneAndOneTests =
    describe "addOneAndOne"
        [ fuzz2 int int "adds 1 and 1 to any integer" <|
            \num1 num2 ->
                addOneAndOne num1 num2 |> Expect.equal (num1 + 1 + num2)
        ]


addOneAndOne : Int -> Int -> Int
addOneAndOne x y =
   if y >10 then
      1 + x + y
    else
      1 + x * y