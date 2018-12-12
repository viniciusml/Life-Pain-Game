//
//  RatedCardsCollectionViewCell.swift
//  ScrewApp
//
//  Created by Yvan on 11/12/2018.
//  Copyright © 2018 The Casatiellos. All rights reserved.
//

import UIKit

class RatedCardsCollectionViewCell: UICollectionViewCell {
    
    var delegate: RatedCardCollectionViewCellDelegate?
    
    @IBOutlet weak var ratedCardsCollectionViewCellIcon: UIImageView!
    @IBOutlet weak var ratedCardsCollectionViewCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
        
        self.addGestureRecognizer(longGesture)
    }
    
    @objc func cellTapped(_ sender: UILongPressGestureRecognizer) {
        delegate?.longTapped(sender: sender, cell: self)
    }
}

protocol RatedCardCollectionViewCellDelegate: class {
    func longTapped(sender: UILongPressGestureRecognizer, cell: RatedCardsCollectionViewCell)
}
