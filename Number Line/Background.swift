//
//  Background.swift
//  Number Line
//
//  Created by Tian Liu on 3/26/19.
//  Copyright © 2019 Tian Liu. All rights reserved.
//

import UIKit

extension UIView {
    func addGameBackground() {
        let imageViewBackground = UIImageView(frame: UIScreen.main.bounds)
        imageViewBackground.image = UIImage(named: "background.jpg")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
}
