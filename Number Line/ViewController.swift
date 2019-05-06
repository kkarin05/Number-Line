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
         performSegue(withIdentifier: "Submit", sender: self)
        //self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var astronaut: UIImageView!
    
    @IBOutlet weak var astronautPlaceLabel: UILabel!
    
    @IBOutlet weak var lineRef: Line!
    
    var previousVC:UIViewController?=nil
    var previousVCSuccess:UIViewController?=nil
    var popOverVC:CorrectPopUpViewController?=nil
    var i = 0
    var ranges=[(CGFloat(0.0),CGFloat(0.0))]
    var desiredNumber=Int.random(in: 0...5)
    var threshold=10
    
    var exampleVar:Int=0
    var player: AVAudioPlayer?
    var howManyLevelsAreDone:Int=0
    
    var holdingAstronaut:Bool=false
    var maxWaitingTime:Int=5
    var waitingTime:Int = 5
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isAccessibilityElement = true 
        astronautPlaceLabel.text="Drag the astronaut to \(desiredNumber)" + " and click on submit"
        
        // Set the background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "stars.jpg")!)
        //previousVC?.dismiss(animated: false, completion: nil)
        
        print("levels complete (in vc)="+howManyLevelsAreDone.description)
        if (previousVC != nil){
                //previousVC?.dismiss(animated: false, completion: nil)
            //previousVCSuccess!.view.removeFromSuperview()
            //previousVC!.view.removeFromSuperview()
            /*previousVC?.dismiss(animated: false, completion:{
                if (self.previousVC != nil){
                    //self.previousVC?.dismiss(animated: false, completion: nil)
                }
            })*/
            
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var tryAgainVC=segue.destination as? IncorrectPopUpViewController
        if(tryAgainVC != nil){
            print("is a try again")
            tryAgainVC?.previousVCNum=desiredNumber
        }
        else{
            var rightVC = segue.destination as? CorrectPopUpViewController
            if (rightVC != nil){
                print("is correct")
                rightVC!.parentVC=self
                rightVC!.numLevelsComplete=self.howManyLevelsAreDone
            }
            else{
                print("other vc")
            }
        }
        

    }
    
    
    
    func initializeNumberTexts(){
        // Find the screen width and distance between points
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let distance = lineRef.distance
        
        //ranges=[(100+distance,100+(2*distance)), (100+(2*distance), 100+(3*distance)), (100+(3*distance), 100+(4*distance)), (100+(4*distance), 100+(5*distance))]
        let textHeight=100
        
        let textWidth=40
        var linerefbounds:CGRect=lineRef.bounds
        let spaceBetweenLineAndText:CGFloat=10.0
        // Create 5 labels and make them accessible
        while (i < lineRef.numberOfPoints+1) {
            let xdist = (distance*CGFloat(i))
            print("i is"+i.description+", dist= "+xdist.description+"otherdist: "+distance.description)
            
            
            var minXOfLine = lineRef.center.x-(linerefbounds.width/2)
            var maxYOfLine = lineRef.center.y+(linerefbounds.height/2)
            print("line ref offset= "+minXOfLine.description)
            let label = UILabel(frame: CGRect(x: xdist+lineRef.offSetFromEdges + minXOfLine, y: maxYOfLine+spaceBetweenLineAndText, width: CGFloat(textWidth), height: CGFloat(textHeight)))
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
        print("panning")
        var focusedView=UIAccessibility.focusedElement(using: UIAccessibility.AssistiveTechnologyIdentifier.notificationVoiceOver)
        print("focused: "+focusedView.debugDescription+" at "+recognizer.view!.center.x.description)
        let translation = recognizer.translation(in:self.view)
        //make sure to check that it's the astronaut
        //can make a child of UIIMageView for astronaut and attempt to cast to it
        if let view = recognizer.view {
            let astronaut_position = astronaut.center.x
            print("astronaut is at:" + astronaut_position.description)
            print("offset = "+translation.x.description+" "+translation.y.description)
            if(translation.x >= -0.1 && translation.x <= 0.1 && translation.y >= -0.1 && translation.y <= 0.1 && holdingAstronaut){
                print("splat")
                playSound()
                holdingAstronaut=false
                waitingTime=maxWaitingTime
            }
            else{
                if(waitingTime<0){
                    holdingAstronaut=true
                    print("holding")
                }
                else{
                    waitingTime-=1
                    holdingAstronaut=false
                    print("decrement")
                }
            }
            view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
            
        }
        self.view.bringSubviewToFront(view)
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    
    
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "splat", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func Submit(_ sender: Any) {
        let astronaut_positionX = astronaut.center.x
        let astronaut_positionY = astronaut.center.y
        print("astronaut is at X:" + astronaut_positionX.description)
        print("astronaut is at Y:" + astronaut_positionY.description)
        var linerefbounds:CGRect=lineRef.bounds
        var minXOfLine = lineRef.center.x-(linerefbounds.width/2)
        var maxYOfLine = lineRef.center.y
    print("desiredX"+(lineRef.points[desiredNumber].bounds.minX+minXOfLine).description)
        print("desiredY"+maxYOfLine.description)
        if (astronaut_positionX >= lineRef.points[desiredNumber].bounds.minX+minXOfLine-30 && astronaut_positionX < lineRef.points[desiredNumber].bounds.maxX+minXOfLine+30
            && astronaut_positionY >= maxYOfLine-200 &&
            astronaut_positionY < maxYOfLine+200 ) {
            
            //popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpWindow1") as! CorrectPopUpViewController
            //popOverVC?.parentVC=self
            //popOverVC?.numLevelsComplete=self.howManyLevelsAreDone
            //if (popOverVC != nil){
             //   print("pop")
            //}
            //self.addChild(popOverVC!)
            //popOverVC!.view.frame = self.view.frame
            
            //x,
            performSegue(withIdentifier: "toCongrats", sender: self)
            
            //self.view.addSubview(popOverVC!.view)
            //popOverVC!.didMove(toParent: self)
            //print("astronaut is in the right place!")
        }
        else{
            print("astronaut is in the wrong place!")
            performSegue(withIdentifier: "toTryAgain", sender: self)
            //let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpWindow2") as! IncorrectPopUpViewController
            //self.addChild(popOverVC)
            //popOverVC.view.frame = self.view.frame
            //self.view.addSubview(popOverVC.view)
            //popOverVC.didMove(toParent: self)
            
        }
        
    }
    
    override func accessibilityElementDidBecomeFocused()
    {
        ///self.focus
        
        //x, ticks, lineref,question, submit, astronaut
        
        //for (var count=0;i<10;i++){
            
        //}
        print("focused")
        var focusedElement:UIView
        var accessibleTicksRef:[UIView]=lineRef.accessibleTicks
        var touchedATick:Bool=false
        for i in 0...lineRef.accessibleTicks.count{
            //check if they are focused
            if(accessibleTicksRef[i].accessibilityElementIsFocused()){
                //this is the focused element
                focusedElement=accessibleTicksRef[i]
                //MAKE LINEREF NOT ACCESSIBLE
                touchedATick=true
                focusedElement.isAccessibilityElement=false
                break
            }
        }
        
        
        
    }
    
    func removePopOverView(){
        //popOverVC!.view.removeFromSuperview()
        //popOverVC?.removeFromParent()
        //popOverVC?.dismiss(animated: false, completion: nil)
        
        //let vc=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "levelVC")
        //let levelvc=vc as! ViewController
        
        //initialize stuff
        //TODO
        //if we have done a certain amount of levels go back to level select
        //levelvc.howManyLevelsAreDone=self.howManyLevelsAreDone+1
        //levelvc.previousVC=self
        //levelvc.previousVCSuccess=self
        
        //self.present(levelvc, animated: true, completion: nil)
        //self.view.removeFromSuperview()
        //self.parent?.dismiss(animated: true, completion: nil)
    }

}
