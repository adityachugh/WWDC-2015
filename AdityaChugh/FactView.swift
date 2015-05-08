//
//  FactView.swift
//  AdityaChugh
//
//  Created by Aditya Chugh on 2015-04-24.
//  Copyright (c) 2015 Aditya Chugh. All rights reserved.
//

import UIKit

class FactView: SpringView {

    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var linkHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet var view: UIView!
    @IBOutlet weak var titleLabel: DesignableLabel!
    @IBOutlet weak var imageView: DesignableImageView!
    @IBOutlet weak var textView: DesignableTextView!
    var currentFact: Fact!
    var presentingViewController: UIViewController!
    var fact: Fact {
        get {
            return currentFact
        }
        set {
            currentFact = newValue
            titleLabel.text = currentFact.title
            imageView.image = currentFact.image
            textView.text = currentFact.text
            linkButton.setTitle(currentFact.actionText, forState: UIControlState.Normal)
        }
    }
    
    @IBAction func performAction(sender: AnyObject) {
        fact.action?(viewController: presentingViewController)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSBundle.mainBundle().loadNibNamed("FactView", owner: self, options: nil)
        self.bounds = self.view.bounds
        self.addSubview(view)
    }
    
    convenience init(frame: CGRect, fact: Fact) {
        self.init(frame: frame)
        self.fact = fact
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("FactView", owner: self, options: nil)
        self.addSubview(view)
    }
    
}
