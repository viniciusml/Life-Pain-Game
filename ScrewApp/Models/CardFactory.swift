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
        //Copy cards data into cardsDataCopyArray and shuffle
        var cardsDataCopy = [CardModel] ()
        for i in 0 ... cardIconData.count - 1 {
            cardsDataCopy.append (CardModel (
                cardIcon: cardIconData [i],
                pointsOfPain: cardPointsOfPainData [i],
                cardDescription: cardDescriptionData [i]))
        }
        cardsDataCopy.shuffle()
        
        //Copy first n shuffled cards into cardsArray and return it
        var cardsArray = [CardModel] ()
        for i in 0 ... 12 {
            cardsArray.append (cardsDataCopy [i])
        }
        
        return cardsArray
    }
    
    
}

