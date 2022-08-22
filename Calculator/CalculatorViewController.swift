//
//  CalculatorViewController.swift
//  Calculator
//

import UIKit
import ChameleonFramework

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var isFinishedTyping = true
    
    private var displayValue: Double {
        get {
            guard let displayText = Double(displayLabel.text!) else {
                fatalError("Cannot convert display.text to Double!")
            }
            return displayText
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTyping = true
        
        if let calcMethod = sender.currentTitle {
            if calcMethod == "+/-" {
                displayValue *= -1
            } else if calcMethod == "AC" {
                displayLabel.text = "0"
            } else if calcMethod == "%" {
                displayValue *= 0.01
            }
        }
    }
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.15) {
            sender.backgroundColor = RandomFlatColor()
            sender.titleLabel?.textColor = ContrastColorOf((sender.backgroundColor ?? HexColor("1D9BF6"))!, returnFlat: true)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                sender.backgroundColor = HexColor("1D9BF6")
                sender.titleLabel?.textColor = .white
            }
        }
        
        if let numVal = sender.currentTitle{
            
            if isFinishedTyping {
                displayLabel.text = numVal
                isFinishedTyping = false
            } else {
                if displayLabel.text!.range(of:".") != nil {
                    if numVal != "." {
                        displayLabel.text = displayLabel.text! + numVal
                    } else {
                        return
                    }
                } else {
                    displayLabel.text = displayLabel.text! + numVal
                }
                
                isFinishedTyping = false
                
                if let calcMethod = sender.currentTitle {
                    
                    if calcMethod == "AC"{
                        displayLabel.text = "0"
                    } else {
                        if calcMethod == "+/-"{
                            displayLabel.text = String(displayValue * -1)
                        } else if calcMethod == "%"{
                            displayLabel.text = String(displayValue / 100)
                        }
                    }
                }
            }
            
        }
        
    }
}
