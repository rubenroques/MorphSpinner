//
//  MorphSpinnerView.swift
//  MorphSpinner
//
//  Created by Ruben Roques on 20/06/14.
//  Copyright (c) 2014 rrocks. All rights reserved.
//

import UIKit
import QuartzCore

class MorphSpinnerView: UIView{

    var color : UIColor = UIColor.grayColor(){
        didSet{
            self.layer.borderColor = color.CGColor
        }
    }
    var lineWidth :CGFloat = 3.0{
        didSet{
            self.layer.borderWidth = lineWidth
        }
    }

    var hidesWhenStop = true
    var activated = false

    init() {
        super.init(frame:frame);
    }

    init(center: CGPoint, radius:Float = 18) {

        var frame = CGRectMake(center.x-radius, center.y-radius, radius*2, radius*2)
        super.init(frame:frame);

        self.layer.masksToBounds = true;
        self.layer.cornerRadius = (self.bounds.size.width/2);
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = lineWidth

        self.backgroundColor = UIColor.clearColor()

        self.stop()
    }

    
    func start(){

        //Show MorphSpinner if it's hidden
        if self.hidden {
            self.hidden = false;
        }

        activated = true

        //Auxiliar Varables
        let animationTime = 1.34
        let startAngle : CGFloat = atan2f(self.transform.b, self.transform.a)
        let middleAngle : CGFloat = atan2f(self.transform.b, self.transform.a)-CGFloat(M_PI_4)

        //First-half of the animation
        let cornerAnim :CABasicAnimation = CABasicAnimation(keyPath:"cornerRadius")
        cornerAnim.fromValue = 0
        cornerAnim.toValue = (self.bounds.size.width/2)
        cornerAnim.duration = animationTime/4
        cornerAnim.beginTime = 0

        let firstRotationAnim :CABasicAnimation = CABasicAnimation(keyPath:"transform.rotation")
        firstRotationAnim.fromValue = startAngle
        firstRotationAnim.byValue = -M_PI_4
        firstRotationAnim.duration = animationTime/4
        firstRotationAnim.beginTime = 0

        //Second-half of the animation
        let cornerRestoreAnim :CABasicAnimation = CABasicAnimation(keyPath:"cornerRadius")
        cornerRestoreAnim.fromValue = (self.bounds.size.width/2)
        cornerRestoreAnim.toValue = 0
        cornerRestoreAnim.duration = animationTime/4
        cornerRestoreAnim.beginTime = animationTime/2
        cornerRestoreAnim.removedOnCompletion = false
        cornerRestoreAnim.fillMode = kCAFillModeForwards

        let secondRotationAnim :CABasicAnimation = CABasicAnimation(keyPath:"transform.rotation")
        secondRotationAnim.fromValue = middleAngle
        secondRotationAnim.byValue = -M_PI_4
        secondRotationAnim.duration = animationTime/4
        secondRotationAnim.beginTime = animationTime/2

        //Animation Group
        let animationsGroup = CAAnimationGroup()
        animationsGroup.duration = animationTime
        animationsGroup.repeatCount = HUGE
        animationsGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animationsGroup.animations = [firstRotationAnim,cornerAnim,secondRotationAnim,cornerRestoreAnim]

        self.layer.addAnimation(animationsGroup, forKey: "morph")
    }

    func stop()
    {
        //Remove all the animations and "deactivate" MorphSpinner
        self.layer.removeAllAnimations()
        activated = false

        if hidesWhenStop {
            self.hidden = true;
        }
    }
}