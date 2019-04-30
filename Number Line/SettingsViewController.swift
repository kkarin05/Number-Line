//
//  SettingsViewController.swift
//  Number Line
//
//  Created by Karin on 3/25/19.
//  Copyright © 2019 Tian Liu. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsViewController: UIViewController {
    var player:AVAudioPlayer = AVAudioPlayer()
    
    @IBAction func ExitSettings(_ sender: Any) {
         performSegue(withIdentifier: "SettingsExit", sender: self)
    }
   
    @IBAction func PlayMusic(_sender: Any) {
        do {
            let audioPath = Bundle.main.path(forResource: "music", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch {
            print(error)
        }
        
        player.play()
    }
    
    @IBAction func StopMusic(_sender: Any) {
        do {
            let audioPath = Bundle.main.path(forResource: "music", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch {
            print(error)
        }
        
        player.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "stars.jpg")!)

    }
    
    
}
