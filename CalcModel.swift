//
//  CalcModel.swift
//  Calculator
//
//  Created by Sriharsha Makineni on 11/5/16.
//  Copyright © 2016 Sriharsha Makineni. All rights reserved.
//

import Foundation


class CalcModel{
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
   
    
    private var operations: Dictionary<String,Operation>  = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "*" : Operation.BinaryOperation({(op1, op2) in return op1 * op2}), // closures
        "+" : Operation.BinaryOperation({ $0 + $1 }), // can also be written like this, if we use $0,$1 swift infers type and it also infers return type.
        "-" : Operation.BinaryOperation({ $0 - $1 }),
        "/" : Operation.BinaryOperation({ $0 / $1 }),
        "=" : Operation.Equals
    ]
    
    enum Operation{
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String) {
    
        if let operation = operations[symbol] {
            switch operation {
            case .Constant (let associatedConstVal):
                accumulator = associatedConstVal
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingOperation()
            }
        }
    }

    private func executePendingOperation(){
    
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
            pending = nil
        }
    
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        
        var binaryFunction: (Double,Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double{
        get{
            return accumulator
        }
    }

}
