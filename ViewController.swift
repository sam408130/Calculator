//
//  ViewController.swift
//  Calculator
//
//  Created by Tyler Simko on 1/28/15.
//  Copyright (c) 2015 Tyler Simko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    var userIsTypingANumber: Bool = false
    
    var brain = CalculatorBrain()
    
    var numberContainsDecimal: Bool = false
    
    var displayValue: Double {
        get {
        //computes value to return
            if displayLabel.text == "π" { return M_PI }
            
            return NSNumberFormatter().numberFromString(displayLabel.text!)!.doubleValue
        }
        
        set {
        //computes value to set
            displayLabel.text = "\(newValue)"
            userIsTypingANumber = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsTypingANumber {
            if digit == "." && !numberContainsDecimal {
                numberContainsDecimal = true
            } else if digit == "." && numberContainsDecimal { return }
            displayLabel!.text = displayLabel!.text! + digit
        } else {
            displayLabel!.text = digit
            userIsTypingANumber = true
        }
    }

    @IBAction func enterKeyPressed() {
        userIsTypingANumber = false
        numberContainsDecimal = false
        
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            //will make displayValue an optional for Assignment 2.
            displayValue = 0
        }
    }
    
    @IBAction func operate(sender: UIButton) {

        if userIsTypingANumber { enterKeyPressed() }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
}