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
    private var score: Int
    
    static var sharedInstance = GameSession()
    
    init() {
        score = 0
    }
    
    func getScore () -> Int {
        return score
    }
    
//    func getGameData() -> GameData {}
}
