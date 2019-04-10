//
//  ViewController.swift
//  COMP585Number
//
//  Created by user914671 on 2/22/19.
//  Copyright © 2019 user914671. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBAction func ExitToStart(_ sender: Any) {
         performSegue(withIdentifier: "ExitToStartMenu", sender: self)
    }
    @IBOutlet weak var astronaut: UIImageView!
    
    @IBOutlet weak var astronautPlaceLabel: UILabel!
    
    @IBOutlet weak var lineRef: Line!
    
    var i = 0
    var ranges=[(CGFloat(0.0),CGFloat(0.0))]
    var desiredNumber=Int.random(in: 0...5)
    var threshold=10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        astronautPlaceLabel.text="Please place the astronaut on number \(desiredNumber)"
        
        // Set the background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "stars.jpg")!)
        
        // Find the screen width and distance between points
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let distance = (screenWidth - 200) / 5
        
        ranges=[(100+distance,100+(2*distance)), (100+(2*distance), 100+(3*distance)), (100+(3*distance), 100+(4*distance)), (100+(4*distance), 100+(5*distance))]
        
        // Create 5 labels and make them accessible
        while (i < 6) {
            let xdist = distance*CGFloat(i) + 87.5
            let label = UILabel(frame: CGRect(x: xdist, y: 400, width: 40, height: 100))
            label.isAccessibilityElement = true
            label.text = String(i)
            label.font = UIFont(name: "Arial-BoldMT", size: 50)
            label.textColor = UIColor.white;
            self.view.addSubview(label)
            label.accessibilityTraits = UIAccessibilityTraits.playsSound
            label.isUserInteractionEnabled = true
            label.accessibilityLabel = String(i)
            i = i+1
        }
    }
    
    @IBAction func handlepan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in:self.view)
        if let view = recognizer.view {
            let astronaut_position = astronaut.center.x
            print("astronaut is at:" + astronaut_position.description)
            view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
            
        }
        self.view.bringSubviewToFront(view)
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    
    @IBAction func Submit(_ sender: Any) {
        let astronaut_position = astronaut.center.x
        print("astronaut is at:" + astronaut_position.description)
        
        if (astronaut_position >= lineRef.points[desiredNumber].bounds.minX-30 && astronaut_position < lineRef.points[desiredNumber].bounds.maxX+30) {
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpWindow1") as! CorrectPopUpViewController
            self.addChild(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParent: self)
            print("astronaut is in the right place!")
        }
        else{
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpWindow2") as! IncorrectPopUpViewController
            self.addChild(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParent: self)
            print("astronaut is in the wrong place!")
        }
        
    }

}
