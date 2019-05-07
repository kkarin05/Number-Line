//
//  CorrectPopUpViewController.swift
//  Number Line
//
//  Created by Tian Liu on 4/2/19.
//  Copyright © 2019 Tian Liu. All rights reserved.
//

import UIKit

class CorrectPopUpViewController: UIViewController {
    var parentVC:ViewController?=nil
    var numLevelsComplete:Int=0
    
    // If the player clicks close, the game will direct him/her back to level selection
    @IBAction func closeButtonTouched(_ sender: Any) {
        performSegue(withIdentifier: "correctToLevelSelect", sender: self)
    }
    
    // The player can click next to go to next round of game
    @IBAction func nextLevel(_ sender: Any) {
        performSegue(withIdentifier: "backToLevel", sender: self)
        parentVC?.removePopOverView()
    }
    
    // Direct the player to the next level
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ViewController{
           destinationVC.howManyLevelsAreDone = self.numLevelsComplete + 1
            destinationVC.previousVC=self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "stars.jpg")!)
        
        self.showAnimate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closePopUp(_ sender: Any) {
        self.removeAnimate()
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
    
    // Helper method - close the popup window animation
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
