//
//  LevelSelectorViewController.swift
//  Number Line
//
//  Created by Karin on 3/29/19.
//  Copyright © 2019 Tian Liu. All rights reserved.
//

import UIKit

class LevelSelectorViewController: UIViewController {

    @IBAction func Tutorial(_ sender: Any) {
          performSegue(withIdentifier: "LevelChosen", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
