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
    
    // Directs player back to the start menu
    @IBAction func ExitSettings(_ sender: Any) {
         performSegue(withIdentifier: "SettingsExit", sender: self)
    }
   
    // Function to allow player to play music
    @IBAction func PlayMusic(_sender: Any) {
        do {
            let audioPath = Bundle.main.path(forResource: "music", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch {
            print(error)
        }
        player.numberOfLoops = -1
        player.play()
    }
    
    // Function to allow player to stop the music
    @IBAction func StopMusic(_sender: Any) {
        do {
            let audioPath = Bundle.main.path(forResource: "music", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch {
            print(error)
        }
        player.numberOfLoops = 0
        player.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "stars.jpg")!)

    }
    
    
}
