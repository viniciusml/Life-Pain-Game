//
//  ResultsScreen.swift
//  ScrewApp
//
//  Created by Roberta Milano on 14/12/2018.
//  Copyright © 2018 The Casatiellos. All rights reserved.
//

import UIKit

class ResultsScreenViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultImg1: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var wrongGuesses =  GameSession.sharedInstance.wrongGuesses
    var percentWrongGuesses: Double = 0
   
    
    @IBAction func menuButton(_ sender: UIButton) {
    }
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        percentWrongGuesses = caluculatePercentWrongGuesses()
        setScreenImage()
    }

    func caluculatePercentWrongGuesses () -> Double {
        var percentWrongGuesses = Double(wrongGuesses) / Double(10)
        percentWrongGuesses *= 100
        return percentWrongGuesses

    }

    func setScreenImage() {
        if(percentWrongGuesses < 33) {
            titleLabel.text = "testo <33 da modificare"
            resultImg1.image = UIImage(named: "cardIcon1")
            resultLabel.text = "testo <33 da modificare"
        }
        else if (percentWrongGuesses < 66){
            titleLabel.text = "testo <66 da modificare"
            resultImg1.image = UIImage(named: "cardIcon2")
            resultLabel.text = "testo <66 da modificare"
            
        }
        else {
            titleLabel.text = "testo >66 da modificare"
            resultImg1.image = UIImage(named: "cardIcon3")
            resultLabel.text = "testo >66 da modificare"
            
        }
    
    
//    @IBAction func playAgainButtonPressed(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
    
    
    }
}
