//
//  CardGameViewController.swift
//  ScrewApp
//
//  Created by Yvan on 10/12/2018.
//  Copyright © 2018 The Casatiellos. All rights reserved.
//

import UIKit
import MobileCoreServices

class CardGameViewController: UIViewController, UIDropInteractionDelegate {
    
    @IBOutlet weak var UserHandCollectionView: UICollectionView!
    @IBOutlet weak var RatedCardsCollectionView: UICollectionView!
    
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
        
        UserHandCollectionView.dropDelegate = self
        RatedCardsCollectionView.dropDelegate = self
        UserHandCollectionView.dragDelegate = self
        RatedCardsCollectionView.dragDelegate = self
        
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


extension CardGameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDropDelegate, UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let provider = NSItemProvider(object: userHand[indexPath.row].cardIcon)
        let dragItem = UIDragItem(itemProvider: provider)
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.RatedCardsCollectionView { return ratedCards.count }
        else { return 1 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == self.RatedCardsCollectionView
        {
            let cell = RatedCardsCollectionView.dequeueReusableCell(withReuseIdentifier: "RatedCardsCollectionViewCell", for: indexPath) as! RatedCardsCollectionViewCell
            
            cell.RatedCardsCollectionViewCellIcon.image = ratedCards[indexPath.item].cardIcon
            return cell
        }
        else {
            let cell = RatedCardsCollectionView.dequeueReusableCell(withReuseIdentifier: "RatedCardsCollectionViewCell", for: indexPath) as! RatedCardsCollectionViewCell
            
            cell.RatedCardsCollectionViewCellIcon.image = userHand[indexPath.item].cardIcon
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt userHand: IndexPath, to ratedCards: IndexPath) {
        print("Starting Index: \(userHand.item)")
        print("Ending Index: \(ratedCards.item)")
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        
        switch coordinator.proposal.operation {
        case .move:
            
            let items = coordinator.items
            
            for item in items {
                item.dragItem.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: {(newImage, error)  -> Void in
                    
                    if let image = newImage as? CardModel {
                        //                        if image.size.width > 200 {
                        //                            image = self.scaleImage(image: image, width: 200)
                        //                        }
                        
                        self.ratedCards.insert(image, at: destinationIndexPath.row)
                        
                        print("number of lala \(self.RatedCardsCollectionView.numberOfItems(inSection: 0))")
                        
                        DispatchQueue.main.async {
                            self.RatedCardsCollectionView.insertItems(at: [destinationIndexPath])
                        }
                    }
                })
            }
        default: return
        }
        
    }
    
    func scaleImage (image:UIImage, width: CGFloat) -> UIImage {
        let oldWidth = image.size.width
        let scaleFactor = width / oldWidth
        
        let newHeight = image.size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor
        
        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
        image.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate
        session: UIDropSession, withDestinationIndexPath destinationIndexPath:
        IndexPath?) -> UICollectionViewDropProposal {
        
        if session.localDragSession != nil {
            return UICollectionViewDropProposal(operation: .move,
                                                intent: .insertAtDestinationIndexPath)
        } else {
            return UICollectionViewDropProposal(operation: .move,
                                                intent: .insertAtDestinationIndexPath)
        }
        
    }
    
}
