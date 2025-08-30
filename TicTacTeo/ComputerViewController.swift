//
//  ComputerViewController.swift
//  TicTacTeo
//
//  Created by Manvitha on 29/08/25.
//

import UIKit

class ComputerViewController: UIViewController {
    
    // X - Player, O - Computer
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var board : [UIButton] = []
    
    let xAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 80, weight: .heavy),
        .foregroundColor: UIColor.systemBlue
    ]
    let oAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 80, weight: .heavy),
        .foregroundColor: UIColor.systemRed
    ]
    enum Turn{
        case X
        case O
    }
    
    // initial turn human
    var currentTurn = Turn.X
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        turnLabel.text = "Player's Turn"
        initBoard()
    }
    
    
    
    @IBAction func userTap(_ sender: UIButton) {
        if currentTurn == .O {
            return
        }
        addToBoard(sender)
        IntelligentComputerTurn()
        if checkForVictory("X") || checkForVictory("O"){
            resultAlert(title: "Computer won")
            return
        }
        if isFullBoard(){
            resultAlert(title: "Draw")
            return
        }
       
        
    }
    func updateComputerBoard(){
        var count = 0
        for button in board{
            ComputerPlay.board[count] = button.currentAttributedTitle?.string ?? ""
            count += 1
        }
        print(ComputerPlay.board)
    }
    func addToBoard(_ sender: UIButton){
        if sender.currentAttributedTitle != nil{
            return
        }
        var attributeTittle: NSAttributedString!
        if currentTurn == .O {
            attributeTittle = NSAttributedString(string: "O", attributes: oAttributes)
            currentTurn = .X
            turnLabel.text = "Player's Turn"
        }
        else if currentTurn == .X{
            attributeTittle = NSAttributedString(string: "X", attributes: xAttributes)
            currentTurn = .O
        }
        
        sender.setAttributedTitle(attributeTittle, for: .normal)
        sender.isEnabled = false
        updateComputerBoard()

    }
    
    func IntelligentComputerTurn(){
        print("entered Intelligent")
        if let move = ComputerPlay.bestMove(){
            print("move \(move)")
            addToBoard(board[move])
        }
        else{
            print("somthing went wrong")
        }
    }
    func RandomComputerTurn(){
        if isFullBoard(){
            return
        }
        let randomIndex = Int.random(in: 0..<board.count)
        if board[randomIndex].currentAttributedTitle == nil{
            addToBoard(board[randomIndex])
            return
        }
        RandomComputerTurn()
    }
    
    func resetBoard(){
        for button in board{
            button.backgroundColor = .systemBackground
            button.setAttributedTitle(nil, for: .normal)
            button.setTitle("", for: .normal)
            button.isEnabled = true
        }
        currentTurn = .X
        turnLabel.text = "Player's Turn"
        
    }
    func resultAlert(title: String){
        turnLabel .text = "Game Over"
        let ac = UIAlertController(title: title, message: "", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { _ in
            print("resetting borad")
            self.resetBoard()
        }))
        present(ac, animated: true)
    }
    
    func isFullBoard() -> Bool{
        for button in board{
            if button.currentAttributedTitle == nil{
                return false
            }
        }
        return true
    }
    func initBoard(){
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool{
        return button.attributedTitle(for: .normal)?.string == symbol
    }
    func checkForVictory(_ s: String) -> Bool{
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s){
            a1.backgroundColor = UIColor(named: "WinColor")
            a2.backgroundColor = UIColor(named: "WinColor")
            a3.backgroundColor = UIColor(named: "WinColor")
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s){
            b1.backgroundColor = UIColor(named: "WinColor")
            b2.backgroundColor = UIColor(named: "WinColor")
            b3.backgroundColor = UIColor(named: "WinColor")
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s){
            c1.backgroundColor = UIColor(named: "WinColor")
            c2.backgroundColor = UIColor(named: "WinColor")
            c3.backgroundColor = UIColor(named: "WinColor")
            return true
        }
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s){
            a1.backgroundColor = UIColor(named: "WinColor")
            b1.backgroundColor = UIColor(named: "WinColor")
            c1.backgroundColor = UIColor(named: "WinColor")
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s){
            a2.backgroundColor = UIColor(named: "WinColor")
            b2.backgroundColor = UIColor(named: "WinColor")
            c2.backgroundColor = UIColor(named: "WinColor")
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s){
            a3.backgroundColor = UIColor(named: "WinColor")
            b3.backgroundColor = UIColor(named: "WinColor")
            c3.backgroundColor = UIColor(named: "WinColor")
            return true
        }
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s){
            a1.backgroundColor = UIColor(named: "WinColor")
            b2.backgroundColor = UIColor(named: "WinColor")
            c3.backgroundColor = UIColor(named: "WinColor")
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(b2, s) && thisSymbol(a3, s){
            c1.backgroundColor = UIColor(named: "WinColor")
            b2.backgroundColor = UIColor(named: "WinColor")
            a3.backgroundColor = UIColor(named: "WinColor")
            return true
        }
        return false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
