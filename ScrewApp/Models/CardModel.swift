//
//  CardModel.swift
//  ScrewApp
//
//  Created by Yvan on 10/12/2018.
//  Copyright © 2018 The Casatiellos. All rights reserved.
//

import Foundation
import UIKit

struct CardModel: Equatable, Comparable {

//  TODO: implement cardId
//    var cardId : String
    
    var cardIcon : UIImage
    var pointsOfPain : Int
    var cardDescription: String
    
    
    init (cardIcon : UIImage, pointsOfPain : Int, cardDescription : String)
    {
        self.cardIcon = cardIcon
        self.pointsOfPain = pointsOfPain
        self.cardDescription = cardDescription
  
    }
    
    static func < (lhs: CardModel, rhs: CardModel) -> Bool {
        return lhs.pointsOfPain < rhs.pointsOfPain
    }
    
    static func > (lhs: CardModel, rhs: CardModel) -> Bool {
        return lhs.pointsOfPain > rhs.pointsOfPain
    }
    
    static func <= (lhs: CardModel, rhs: CardModel) -> Bool {
        return lhs.pointsOfPain <= rhs.pointsOfPain
    }
    
    static func >= (lhs: CardModel, rhs: CardModel) -> Bool {
        return lhs.pointsOfPain >= rhs.pointsOfPain
    }
    
}
