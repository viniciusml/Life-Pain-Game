//
//  CardGameViewController.swift
//  ScrewApp
//
//  Created by Yvan on 10/12/2018.
//  Copyright © 2018 The Casatiellos. All rights reserved.
//

import UIKit
import MobileCoreServices

class CardGameViewController: UIViewController/*, UIDropInteractionDelegate*/ {
    
    
    @IBOutlet weak var userHandCollectionView: UICollectionView!
    
    @IBOutlet weak var ratedCardsCollectionView: UICollectionView!
    
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
        
//        Enabling Drag and Drop in collection views
        ratedCardsCollectionView.dropDelegate = self
        userHandCollectionView.dragDelegate = self
        ratedCardsCollectionView.dragDelegate = self
        userHandCollectionView.dragInteractionEnabled = true
        
    }
    
}


extension CardGameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDropDelegate, UICollectionViewDragDelegate
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
            //            cell.ratedCardsCollectionViewCellLabel.text = ratedCards [indexPath.item].pointsOfPain as! String
            return cell
        }
        else {
            let cell = userHandCollectionView.dequeueReusableCell(withReuseIdentifier: "userHandCollectionViewCell", for: indexPath) as! userHandCollectionViewCell
            
            cell.userHandCollectionViewCellIcon.image = userHand[indexPath.item].cardIcon
            return cell
            
        }
        
    }
    
    
    //    Drag related functions
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem]
    {
        let provider = NSItemProvider(object: userHand[indexPath.row].cardIcon)
        let dragItem = UIDragItem(itemProvider: provider)
        return [dragItem]
        
    }
    
    //    Drop related functions
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.hasItemsConforming(toTypeIdentifiers: [kUTTypeImage as String])
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator)
    {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        
        let items = coordinator.items
            
            for item in items {
                item.dragItem.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: {(newImage, error)  -> Void in
                    
                    self.ratedCards.insert(self.userHand[0], at: destinationIndexPath.row)
                    
                    DispatchQueue.main.async {
                        self.ratedCardsCollectionView.insertItems(at: [destinationIndexPath])
                    }
                }
            )}
    }
    
    
    //    func scaleImage (image:UIImage, width: CGFloat) -> UIImage {
    //        let oldWidth = image.size.width
    //        let scaleFactor = width / oldWidth
    //
    //        let newHeight = image.size.height * scaleFactor
    //        let newWidth = oldWidth * scaleFactor
    //
    //        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
    //        image.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
    //        let newImage = UIGraphicsGetImageFromCurrentImageContext()
    //        UIGraphicsEndImageContext()
    //        return newImage!
    //    }
    //
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate
        session: UIDropSession, withDestinationIndexPath destinationIndexPath:
        IndexPath?) -> UICollectionViewDropProposal
    {
        
        if session.localDragSession != nil {
            return UICollectionViewDropProposal(operation: .move,
                                                intent: .insertAtDestinationIndexPath)
        } else {
            return UICollectionViewDropProposal(operation: .move,
                                                intent: .insertAtDestinationIndexPath)
        }
        
    }
    
}
