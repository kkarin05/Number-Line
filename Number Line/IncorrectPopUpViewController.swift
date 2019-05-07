//
//  IncorrectPopUpViewController.swift
//  Number Line
//
//  Created by Tian Liu on 4/2/19.
//  Copyright © 2019 Tian Liu. All rights reserved.
//

import UIKit

class IncorrectPopUpViewController: UIViewController {
    
    var previousVCNum:Int=0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "stars.jpg")!)
        
        self.showAnimate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Direct the player back to the same round so the player can retry the game
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var levelVC:ViewController=segue.destination as! ViewController
        
        levelVC.desiredNumber=previousVCNum
    }

    // Allows the player to go back to previous page
    @IBAction func closePopUp(_ sender: Any) {
        performSegue(withIdentifier: "tryAgainToLevel", sender: self)
    }

    // Helper method - show the popup window animation
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }

    // Currently not used, may need for future reference
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
}
}
