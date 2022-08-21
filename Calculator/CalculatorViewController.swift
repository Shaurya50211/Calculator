//
//  CalculatorViewController.swift
//  Calculator
//

import UIKit
import ChameleonFramework

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var isFinishedTyping = true
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTyping = true
        
        guard let number = Double(displayLabel.text!) else {
            fatalError("Cannot convert display label text to a Double")
        }
        
        if let calcMethod = sender.currentTitle {
            if calcMethod == "+/-" {
                displayLabel.text = String(number * -1)
            } else if calcMethod == "AC" {
                displayLabel.text = "0"
            } else if calcMethod == "%" {
                displayLabel.text = String(number / 100)
            }
        }
    }
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        //
        //        sender.backgroundColor = RandomFlatColor()
        //        sender.titleLabel?.textColor = ContrastColorOf((sender.backgroundColor ?? HexColor("1D9BF6"))!, returnFlat: true)
        
        // then start the animation
        UIView.animate(withDuration: 0.15) {
            sender.backgroundColor = RandomFlatColor()
            sender.titleLabel?.textColor = ContrastColorOf((sender.backgroundColor ?? HexColor("1D9BF6"))!, returnFlat: true)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                sender.backgroundColor = HexColor("1D9BF6")
                sender.titleLabel?.textColor = .white
            }
        }
        
        
        //What should happen when a number is entered into the keypad
        if let numVal = sender.currentTitle{
            
            if isFinishedTyping {
                displayLabel.text = numVal
                isFinishedTyping = false
            } else {
                if displayLabel.text!.range(of:".") != nil {
                    if numVal != "."{ // Check wether the user wants to enter another .
                        displayLabel.text = displayLabel.text! + numVal
                    } else { // if so, return
                        return
                    }
                } else {
                    // if the range of "." is nil, just enter the value without any check on "."
                    displayLabel.text = displayLabel.text! + numVal
                }
                
                //What should happen when a non-number button is pressed
                isFinishedTyping = true
                
                if let calcMethod = sender.currentTitle {
                    
                    if calcMethod == "AC"{
                        displayLabel.text = "0"
                    } else {
                        guard let number = Double(displayLabel.text!) else {
                            fatalError("Error converting displaylabel.text to a Double!")
                        }
                        if calcMethod == "+/-"{
                            displayLabel.text = String(number * -1)
                        } else if calcMethod == "%"{
                            displayLabel.text = String(number / 100)
                        }
                    }
                }
            }
            
        }
        
    }
}
