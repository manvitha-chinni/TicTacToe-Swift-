//
//  ModeViewController.swift
//  TicTacTeo
//
//  Created by Manvitha on 29/08/25.
//

import UIKit


enum Modes: Int{
    case Dumb = 0
    case Easy = 1
    case Hard = 2
}

class ModeViewController: UIViewController {

    @IBOutlet weak var selectMode: UISegmentedControl!
    
    static var selectedMode: Modes = .Easy
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ModeSelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            ModeViewController.selectedMode = .Dumb
        case 1:
            ModeViewController.selectedMode = .Easy
        case 2:
            ModeViewController.selectedMode = .Hard
        default:
            break
        }
        
        print("mode: \(ModeViewController.selectedMode)")
        
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
