//
//  InitialViewController.swift
//  AdityaChugh
//
//  Created by Aditya Chugh on 2015-04-21.
//  Copyright (c) 2015 Aditya Chugh. All rights reserved.
//

import UIKit
import AVFoundation

class InitialViewController: UIViewController {
   
    @IBOutlet weak var titleLabel: SpringLabel!
    @IBOutlet weak var firstLineLabel: SpringLabel!
    @IBOutlet weak var secondLineLabel: SpringLabel!
    @IBOutlet weak var thirdLineLabel: SpringLabel!
    
    @IBOutlet weak var iconView: SpringButton!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var backgroungImageView: UIImageView!
    
    @IBOutlet var labelDistanceConstraints: [NSLayoutConstraint]!
    @IBOutlet weak var topDistanceConstraint: NSLayoutConstraint!
    var audioPlayer: AVAudioPlayer!
    
    var pageIndex: Int!
    var pageContent: PageContent!
    var isFirstViewController = false
    var animationHasCompleted = false
    
    override func viewDidLoad() {
        setupConstraints()
        setupPageContent()
        setupAudioPlayer()
        blurView.alpha = 0
        if isFirstViewController && !animationHasCompleted {
            startAnimation()
            animationHasCompleted = true
        }
        iconView.layer.cornerRadius = iconView.frame.width/2
        iconView.layer.masksToBounds = true
        view.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewWillDisappear(animated: Bool) {
        audioPlayer.stop()
    }
    
    @IBAction func iconTapped(sender: SpringButton) {
        if let action = pageContent.action {
            action()
        }
    }
    
    func setupAudioPlayer() {
        var error: NSError?
        var path = NSBundle.mainBundle().pathForResource(pageContent.audioFileName, ofType: pageContent.audioFileExtension)
        var url = NSURL(fileURLWithPath: path!)
        audioPlayer = AVAudioPlayer(contentsOfURL: url!, error: &error)
        audioPlayer.prepareToPlay()
    }
    
    func startAnimation() {
        blurBackground(1, delay: 0)
        delayTime(1, closure: {
            () -> () in
            self.audioPlayer.play()
        })
        animateView(titleLabel, delay: 1, animation: pageContent.titleAnimation)
        animateView(firstLineLabel, delay: 1.5, animation: pageContent.firstLineAnimation)
        animateView(iconView, delay: pageContent.pictureDelay, animation: pageContent.pictureAnimation)
        animateView(secondLineLabel, delay: 2, animation: pageContent.secondLineAnimation)
        animateView(thirdLineLabel, delay: 2.5, animation: pageContent.thirdLineAnimation)
        if pageContent.performPicturePop {
            setupProfilePicturePop(0.5-(pageContent.pictureDelay-2))
        }
    }
    
    func setupProfilePicturePop(delay: CGFloat) {
        iconView.animateNext {
            () -> () in
            self.iconView.autohide = true
            self.iconView.animation = "pop"
            self.iconView.animateFrom = true
            self.iconView.delay = delay
            self.iconView.duration = 1
            self.iconView.damping = 1
            self.iconView.alpha = 1
            self.iconView.animateTo()
        }
    }
    
    func setupConstraints() {
        if self.view.bounds.height == 568 {
            for constraint in labelDistanceConstraints {
                constraint.constant = 16
            }
        } else if self.view.bounds.height == 480 {
            for constraint in labelDistanceConstraints {
                constraint.constant = 8
                topDistanceConstraint.constant = 8
            }
        }
    }
    
    func setupPageContent() {
        titleLabel.text = pageContent.title
        firstLineLabel.text = pageContent.firstLine
        secondLineLabel.text = pageContent.secondLine
        thirdLineLabel.text = pageContent.thirdLine
        iconView.setImage(pageContent.iconImage, forState: UIControlState.Normal)
        backgroungImageView.image = pageContent.backgroundImage
    }
    
    func blurBackground(time:NSTimeInterval, delay:NSTimeInterval) {
        UIView.animateWithDuration(time, delay: delay, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            () -> Void in
            self.blurView.alpha = 1
        }, completion: nil)
    }
    
    func animateView(view: Springable, delay: CGFloat, animation: String) {
        view.autostart = true
        view.autohide = true
        view.animation = animation
        view.rotate = 0
        view.delay = delay
        view.duration = 1.5
        view.damping = 0.7
        view.animate()
    }
    
    func delayTime(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}