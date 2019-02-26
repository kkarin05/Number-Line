//
//  ViewController.swift
//  Number Line
//
//  Created by Tian Liu on 2/21/19.
//  Copyright © 2019 Tian Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("load")
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"background.jpg")!)
        
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        UIImage(named: "background.jpg")?.draw(in: self.view.bounds)
//        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        self.view.backgroundColor = UIColor(patternImage: image)

        // Find the screen width and the distance between points
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let distance = (screenWidth - 200) / 5
        
        // Create 5 labels and make them accessible
        while (i < 6) {
            let xdist = distance*CGFloat(i) + 87.5
            let label = UILabel(frame: CGRect(x: xdist, y: 550, width: 40, height: 40))
            label.isAccessibilityElement = true
            label.text = String(i)
            label.font = UIFont(name: "Arial", size: 40)
            label.accessibilityTraits = UIAccessibilityTraits.playsSound
            self.view.addSubview(label)
            
            i = i+1
        }
    }
}

