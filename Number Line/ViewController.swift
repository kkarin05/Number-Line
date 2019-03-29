//
//  ViewController.swift
//  COMP585Number
//
//  Created by user914671 on 2/22/19.
//  Copyright © 2019 user914671. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {

    @IBAction func Foundit(_ sender: Any) {
            performSegue(withIdentifier: "Submit", sender: self)
    }
    
    @IBAction func ExitToStart(_ sender: Any) {
         performSegue(withIdentifier: "ExitToStartMenu", sender: self)
    }
    @IBOutlet weak var astronaut: UIImageView!
    
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "stars.jpg")!)
        
        // Find the screen width and distance between points
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let distance = (screenWidth - 200) / 5
        
        // Defines the question
        /*let question = UILabel(frame: CGRect(x: 200, y: 200, width: 800, height: 40))
        question.isAccessibilityElement = true
        question.text = "Please place the astronaut on number 3."
        question.font = UIFont(name: "Arial-BoldMT", size: 35)
        self.view.addSubview(question)
        question.accessibilityTraits = UIAccessibilityTraits.playsSound
        question.isUserInteractionEnabled = true
        question.accessibilityLabel = "Please place the astronaut on number 3."
        */
        
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
            view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
        }
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    

}
