//
//  ViewController.swift
//  TicTacTeo
//
//  Created by Manvitha on 18/08/25.
//

import UIKit

class TwoPlayerViewController: UIViewController {

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
    

    var board : [UIButton] = []
    
    var XScore = 0
    var OScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initBoard()
        turnLabel.text = firstTurn == .X ? "X's Turn" : "O's Turn"
    }
    
    @IBAction func SelectedButton(_ sender: UIButton) {
        addToBoard(sender)
        if(checkForVictory("X")){
            XScore += 1
            resultAlert(title: "X won Victory ")
        }
        else if checkForVictory("O"){
            OScore += 1
            resultAlert(title: "O won Victory")
        }
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
    func checkForVictory(_ s: String) -> Bool{
        
        //Horizontal check
        if thisSymbol(a1Button, s) && thisSymbol(a2Button, s) && thisSymbol(a3Button, s){
            a1Button.backgroundColor = UIColor(named: "WinColor")
            a2Button.backgroundColor = UIColor(named: "WinColor")
            a3Button.backgroundColor = UIColor(named: "WinColor")
            return true
        }
        if thisSymbol(b1Button, s) && thisSymbol(b2Button, s) && thisSymbol(b3Button, s){
            b1Button.backgroundColor = UIColor(named: "WinColor")
            b2Button.backgroundColor = UIColor(named: "WinColor")
            b3Button.backgroundColor = UIColor(named: "WinColor")
            return true
        }
        if thisSymbol(c1Button, s) && thisSymbol(c2Button, s) && thisSymbol(c3Button, s){
            c1Button.backgroundColor = UIColor(named: "WinColor")
            c2Button.backgroundColor = UIColor(named: "WinColor")
            c3Button.backgroundColor = UIColor(named: "WinColor")
            return true
        }
        
        //verticle check
        if thisSymbol(a1Button, s) && thisSymbol(b1Button, s) && thisSymbol(c1Button, s){
            a1Button.backgroundColor = UIColor(named: "WinColor")
            b1Button.backgroundColor = UIColor(named: "WinColor")
            c1Button.backgroundColor = UIColor(named: "WinColor")
            return true
        }
        if thisSymbol(a2Button, s) && thisSymbol(b2Button, s) && thisSymbol(c2Button, s){
            a2Button.backgroundColor = UIColor(named: "WinColor")
            b2Button.backgroundColor = UIColor(named: "WinColor")
            c2Button.backgroundColor = UIColor(named: "WinColor")
            return true
        }
        if thisSymbol(a3Button, s) && thisSymbol(b3Button, s) && thisSymbol(c3Button, s){
            a3Button.backgroundColor = UIColor(named: "WinColor")
            b3Button.backgroundColor = UIColor(named: "WinColor")
            c3Button.backgroundColor = UIColor(named: "WinColor")
            return true
        }
        
        
        //cross check
        if thisSymbol(a1Button, s) && thisSymbol(b2Button, s) && thisSymbol(c3Button, s){
            a1Button.backgroundColor = UIColor(named: "WinColor")
            b2Button.backgroundColor = UIColor(named: "WinColor")
            c3Button.backgroundColor = UIColor(named: "WinColor")
            return true
        }
        if thisSymbol(c1Button, s) && thisSymbol(b2Button, s) && thisSymbol(a3Button, s){
            c1Button.backgroundColor = UIColor(named: "WinColor")
            b2Button.backgroundColor = UIColor(named: "WinColor")
            a3Button.backgroundColor = UIColor(named: "WinColor")
            return true
        }
            
            
            
        return false
    }
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool{
        return button.attributedTitle(for: .normal)?.string == symbol
    }
    func resultAlert(title: String){
        let message = "X Score: \(XScore)\nO Score: \(OScore)"
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { _ in
            print("resetting borad")
            self.resetBoard()
        }))
        present(ac, animated: true)
    }
    func resetBoard(){
        for button in board{
            button.backgroundColor = .systemBackground
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
                attributeTitle = NSAttributedString(string: "O", attributes: oAttributes)
//                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.X
                turnLabel.text  = "X's Turn"
            }
            else if(currentTurn == Turn.X){
                attributeTitle = NSAttributedString(string: "X", attributes: xAttributes)
//                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.O
                turnLabel.text = "O's Turn"
            }
            sender.setAttributedTitle(attributeTitle!, for: .normal)
            sender.isEnabled = false
        }
    }
    
    

}

