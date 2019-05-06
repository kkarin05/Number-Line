//
//  Line.swift
//  Number Line
//
//  Created by Tian Liu on 2/21/19.
//  Copyright © 2019 Tian Liu. All rights reserved.
//

import UIKit

class Line: UIView {
    var line = UIBezierPath()
    var points = [UIBezierPath]()
    var i = 0
    var j = 0
    let offSetFromEdges:CGFloat=10.0
    let numberOfPoints=5
    let lineHeight:CGFloat=100.0
    let lineWidth:CGFloat=10.0*3
    var baseOfLine:CGFloat=0.0
    var distance:CGFloat = 0.0
    var myOffset:String=""
    var backgroundView:LineBackgroundView?=nil
    var accessibleTicks:[TickView]=[]
    override func draw(_ rec: CGRect) {
        //isAccessibilityElement = true
         baseOfLine=self.bounds.maxY-(lineWidth/2)
         distance = (self.bounds.maxX-self.bounds.minX-(2*offSetFromEdges)-(lineWidth)) / CGFloat(numberOfPoints)
        
        graph()
    }
    
    func returnMyOffset()->CGFloat{
        return self.bounds.minX
    }
    
    func graph() {
        // Find the screen width and the distance between points
        //let screenSize: CGRect = UIScreen.main.bounds
        //let screenWidth = screenSize.width
        
        
        //self.center apparently isn't center of view
        print("got here"+self.bounds.minX.description+" "+self.bounds.maxX.description+" "+self.center.y.description)
        line.move(to: CGPoint(x: self.bounds.minX+offSetFromEdges, y: baseOfLine))
        line.addLine(to: CGPoint(x: self.bounds.maxX-offSetFromEdges, y: baseOfLine))
        UIColor.white.setStroke()
        line.lineWidth = lineWidth
        line.stroke()
        //line.
        //TODO: to make it only say number line when you leave bounds, in view controller, make it so that when you enter the background, it removes accessibility label, and only reenables it if the focused accessibility element is NOT in this subview (didlosefocus on line and ticks)
        
        //var focusedView: UIView=UIAccessibility.focusedElement(using: UIAccessibility.AssistiveTechnologyIdentifier.notificationVoiceOver) as! UIView
        
        backgroundView=LineBackgroundView(frame: CGRect(x:self.bounds.minX,y:self.bounds.minY,width:self.bounds.maxX-self.bounds.minX,height:self.bounds.maxY-self.bounds.minY))
        backgroundView!.line=self
        print("inside line, minX is "+self.bounds.minX.description)
        self.myOffset=self.bounds.minX.description
        backgroundView!.isAccessibilityElement=true
        backgroundView!.accessibilityLabel=""
        //backgroundView!.isUserInteractionEnabled=false
        //backgroundView!.accessibilityTraits = .none
        self.addSubview(backgroundView!)
        while (i < numberOfPoints+1) {
            points.append(UIBezierPath())
            let xdist = distance*CGFloat(i) + offSetFromEdges
            
            points[i].move(to: .init(x: xdist+(0.5*lineWidth), y: baseOfLine))
            points[i].addLine(to: .init(x: xdist+(0.5*lineWidth), y: baseOfLine-lineHeight))
            UIColor.white.setStroke()
            points[i].lineWidth = lineWidth
            points[i].stroke()
            points[i].isAccessibilityElement = true
            points[i].accessibilityTraits = UIAccessibilityTraits.playsSound
           // points[i].isUserInteractionEnabled = true
            points[i].accessibilityLabel = String(i)
            var myUIView:TickView = TickView(frame: CGRect(x:xdist+(0.5*lineWidth)-(lineWidth/2),y:baseOfLine-lineHeight,width:lineWidth,height:lineHeight+(0.5*lineWidth)))
            myUIView.isAccessibilityElement=true
            myUIView.accessibilityLabel="tick"
            accessibleTicks.append(myUIView)
            self.addSubview(myUIView)
            self.bringSubviewToFront(myUIView)
            
            i = i+1
            
        }
        
        (self.parentViewController as! ViewController).initializeNumberTexts()
    }
    
    override func accessibilityElementDidBecomeFocused()
    {
        ///self.focus
        
        //x, ticks, lineref,question, submit, astronaut
        
        //for (var count=0;i<10;i++){
        
        //}
        print("focused line")
    }
    
    func reenableAllTicks(){
        
        for tick in accessibleTicks{
            tick.isAccessibilityElement=true
        }
    }
}

extension UIView{
    var parentViewController:UIViewController?{
        var parentResponder:UIResponder?=self
        while parentResponder != nil {
            parentResponder=parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            
        }
        return nil
    }
}
