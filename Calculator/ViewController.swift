//
//  ViewController.swift
//  Calculator
//
//  Created by Mikhail Kareniuhin on 3/29/16.
//  Copyright © 2016 Mikhail Kareniuhin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation : String {
        case Add = "+"
        case Subtract = "-"
        case Divide = "/"
        case Multiply = "*"
        case Equal = "="
        case Empty = ""
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var runningNumber: String = ""
    var leftValStr: String = ""
    var rightValStr: String = ""
    
    var currentOperation: Operation = .Empty
    
    var btnSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
       
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numButtonPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
        
    }
    
    @IBAction func onDividePressed(sender: UIButton) {
        processOperation(.Divide)
    }

    @IBAction func onMultiplyPressed(sender: UIButton) {
        processOperation(.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: UIButton) {
        processOperation(.Subtract)
    }
    
    @IBAction func onAddPressed(sender: UIButton) {
        processOperation(.Add)
    }
    
    @IBAction func onEqualPressed(sender: UIButton) {
        processOperation(.Equal)
    }
    
    @IBAction func onClearClick(sender: UIButton) {
        if runningNumber == "" {
            runningNumber = ""
            leftValStr = ""
            rightValStr = ""
            outputLbl.text = "0.0"
            currentOperation = .Empty
        } else {
            runningNumber = ""
            outputLbl.text = "0.0"
        }
        
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if (currentOperation != .Empty) {
            if (runningNumber == "" && currentOperation == op || runningNumber != "") {
                rightValStr = runningNumber == "" ? leftValStr : runningNumber
                switch currentOperation {
                case .Add:
                    leftValStr = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    runningNumber = ""
                    currentOperation = op
                    outputLbl.text = leftValStr
                    break
                case .Divide:
                    leftValStr = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    runningNumber = ""
                    currentOperation = op
                    outputLbl.text = leftValStr
                case .Multiply:
                    leftValStr = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    runningNumber = ""
                    currentOperation = op
                    outputLbl.text = leftValStr
                case .Subtract:
                    leftValStr = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    runningNumber = ""
                    currentOperation = op
                    outputLbl.text = leftValStr
                default:
                    currentOperation = op
                    outputLbl.text = leftValStr
                    runningNumber = ""
                }
            } else {
                currentOperation = op
            }
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
}

