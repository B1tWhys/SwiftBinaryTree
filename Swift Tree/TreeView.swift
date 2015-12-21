//
//  treeView.swift
//  Swift Tree
//
//  Created by Skyler Arnold on 12/17/15.
//  Copyright © 2015 Skyler Arnold. All rights reserved.
//

import UIKit

class TreeView: UIView {
    var depthToDrawTo: Int = 0 // how many times to recurse, or put differently how deep the tree goes. 0 when the program starts
    var angleVar:Double = 9
    
    
    var radians: Double {
        get {
            return M_PI/angleVar
        }
    }
    var numberOfLines = 0
    override func drawRect(rect: CGRect) {
        var array = [UIBezierPath]()
        
        // set the color to stroke the tree with. This is really done with the setStroke instance method on UIColor
        let treeColor = UIColor(red: 117.0/256.0, green: 54.0/256.0, blue: 0.0/256.0, alpha: 256.0/256.0)
        treeColor.setStroke()
        
        
        // UIBezierPath is a lot like the Turtle module in Python (for anyone who's played with that).
        // You start in a spot, then you draw a line from that, and then from there and then from there ect. 
        // The only difference is that rather than having to do the math on the rads to turn, you just tell it
        // what piont to go to and it does.
        let path = UIBezierPath()
        let startingPoint = CGPoint(x: rect.width/2, y: rect.height)
        path.moveToPoint(startingPoint) // here we set the starting point for the Bezier turtle.
        path.addLineToPoint(CGPoint(x: (startingPoint.x), y: (startingPoint.y - CGFloat(100))))
        path.stroke()
        var time = NSDate()
        self.drawLevelsFrom(1, startingPoint: path.currentPoint, lastRads: M_PI/2) // this is the recursive method.
        let timeToGenerate = -time.timeIntervalSinceNow
        print("Time to generate line: \(timeToGenerate)")
        // this renders the path. NOTE: do all this in the drawRect method. If you try to stroke in the wrong place, it won't work.
        // If you ever have problems with this, try logging UIGraphicsGetCurrentContext() all over the place. It shouldn't be nil.
        
        time = NSDate()
        path.stroke()
        let timeToStroke = -time.timeIntervalSinceNow
        print("Time to stroke line: \(timeToStroke)")
        print("Ratio = \(timeToGenerate/timeToStroke)\n")
    }
    
    let lineLengthConstant = 20 // as recursion depth tends toward infinity, the total height of the tree tends toward 2*lineLengthConstant (I think. I've never formally learned sums of infinite series.)
    let lengthConst = 100.0

    func drawLevelsFrom(currentLevel: Int, startingPoint: CGPoint, lastRads: Double) -> Void {
        if (currentLevel <= self.depthToDrawTo) { // we check to see if we are done by comparing the current level to the desired depth
            // calculate where the right branch ends.
            var rads = lastRads - radians
            var yVal: Double {
                get {
                    return sin(rads)
                }
            }
            
            var xVal: Double {
                get {
                    return cos(rads)
                }
            }
            
            var xAddition: Double {
                get {
                    return (lengthConst*xVal)/Double(currentLevel)
                }
            }
            var yAddition: Double {
                get {
                    return lengthConst*yVal/Double(currentLevel)
                }
            }
            
            
            
//            var newPoint = CGPoint(x: path.currentPoint.x + CGFloat(lineLengthConstant/currentLevel), y: path.currentPoint.y - CGFloat(lineLengthConstant/currentLevel))
            var newPoint = CGPoint(x: startingPoint.x + CGFloat(xAddition), y: startingPoint.y - CGFloat(yAddition))
            // add the line
            var newPath = UIBezierPath()
            newPath.moveToPoint(startingPoint)
            newPath.addLineToPoint(newPoint)
            newPath.stroke()
            // recurse
            self.drawLevelsFrom(currentLevel + 1, startingPoint: newPoint, lastRads: rads)
            
            rads = lastRads + radians
            
            newPoint = CGPoint(x: startingPoint.x + CGFloat(xAddition), y: startingPoint.y - CGFloat(yAddition))
            newPath = UIBezierPath()
            newPath.moveToPoint(startingPoint)
            newPath.addLineToPoint(newPoint)
            newPath.stroke()
            
            self.drawLevelsFrom(currentLevel + 1, startingPoint: newPoint, lastRads: rads)
        }
    }
}
