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
    @IBOutlet weak var userHandCardDescription: UILabel!
    
    @IBOutlet weak var ratedCardPressedIcon: UIImageView!
    @IBOutlet weak var pointsOfPainLabel: UILabel!
    @IBOutlet weak var ratedCardPressedCell: UITableViewCell!
    @IBOutlet weak var cardsLeftLable: UILabel!
    
    
    var cardsArray = [card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12, card13, card14,card15,card16, card17, card18, card19, card20]
    
    var userHand = [CardModel]()
    var ratedCards = [CardModel]()
    var measuringPoint = 0
    var userScore = 0
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userHand = deckGeneration(cardsArray: &cardsArray, deskSize: 13)
        ratedCards  = deckGeneration(cardsArray: &userHand, deskSize: 3).sorted { $0 < $1}
        userHandCardDescription.text = userHand[0].cardDescription
        print(userHand[0].pointsOfPain)
        //        Enabling Drag and Drop in collection views
        ratedCardsCollectionView.dropDelegate = self
        userHandCollectionView.dragDelegate = self
        ratedCardsCollectionView.dragDelegate = self
        userHandCollectionView.dragInteractionEnabled = true
        
        
        
    }
    
    //    PERFORM SEGUE TO GAME MENU:
    
    @IBAction func menuButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "GameMenuSegue", sender: self)
        
    }
    
    
}


extension CardGameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDropDelegate, UICollectionViewDragDelegate, UIGestureRecognizerDelegate
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
            
            cell.delegate = self
            
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
                self.measuringPoint = self.userHand[0].pointsOfPain
                
                switch destinationIndexPath.row{
                case 0:
                    print("left")
                    if self.measuringPoint <= self.ratedCards[0].pointsOfPain {
                        self.ratedCards.insert(self.userHand[0], at: destinationIndexPath.row)
                        
                        DispatchQueue.main.async {
                            self.ratedCardsCollectionView.insertItems(at: [destinationIndexPath])
                        }
                    } else {
                        self.userHand[0].pointsOfPain = (self.ratedCards[0].pointsOfPain + self.measuringPoint)/2
                        print("recalculated: \(self.userHand[0].pointsOfPain)")
                    }
                    
                case self.ratedCards.count :
                    print("right")
                    if self.measuringPoint >= self.ratedCards[self.ratedCards.count-1].pointsOfPain {
                        self.ratedCards.insert(self.userHand[0], at: destinationIndexPath.row)
                        
                        DispatchQueue.main.async {
                            self.ratedCardsCollectionView.insertItems(at: [destinationIndexPath])
                        }
                        
                    } else {
                        self.userHand[0].pointsOfPain = (self.ratedCards[self.ratedCards.count-1].pointsOfPain + self.measuringPoint)/2
                        print("recalculated: \(self.userHand[0].pointsOfPain)")
                    }
                    
                default :
                    print("between")
                    let left = self.ratedCards[destinationIndexPath.row - 1].pointsOfPain
                    let right = self.ratedCards[destinationIndexPath.row].pointsOfPain
                    if left <= self.measuringPoint && self.measuringPoint <= right {
                        self.ratedCards.insert(self.userHand[0], at: destinationIndexPath.row)
                        
                        DispatchQueue.main.async {
                            self.ratedCardsCollectionView.insertItems(at: [destinationIndexPath])
                        }
                    } else {
                        self.userHand[0].pointsOfPain = (left + right + self.measuringPoint)/3
                        print("recalculated: \(self.userHand[0].pointsOfPain)")
                        
                    }
                    
                    
                }
                
                if self.userHand.count != 1 {
                    self.userHand.removeFirst()
                    DispatchQueue.main.async {
                        self.userHandCollectionView.reloadData()
                        self.userHandCardDescription.text = self.userHand[0].cardDescription
                        self.cardsLeftLable.text = "Cards left: \(self.userHand.count)"
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        self.userHandCollectionView.isHidden = true
                        self.userHandCardDescription.text = "\(self.userScore)% of failures you perceive in the same way as the majority of users."
                    }
                }
                self.userScore = (self.ratedCards.count - 3) * 10
                print(self.userHand[0].pointsOfPain)
                
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

//    LONG GESTURE:
extension CardGameViewController: RatedCardCollectionViewCellDelegate {
    func longTapped(sender: UILongPressGestureRecognizer, cell: RatedCardsCollectionViewCell) {
        
        guard let indexPath = ratedCardsCollectionView.indexPath(for: cell) else {
            return
        }
        if self.userHand.count != 1 {
            if sender.state == .began {
                DispatchQueue.main.async {
                    self.userHandCollectionView.isHidden = true
                    self.userHandCardDescription.text = self.ratedCards[indexPath.row].cardDescription
                    self.ratedCardPressedIcon.isHidden = false
                    self.ratedCardPressedIcon.image = self.ratedCards[indexPath.row].cardIcon
                    self.pointsOfPainLabel.isHidden = false
                    self.pointsOfPainLabel.text = String(self.ratedCards[indexPath.row].pointsOfPain)
                    self.ratedCardPressedCell.isHidden = false
                    
                    
                }
            }
            if sender.state == .ended {
                DispatchQueue.main.async {
                    self.userHandCardDescription.text = self.userHand[0].cardDescription
                    self.ratedCardPressedIcon.isHidden = true
                    self.pointsOfPainLabel.isHidden = true
                    self.userHandCollectionView.isHidden = false
                    self.ratedCardPressedCell.isHidden = true
                    
                }
            }
        }
    }
}
