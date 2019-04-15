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
    
    @IBAction func closeButtonTouched(_ sender: Any) {
        performSegue(withIdentifier: "correctToLevelSelect", sender: self)
    }
    
    @IBAction func nextLevel(_ sender: Any) {
        performSegue(withIdentifier: "backToLevel", sender: self)
        parentVC?.removePopOverView()
        /*let vc=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "levelVC")
        let levelvc=vc as! ViewController
        
        //initialize stuff
        //TODO
        //if we have done a certain amount of levels go back to level select
        levelvc.howManyLevelsAreDone=(parent as! ViewController).howManyLevelsAreDone+1
        levelvc.previousVC=self.parent
        levelvc.previousVCSuccess=self
        self.present(levelvc, animated: true, completion: nil)
        */
        //self.parent?.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ViewController{
           destinationVC.howManyLevelsAreDone = self.numLevelsComplete + 1
            destinationVC.previousVC=self
            
            //TODO
            //look at save levels in ViewController/MasterPlanetViewController in codequest
            //level object is what is saved in Level.swift
            //for now make if statement to see if howmanylevels are done is certain number then take it back to
            //level select or something
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("levels complete (in popup)="+numLevelsComplete.description)
        // Set the background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "stars.jpg")!)
        
        self.showAnimate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopUp(_ sender: Any) {
        self.removeAnimate()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
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
