//
//  GameMenuViewController.swift
//  ScrewApp
//
//  Created by Vinicius Leal on 14/12/18.
//  Copyright © 2018 The Casatiellos. All rights reserved.
//

import UIKit

    //    BUTTON TO RESUME GAME:


class GameMenuViewController: UIViewController {

    @IBAction func resumeGame(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //    QUIT GAME AND NAVIGATE TO FIRST SCREEN:
    
    @IBAction func quitGame(_ sender: Any) {
        
        self.performSegue(withIdentifier: "unwindToFirstScreenSegue", sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
