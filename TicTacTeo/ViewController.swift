//
//  ViewController.swift
//  TicTacTeo
//
//  Created by Manvitha on 18/08/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var turnLabel: UILabel!

    @IBOutlet weak var a1Button: UIButton!
    @IBOutlet weak var a2Button: UIButton!
    @IBOutlet weak var a3Button: UIButton!
    @IBOutlet weak var b1Button: UIButton!
    @IBOutlet weak var b2Button: UIButton!
    @IBOutlet weak var b3Button: UIButton!
    @IBOutlet weak var c1Button: UIButton!
    @IBOutlet weak var c2Button: UIButton!
    @IBOutlet weak var c3Button: UIButton!
    
    enum Turn{
        case O
        case X
    }
    let xAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 80, weight: .heavy),
        .foregroundColor: UIColor.systemBlue
    ]
    let oAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 80, weight: .heavy),
        .foregroundColor: UIColor.systemRed
    ]
    
    var firstTurn  = Turn.X
    var currentTurn = Turn.X
    
    let NOUGHT = "O"
    let CROSS = "X"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func SelectedButton(_ sender: UIButton) {
        addToBoard(sender)
    }
    
    func addToBoard(_ sender: UIButton){
        if(sender.currentTitle == nil && sender.currentAttributedTitle == nil){
            var attributeTitle: NSAttributedString?
            
            if(currentTurn == Turn.O){
                attributeTitle = NSAttributedString(string: NOUGHT, attributes: oAttributes)
//                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.X
                turnLabel.text  = "X's Turn"
            }
            else if(currentTurn == Turn.X){
                attributeTitle = NSAttributedString(string: CROSS, attributes: xAttributes)
//                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.O
                turnLabel.text = "O's Turn"
            }
            sender.setAttributedTitle(attributeTitle!, for: .normal)
            sender.isEnabled = false
        }
    }

}

