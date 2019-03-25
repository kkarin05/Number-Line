//
//  StartScreenViewController.swift
//  Number Line
//
//  Created by Karin on 3/20/19.
//  Copyright © 2019 Tian Liu. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    @IBAction func StartButton(_ sender: Any) {
        performSegue(withIdentifier: "StartToTutorial", sender: self)
    }
    
    @IBAction func SettingsButton(_ sender: Any) {
         performSegue(withIdentifier: "StartToSettings", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "StartScreenImage.jpg")!)
        
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
