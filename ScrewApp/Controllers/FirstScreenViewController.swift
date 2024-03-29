//
//  FirstScreenViewController.swift
//  ScrewApp
//
//  Created by Vinicius Leal on 12/12/18.
//  Copyright © 2018 The Casatiellos. All rights reserved.
//

import UIKit

class FirstScreenViewController: UIViewController
{
    @IBOutlet weak var startGameSpot: UIImageView!
    @IBOutlet weak var cardToDrag: UIImageView!
    @IBOutlet weak var optionsSpot: UIImageView!
    
    static let defaults = UserDefaults.standard
    let firstLaunch : Bool = isFirstLaunch()
    
    //    UNWIND SEGUE FOR MENU BUTTON:
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        centerCard()
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer)
    {
        let translation = recognizer.translation(in: self.cardToDrag)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.cardToDrag)
        
        if recognizer.state == UIGestureRecognizer.State.ended {
            if(cardToDrag.frame.minY < startGameSpot.frame.maxY){
                if (firstLaunch){
                    self.performSegue(withIdentifier: "TutorialSegue", sender: self)

                } else {
                self.performSegue(withIdentifier: "CardGameSegue", sender: self)
                }
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
    
    func centerCard ()
    {
                cardToDrag.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
    }
    
    static func isFirstLaunch () -> Bool
    {
        if ( defaults.integer (forKey: "launchesNumber") == 0)
        {
            defaults.set(1, forKey: "launchesNumber")
            return true
        } else {
            defaults.set( (
                defaults.integer(forKey: "launchesNumber") + 1),
                          forKey: "launchesNumber")
            return false
        }
        
    }
}
