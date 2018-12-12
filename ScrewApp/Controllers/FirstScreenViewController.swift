//
//  FirstScreenViewController.swift
//  ScrewApp
//
//  Created by Vinicius Leal on 12/12/18.
//  Copyright © 2018 The Casatiellos. All rights reserved.
//

import UIKit

class FirstScreenViewController: UIViewController {
    @IBOutlet weak var startGameSpot: UIImageView!
    @IBOutlet weak var cardToDrag: UIImageView!
    @IBOutlet weak var optionsSpot: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.cardToDrag)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.cardToDrag)
        
        if recognizer.state == UIGestureRecognizer.State.ended {
            if(cardToDrag.frame.minY < startGameSpot.frame.maxY){
                
                
                self.performSegue(withIdentifier: "CardGameSegue", sender: self)
            } else {
                
                
                // 1
                let velocity = recognizer.velocity(in: self.view)
                let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
                let slideMultiplier = magnitude / 10000
                print("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
                
                // 2
                let slideFactor = 0.5 * slideMultiplier     //Increase for more of a slide
                // 3
                var finalPoint = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
                // 4
                finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
                finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
                
                // 5
                UIView.animate(withDuration: Double(slideFactor * 2),
                               delay: 0,
                               // 6
                    options: UIView.AnimationOptions.curveEaseOut,
                    animations: {recognizer.view!.center = finalPoint },
                    completion: nil)
            }
        }
        
        
    }
}
