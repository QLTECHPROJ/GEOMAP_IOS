//
//  AnimationFrames.swift
//  Geo_Map
//
//  Created by Dhruvit on 07/11/20.
//  Copyright © 2020 Dhruvit. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // MARK: - NowPlayingAnimation
    func startNowPlayingAnimation(_ animate: Bool) {
        self.animationImages = AnimationFrames.createNowPlayingAnimationFrames()
        self.animationDuration = 0.7
        animate ? self.startAnimating() : self.stopAnimating()
    }
    
    // MARK: - Player Tutorial Animation
    func startSplashScreenAnimation(_ animate: Bool) {
        self.animationImages = AnimationFrames.createSplashScreenAnimationFrames()
        self.animationDuration = 1
        animate ? self.startAnimating() : self.stopAnimating()
    }
    
}

class AnimationFrames {
    
    class func createNowPlayingAnimationFrames() -> [UIImage] {
    
        // Setup "Now Playing" Animation Bars
        var animationFrames = [UIImage]()
        for i in 0...3 {
            if let image = UIImage(named: "NewNowPlayingBars-\(i)") {
                animationFrames.append(image)
            }
        }
        
        for i in stride(from: 2, to: 0, by: -1) {
            if let image = UIImage(named: "NewNowPlayingBars-\(i)") {
                animationFrames.append(image)
            }
        }
        return animationFrames
    }
    
    class func createSplashScreenAnimationFrames() -> [UIImage] {
    
        // Setup "Splash" Animation
        var animationFrames = [UIImage]()
        for i in 0...6 {
            if let image = UIImage(named: "splash_image_\(i)") {
                animationFrames.append(image)
            }
        }
        
        return animationFrames
    }

}
