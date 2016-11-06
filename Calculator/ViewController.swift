//
//  ViewController.swift
//  Calculator
//
//  Created by Sriharsha Makineni on 11/5/16.
//  Copyright © 2016 Sriharsha Makineni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInMiddleOfTyping = false
    
    @IBAction private func touchDigit(_ sender: UIButton)  {
        let digit = sender.currentTitle!
        
        if userIsInMiddleOfTyping{
            let textInDisplay = display.text!
            display.text = textInDisplay + digit
        }
        else {
            display.text = digit
            
        }
        userIsInMiddleOfTyping = true
    }

    private var displayValue: Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var model = CalcModel()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInMiddleOfTyping {
            model.setOperand(operand: displayValue)
            userIsInMiddleOfTyping = false
        }
        if let mathSymbol = sender.currentTitle{
                model.performOperation(symbol: mathSymbol)
            }
                displayValue = model.result
            
        
        }
   
    }
