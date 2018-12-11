//
//  CardFactory.swift
//  ScrewApp
//
//  Created by Yvan on 10/12/2018.
//  Copyright © 2018 The Casatiellos. All rights reserved.


/// This class is used to create cards based on the cards model and pass them to the cards view controller.
///
/// The method createCards accepts as input the number of cards it has to generate and outputs an array of instantiated cards
///
///
///
///
///
///
///
///
///
///
///
///
///


import Foundation

public class CardFactory {
    
    func createCards (/*quantity : Int*/) -> [CardModel] {
        
        var cardsArray : [CardModel]
        
        cardsArray =
            [card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12, card13, card14,card15,card16,
             card17, card18, card19, card20]
        
        return cardsArray
    }
    
 
}
