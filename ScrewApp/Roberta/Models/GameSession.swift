//
//  ScoreCalculation.swift
//  ScrewApp
//
//  Created by Roberta Milano on 14/12/2018.
//  Copyright © 2018 The Casatiellos. All rights reserved.
//

import UIKit

class GameSession {
    
//    private var user : UserModel
    var score: Int
    var wrongGuesses: Int = 0
    static var sharedInstance = GameSession()
    
    
    init() { score = 0 }
    
//    func getGameData() -> GameData {}
    
    func increaseErrors()
    {
        wrongGuesses = wrongGuesses + 1
    }
}
