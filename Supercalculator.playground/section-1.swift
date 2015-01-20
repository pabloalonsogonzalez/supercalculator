// Playground - noun: a place where people can play
/*
Pablo Alonso González
*/

import UIKit

typealias Operator = (Double, Double) -> Double

var operators : [Operator] = []
var operands : [Double] = []

func parseChain (chain:String) {
    // delete whitespaces from the chain
    let chainCleaned = chain.stringByReplacingOccurrencesOfString("\\s", withString: "", options: NSStringCompareOptions.RegularExpressionSearch, range: Range<String.Index>(start: chain.startIndex, end: chain.endIndex))
    
    // calculate value of parenthesis and change the chain
    
    // find operands in the chain
    var num : String = ""
    for character in chainCleaned {
        let str = String(character)
        if let digit = str.toInt() {
            num += str
        } else {
            if let number = num.toInt() {
                operands.append(Double(number))
            }
            num = ""
        }
    }
    // append the last operand
    if let number = num.toInt() {
        operands.append(Double(number))
    }
    
    // append the operators
    for character in chainCleaned {
        let str = String(character)
            switch str {
            case "+" :
                operators.append({$0+$1})
            case "-" :
                operators.append({$0-$1})
            case "*" :
                operators.append({$0*$1})
            case "/" :
                operators.append({$0/$1})
            default :
                ()
            }
    }
    
}

func calculator(operand1:Double, operand2:Double, operator1:Operator) -> Double {
    return operator1(operand1,operand2);
}

func calculate(chain:String) -> Double {
    parseChain(chain)
    var res = operands[0]
    for var i = 1; i < operands.count; i++ {
        var op2 = operands[i];
        var operator1 = operators[i-1]
        res = calculator(res, op2, operator1)
    }
    return res
}

calculate("28/7 + 6 *20 / 40")
