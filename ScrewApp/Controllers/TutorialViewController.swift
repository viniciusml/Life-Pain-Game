//
//  CardGameViewController.swift
//  ScrewApp
//
//  Created by Yvan on 10/12/2018.
//  Copyright © 2018 The Casatiellos. All rights reserved.
//

import UIKit
import MobileCoreServices

class TutorialViewController: UIViewController {
    
    
    @IBOutlet weak var userHandCollectionView: UICollectionView!
    @IBOutlet weak var ratedCardsCollectionView: UICollectionView!
    @IBOutlet weak var userHandCardDescription: UILabel!
    
    @IBOutlet weak var ratedCardPressedIcon: UIImageView!
    @IBOutlet weak var pointsOfPainLabel: UILabel!
    @IBOutlet weak var ratedCardPressedCell: UITableViewCell!
    @IBOutlet weak var cardsLeftLable: UILabel!
    
    //
    var cardsDeck = CardFactory.sharedInstance.createCards(quantity: Constants.CARD_DECK_SIZE)
    
    var userHand = [CardModel]()
    var ratedCards = [CardModel]()
    var measuringPoint = 0
    var userScore = 0
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        userHand = deckGeneration(cardsArray: &cardsDeck, deckSize: Constants.CARD_DECK_SIZE)
        
        ratedCards  = deckGeneration(cardsArray: &userHand, deckSize: 3).sorted { $0 < $1}
        
        userHandCardDescription.text = userHand[0].cardDescription
        print(userHand[0].pointsOfPain)
        
    }
    
    func deckGeneration ( cardsArray: inout [CardModel], deckSize : Int) -> [CardModel]
    {
        var playerDecArray = [CardModel]()
        while playerDecArray.count != deckSize {
            let randomCard = cardsArray.randomElement()!
            if let i = cardsArray.index(of: randomCard) {
                cardsArray.remove(at: i)
                playerDecArray.append(randomCard)
            }
        }
        
        return playerDecArray
    }
    
}


extension TutorialViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    
    //    COLLECTION VIEW POPULATING
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == self.ratedCardsCollectionView { return ratedCards.count }
        else { return 1 }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == self.ratedCardsCollectionView
        {
            let cell = ratedCardsCollectionView.dequeueReusableCell(withReuseIdentifier: "ratedCardsCollectionViewCell", for: indexPath) as! RatedCardsCollectionViewCell
            
            cell.ratedCardsCollectionViewCellIcon.image = ratedCards [indexPath.item].cardIcon
            //TODO: convert int to string to fit label
            let pointsOfPainString = String(ratedCards[indexPath.row].pointsOfPain)
            cell.ratedCardsCollectionViewCellLabel.text = pointsOfPainString
            
//            cell.delegate = self
            
            return cell
        }
        else {
            let cell = userHandCollectionView.dequeueReusableCell(withReuseIdentifier: "userHandCollectionViewCell", for: indexPath) as! userHandCollectionViewCell
            
            cell.userHandCollectionViewCellIcon.image = userHand[indexPath.item].cardIcon
            return cell
            
        }
        
    }

}
