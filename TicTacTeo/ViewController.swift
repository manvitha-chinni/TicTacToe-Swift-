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
    var board : [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initBoard()
    }
    
    @IBAction func SelectedButton(_ sender: UIButton) {
        addToBoard(sender)
        if (fullBoard()){
            resultAlert(title: "Draw")
        }
    }
    
    func initBoard(){
        board.append(a1Button)
        board.append(a2Button)
        board.append(a3Button)
        board.append(b1Button)
        board.append(b2Button)
        board.append(b3Button)
        board.append(c1Button)
        board.append(c2Button)
        board.append(c3Button)
    }
    func resultAlert(title: String){
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { _ in
            print("resetting borad")
            self.resetBoard()
        }))
        present(ac, animated: true)
    }
    func resetBoard(){
        for button in board{
            button.setAttributedTitle(nil, for: .normal)
            button.setTitle("", for: .normal)
            button.isEnabled = true
        }
        if(firstTurn == Turn.O){
            firstTurn = Turn.X
            turnLabel.text  = "X's Turn"
        }
        else if (firstTurn == Turn.X){
            firstTurn = Turn.O
            turnLabel.text  = "O's Turn"
        }
        currentTurn = firstTurn
    }
    
    func fullBoard() ->Bool{
        for button in board{
            if button.currentAttributedTitle == nil{
                return false
            }
        }
        return true
    }
    func addToBoard(_ sender: UIButton){
        if(sender.currentAttributedTitle == nil){
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

