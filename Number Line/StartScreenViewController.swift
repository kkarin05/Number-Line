//
//  StartScreenViewController.swift
//  Number Line
//
//  Created by Karin on 3/20/19.
//  Copyright © 2019 Tian Liu. All rights reserved.
//

import UIKit
import AVFoundation

class StartScreenViewController: UIViewController {

    @IBAction func StartButton(_ sender: Any) {
        performSegue(withIdentifier: "LevelSelect", sender: self)
    }
    
    @IBAction func SettingsButton(_ sender: Any) {
         performSegue(withIdentifier: "StartToSettings", sender: self)
    }
    
  //  var player:AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "StartScreenImage.jpg")!)
        
//        do {
//            let audioPath = Bundle.main.path(forResource: "music", ofType: "mp3")
//            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
//        }
//        catch {
//            print(error)
//        }
//
//        player.play()
    }
}
