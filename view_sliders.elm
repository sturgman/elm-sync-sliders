module Sliders exposing (..)

import Html exposing (Html, input, text, div,h4,span)
import Html.Lazy exposing (lazy)
import Html.Attributes as A exposing (type_,value,min,max,step) 
import Html.Events exposing (on, targetValue, onInput,onMouseEnter,onMouseLeave,onFocus)
import Json.Decode as Json
import String as S
import List

-- Sliders                
    
type alias Context = String

type alias SliderConf msg =
    { min : String
    , max : String
    , step : String
    , label : String
    , style : List (Html.Attribute msg)
    , updtmsg : String  -> msg
    }


sliderView c context =
    let
        renderMyNumber = renderNumberInput c 
    in 
    div []
        [ text (c.label ++ ":")
        , div []
            [ input (List.append c.style
                         [ type_ "range"
                         , onInput c.updtmsg 
                         , A.max c.max
                         , A.min c.min
                         , step c.step
                         , value context
                         ]
                    ) []
                    
            , span []
                -- The lazy here necessary to prevent continuous update as the model integrates.
                [ lazy renderMyNumber context
                ] 
            ]
       ]
            
renderNumberInput c context =
    input (List.append c.style
               [type_ "number"
               , onchange c.updtmsg
               , A.max c.max
               , A.min c.min
               , A.step c.step
               , value context
               ]
          ) []

onchange tagger = on "change" (Json.map tagger targetValue)

    
