//
//  MenuViewController.swift
//  AdityaChugh
//
//  Created by Aditya Chugh on 2015-04-21.
//  Copyright (c) 2015 Aditya Chugh. All rights reserved.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController, SquareDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    var animator: UIDynamicAnimator!
    var gravity = UIGravityBehavior()
    var collision = UICollisionBehavior()
    var itemBehavior = UIDynamicItemBehavior()
    var blurView: UIVisualEffectView!
    var factView: FactView!
    var cancelButton: SpringButton!
    var backButton: SpringButton!
    var helpButton: SpringButton!
    var audioPlayer: AVAudioPlayer!
    var facts:[Fact] = []
    var squares:[Square] = []
    var isInitialLoad = true
    var isMenu = true
    var selectedSquare:Square!
    
    
    override func viewDidLoad() {
        setupData()
        setupAnimator()
        setupAudioPlayer()
        setupSquares()
        setupCancelButton()
        setupBackButton()
        setupHelpButton()
    }
    
    override func viewDidDisappear(animated: Bool) {
        audioPlayer.stop()
    }
    
    //Squares
    
    func viewTapped(sender: Square) {
        if !sender.factOrCategory.isCategory {
            showFact(sender)
        } else {
            isMenu = false
            showCategory(sender)
        }
    }
    
    func showCategory(sender:Square) {
        var index = findIndexOfSquare(sender)!
        selectedSquare = squares[index]
        squares.removeAtIndex(index)
        selectedSquare.animate()
        removeViewFromBehaviors(selectedSquare)
        delayTime(1, closure: {
            () -> () in
            self.selectedSquare.removeFromSuperview()
        })
        var delay = removeSquares()
        delay += 0.25
        delayTime(delay, closure: {
            () -> () in
            self.facts = (sender.factOrCategory as! Category).facts!
            self.setupSquares()
            self.showBackButton()
            self.animateTitle(sender.factOrCategory.title, delay: 0)
        })
    }
    
    func setupSquares() {
        squares = []
        var delay:Double = 0
        var previousX:CGFloat = 0
        for fact in facts {
            var square = Square(frame: CGRectMake(0, 0, 125, 125), fact: fact)
            if fact.isCategory || fact.action != nil || fact.image != nil || fact.text != nil {
                square.layer.borderWidth = 2
                square.layer.borderColor = UIColor.whiteColor().CGColor
            }
            square.frame.origin.y = 0
            square.frame.size.width = 100
            square.frame.size.height = 100
            square.delegate = self
            square.alpha = 0
            let range = Int(self.view.frame.size.width-square.frame.size.width) - 40
            var randomX = 20.0 + CGFloat(arc4random_uniform(UInt32(range)))
            while abs(Int(randomX) - Int(previousX)) < 130 {
                randomX = 20.0 + CGFloat(arc4random_uniform(UInt32(range)))
            }
            previousX = randomX
            square.frame.origin.x = randomX
            square.tapRecognizer.enabled = false
            squares.append(square)
            self.delayTime(delay, closure: {
                () -> () in
                UIView.animateWithDuration(0.5, animations: {
                    () -> Void in
                    square.alpha = 1
                })
                self.addViewToBehaviors(square)
            })
            delay += 0.2
        }
        delayTime(delay, closure: {
            () -> () in
            for square in self.squares {
                square.tapRecognizer.enabled = true
            }
        })
    }
    
    //Setup
    
    func setupAnimator() {
        animator = UIDynamicAnimator(referenceView: self.view)
        
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        itemBehavior.elasticity = 0
        itemBehavior.friction = 1
        animator.addBehavior(itemBehavior)
        collision.translatesReferenceBoundsIntoBoundary = true
    }
    
    func setupData() {
        facts = []
        facts = Data.getData()
    }
    
    func setupAudioPlayer() {
        var error: NSError?
        var path = NSBundle.mainBundle().pathForResource("Help", ofType: "m4a")
        var url = NSURL(fileURLWithPath: path!)
        audioPlayer = AVAudioPlayer(contentsOfURL: url!, error: &error)
        audioPlayer.prepareToPlay()
        delayTime(1, closure: {
            () -> () in
            self.audioPlayer.play()
        })
        
    }
    
    //Help
    
    func setupHelpButton() {
        helpButton = SpringButton(frame: CGRectMake(self.view.frame.size.width-50-8, 8, 50, 50))
        self.view.addSubview(helpButton)
        helpButton.layer.cornerRadius = 25
        helpButton.layer.masksToBounds = true
        helpButton.backgroundColor = UIColor.turquoiseColor()
        helpButton.setImage(UIImage(named: "Help-Button.png"), forState: UIControlState.Normal)
        helpButton.animation = "slideLeft"
        helpButton.duration = 1
        helpButton.autostart = true
        helpButton.autohide = true
        helpButton.animate()
        helpButton.addTarget(self, action: "helpButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showHelp() {
        var square = Square(frame: CGRectMake(0, 0, 100, 100), fact: Fact(title: "Help", text: nil, image: UIImage(named: "Help")))
        showFact(square)
    }
    
    func helpButtonTapped() {
        showHelp()
    }
    
    //CancelButton
    
    func setupCancelButton() {
        cancelButton = SpringButton(frame: CGRectMake(8, 8, 50, 50))
        cancelButton.layer.cornerRadius = 25
        cancelButton.layer.masksToBounds = true
        cancelButton.backgroundColor = UIColor.turquoiseColor()
        cancelButton.setImage(UIImage(named: "Cancel-Button.png"), forState: UIControlState.Normal)
        cancelButton.animation = "slideDown"
        cancelButton.duration = 1
        cancelButton.autostart = true
        cancelButton.autohide = true
        cancelButton.addTarget(self, action: "cancelButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showCancelButton() {
        self.view.addSubview(cancelButton)
        self.cancelButton.animation = "slideDown"
        self.cancelButton.duration = 1
        self.cancelButton.autostart = true
        self.cancelButton.autohide = true
        self.cancelButton.animate()
    }
    
    func hideCancelButton() {
        cancelButton.animateToNext {
            () -> () in
            self.cancelButton.autostart = true
            self.cancelButton.autohide = true
            self.cancelButton.animation = "slideDown"
            self.cancelButton.duration = 1
            self.cancelButton.delay = 0
            self.cancelButton.animateTo()
        }
        
        delayTime(1, closure: {
            () -> () in
            self.cancelButton.removeFromSuperview()
        })
    }
    
    func cancelButtonTapped() {
        hideFact()
    }
    
    //BackButton
    
    func setupBackButton() {
        backButton = SpringButton(frame: CGRectMake(8, 8, 50, 50))
        backButton.layer.cornerRadius = 25
        backButton.layer.masksToBounds = true
        backButton.backgroundColor = UIColor.turquoiseColor()
        backButton.setImage(UIImage(named: "Back-Button.png"), forState: UIControlState.Normal)
        backButton.animation = "slideRight"
        backButton.duration = 1
        backButton.autostart = true
        backButton.autohide = true
        backButton.addTarget(self, action: "backButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        showBackButton()
    }
    
    func showBackButton() {
        self.view.addSubview(backButton)
        self.backButton.animation = "slideRight"
        self.backButton.duration = 1
        self.backButton.autostart = true
        self.backButton.autohide = true
        self.backButton.animate()
    }
    
    func hideBackButton() {
        backButton.animateToNext {
            () -> () in
            self.backButton.autostart = true
            self.backButton.autohide = true
            self.backButton.animation = "slideRight"
            self.backButton.duration = 1
            self.backButton.delay = 0
            self.backButton.animateTo()
        }
        
        delayTime(1, closure: {
            () -> () in
            self.backButton.removeFromSuperview()
        })
    }
    
    func backButtonTapped() {
        if isMenu {
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            facts = []
            var delay = removeSquares()
            delay += 0.25
            isMenu = true
            delayTime(delay, closure: {
                () -> () in
                self.setupData()
                self.setupSquares()
                self.animateTitle("Aditya Chugh", delay: 0)
            })
        }
    }
    
    //Fact
    
    func showFact(sender:Square) {
        if sender.factOrCategory.text != nil || sender.factOrCategory.image != nil || sender.factOrCategory.action != nil {
            showBlurView()
            showFactView(sender)
            showCancelButton()
        }
    }
    
    func hideFact() {
        hideBlurView()
        hideFactView()
        hideCancelButton()
    }
    
    //BlurView
    
    func showBlurView() {
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.frame
        self.view.addSubview(blurView)
        blurView.alpha = 0
        UIView.animateWithDuration(0.5, animations: {
            () -> Void in
            self.blurView.alpha = 1
        })
    }
    
    func hideBlurView() {
        blurView.alpha = 1
        UIView.animateWithDuration(0.5, delay: 0.5, options: nil, animations: {
            () -> Void in
            self.blurView.alpha = 0
            }, completion: nil)
        delayTime(1, closure: {
            () -> () in
            self.blurView.removeFromSuperview()
        })
    }
    
    //FactView
    
    func showFactView(square:Square) {
        factView = FactView(frame: CGRectMake(0, 0, 300, 430), fact: square.factOrCategory)
        factView.presentingViewController = self
        factView.clipsToBounds = true
        self.view.addSubview(factView)
        factView.frame.size.height = 430
        if factView.fact.image == nil {
            factView.imageHeightConstraint.constant = 0
            factView.imageView.hidden = true
            factView.frame.size.height -= 169
        } else {
            factView.imageHeightConstraint.constant = 169
            factView.imageView.hidden = false
        }
        if factView.fact.text == nil {
            factView.textHeightConstraint.constant = 0
            factView.textView.hidden = true
            factView.frame.size.height -= 191
        } else {
            factView.textHeightConstraint.constant = 191
            factView.textView.hidden = false
        }
        if factView.fact.action == nil {
            factView.linkHeightConstraint.constant = 0
            factView.linkButton.hidden = true
            factView.frame.size.height -= 30
        } else {
            factView.linkHeightConstraint.constant = 30
            factView.linkButton.hidden = false
        }
        factView.center = self.view.center
        
        factView.animation = "zoomIn"
        factView.autohide = true
        factView.autostart = true
        factView.delay = 0
        factView.duration = 1
        factView.animate()
    }
    
    func hideFactView() {
        factView.animateToNext {
            () -> () in
            self.factView.animation = "zoomIn"
            self.factView.duration = 1
            self.factView.delay = 0
            self.factView.animateTo()
        }
        delayTime(1, closure: {
            () -> () in
            self.factView.removeFromSuperview()
        })
    }
    
    //Misc
    
    func removeSquares() -> Double {
        var delay = 0.075
        for square in squares {
            self.removeViewFromBehaviors(square)
            delayTime(delay, closure: {
                () -> () in
                square.animate()
                self.delayTime(1, closure: {
                    () -> () in
                    square.removeFromSuperview()
                })
            })
            delay += 0.075
        }
        return delay
    }
    
    func addViewToBehaviors(view:UIView) {
        self.view.addSubview(view)
        collision.addItem(view)
        gravity.addItem(view)
        itemBehavior.addItem(view)
    }
    
    func removeViewFromBehaviors(view:UIView) {
        collision.removeItem(view)
        gravity.removeItem(view)
        itemBehavior.removeItem(view)
    }
    
    func findIndexOfSquare(square:Square) -> Int? {
        for var i = 0; i < squares.count; ++i {
            if squares[i] == square {
                return i
            }
        }
        return nil
    }
    
    func animateTitle(title:String, delay:Double) {
        UIView.animateWithDuration(1, delay: delay, options: nil, animations: {
            () -> Void in
            self.titleLabel.alpha = 0
            self.titleLabel.text = title
            self.titleLabel.alpha = 1
            }, completion: nil)
    }
    
    func delayTime(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    override func  prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWebpage" {
            ((segue.destinationViewController as! UINavigationController).viewControllers[0] as! WebViewController).url = sender as! NSURL
        }
    }
}