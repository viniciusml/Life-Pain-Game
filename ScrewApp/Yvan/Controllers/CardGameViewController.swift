//
//  CardGameViewController.swift
//  ScrewApp
//
//  Created by Yvan on 10/12/2018.
//  Copyright © 2018 The Casatiellos. All rights reserved.
//

import UIKit
import MobileCoreServices

class CardGameViewController: UIViewController {
    
    var cardsArray = [card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12, card13, card14,card15,card16, card17, card18, card19, card20]
    
    var userHand = [CardModel]()
    var ratedCards = [CardModel]()
    var measuringPoint = 0
 
    
    func deckGeneration ( cardsArray: inout [CardModel], deskSize : Int) -> [CardModel] {
        var playerDecArray = [CardModel]()
        
        while playerDecArray.count != deskSize {
            let randomCard = cardsArray.randomElement()!
            if let i = cardsArray.index(of: randomCard) {
                cardsArray.remove(at: i)
                playerDecArray.append(randomCard)
            }
        }
        
        return playerDecArray
    }
    
    func painAssessment(_ indexOfRight: Int) -> Int {
        measuringPoint = userHand[0].pointsOfPain
        
        switch indexOfRight {
            
        case 0:
            print("left")
            if measuringPoint < ratedCards[0].pointsOfPain {
                ratedCards.insert(userHand[0], at: 0)
            }
            else {
                measuringPoint = (ratedCards[0].pointsOfPain + measuringPoint)/2
                userHand[0].pointsOfPain = measuringPoint
            }
            
        case ratedCards.count :
            print("right")
            if measuringPoint > ratedCards[ratedCards.count-1].pointsOfPain {
                ratedCards.insert(userHand[0], at: ratedCards.count)
            }
            else {
                measuringPoint = (ratedCards[ratedCards.count-1].pointsOfPain + measuringPoint)/2
                userHand[0].pointsOfPain = measuringPoint
            }
            
        default:
            print("between")
            let left = ratedCards[indexOfRight - 1].pointsOfPain
            let right = ratedCards[indexOfRight].pointsOfPain
            if left < measuringPoint && measuringPoint < right {
                ratedCards.insert(userHand[0], at: indexOfRight)
            }
            else {
                measuringPoint = (left + right + measuringPoint)/3
                userHand[0].pointsOfPain = measuringPoint
            }
            
        }
        
        userHand.removeFirst()
        return measuringPoint
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userHand = deckGeneration(cardsArray: &cardsArray, deskSize: 13)
        ratedCards  = deckGeneration(cardsArray: &userHand, deskSize: 3).sorted { $0 < $1}
        
        for i in ratedCards {
            print(i.pointsOfPain)
        }

        // Do any additional setup after loading the view.
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
