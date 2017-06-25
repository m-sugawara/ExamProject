//
//  UIView+Animations.swift
//  ExamProject
//
//  Created by M_Sugawara on 2017/06/25.
//  Copyright © 2017年 Sugawar. All rights reserved.
//

import UIKit
import QuartzCore

let viewRotationAnimationKey = "rotationAnimation"

extension UIView {
    func runSpinAnimation(withDuration duration: CFTimeInterval, doRepeat: Bool) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = Float.pi * 2.0
        rotationAnimation.duration = duration
        rotationAnimation.isCumulative = true
        if doRepeat == true {
            rotationAnimation.repeatCount = Float.infinity
        } else {
            rotationAnimation.repeatCount = Float(0)
        }
        
        self.layer.add(rotationAnimation, forKey: viewRotationAnimationKey)
    }
    
    func stopSpinAnimation() {
        self.layer.removeAnimation(forKey: viewRotationAnimationKey)
    }
}
