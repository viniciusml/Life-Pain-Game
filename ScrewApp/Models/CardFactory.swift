//
//  CardFactory.swift
//  ScrewApp
//
//  Created by Yvan on 10/12/2018.
//  Copyright © 2018 The Casatiellos. All rights reserved.


/// This class is used to create cards based on the cards model and pass them to the cards view controller.
///
/// The method createCards accepts as input the number of cards it has to generate and outputs an array of instantiated cards


import Foundation

public class CardFactory {
    
    static let sharedInstance = CardFactory()
    
    private init () {
        
    }
    
    func createCards (quantity : Int) -> [CardModel] {
        var cardsArray = [CardModel] ()
        
        for _ in 0 ... quantity {
            let random = Int.random(in: 0...19)
            cardsArray.append(CardModel (cardIcon: cardIconData[random], pointsOfPain: cardPointsOfPainData[random], cardDescription: cardDescriptionData[random]))
        }
        
        return cardsArray
    }
    
    
}
