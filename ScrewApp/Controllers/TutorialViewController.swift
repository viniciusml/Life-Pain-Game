//
//  CardGameViewController.swift
//  ScrewApp
//
//  Created by Yvan on 10/12/2018.
//  Copyright © 2018 The Casatiellos. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreGraphics

class TutorialViewController: UIViewController {
    
    
    @IBOutlet weak var userHandCollectionView: UICollectionView!
    @IBOutlet weak var ratedCardsCollectionView: UICollectionView!
    @IBOutlet weak var userHandCardDescription: UILabel!
    @IBOutlet weak var pointsOfPainLabel: UILabel!
    @IBOutlet weak var ratedCardPressedCell: UITableViewCell!
    @IBOutlet weak var cardsLeftLable: UILabel!
    @IBOutlet weak var tutorialTipLabel: UILabel!

    
    //
    var cardsDeck = CardFactory.sharedInstance.createCards(quantity: Constants.CARD_DECK_SIZE)
    
    var userHand = [CardModel]()
    var ratedCards = [CardModel]()
    var measuringPoint = 0
    var userScore = 0
    var tutorialPageCounter = 0
    
    let tutorialLabelStrings = [
    "Each card describes a painful situation. Try to guess its value in Points of Pain by dragging and dropping the card in the deck.",
    "There’s no wrong guess! Each time you choose a different value for a card, WeFail will update the score for the whole community."
    ]
    
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
    
    @IBAction func tutorialSkipButtonListener (_ sender: UIButton)
    {
        tutorialPageCounter = tutorialPageCounter + 1
        loadTutorialPage()
    }
    
    func loadTutorialPage ()
    {
        switch tutorialPageCounter {
            case 0:
                tutorialTipLabel.text = tutorialLabelStrings [0]
                break
            
            case 1:
                let handIcon = UIImageView( frame: CGRect (x: 55, y: 31, width: 76, height: 86) )
                handIcon.image = UIImage (named: "hand-cursor")
                self.view.addSubview(handIcon)
                handIcon.contentMode = UIView.ContentMode.scaleToFill
                centerHandIcon(icon: handIcon)
//                while tutorialPageCounter == 1 { animateHandIcon(icon: handIcon)}
                animateHandIcon(icon: handIcon)
            case 2:
                tutorialTipLabel.text = tutorialLabelStrings [1]
                break
            case 3:
                self.performSegue(withIdentifier: "CardGameTutorialSegue", sender: self)
                break
            default:
                break
            
        }
        
    }
    
    func animateHandIcon (icon: UIImageView)
    {
        UIView.animate(
            withDuration: 2.5,
            delay: 0.0,
            options: .curveEaseInOut,
            animations: {
                icon.frame.origin.x = self.ratedCardsCollectionView.frame.origin.x
                icon.frame.origin.y = self.ratedCardsCollectionView.frame.origin.y
        },
            completion: { (finished: Bool) in
                icon.isHidden = true
        })
    }
    
    func centerHandIcon (icon: UIImageView)
    {
        icon.frame.origin.x = self.ratedCardPressedCell.frame.origin.x
        icon.frame.origin.y = self.ratedCardPressedCell.frame.origin.y
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
