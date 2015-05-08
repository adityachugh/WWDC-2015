//
//  Ball.swift
//  AdityaChugh
//
//  Created by Aditya Chugh on 2015-04-21.
//  Copyright (c) 2015 Aditya Chugh. All rights reserved.
//

import UIKit
import QuartzCore

class Square: SpringView {
    
    @IBOutlet var tapRecognizer: UITapGestureRecognizer!
    @IBOutlet var view: UIView!
    @IBOutlet weak var text: UILabel!
    private var fact: Fact!
    var delegate: SquareDelegate!
    var factOrCategory: Fact {
        get {
            return fact
        }
        set {
            fact = newValue
            self.text.text = fact.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSBundle.mainBundle().loadNibNamed("Square", owner: self, options: nil)
        self.bounds = self.view.bounds
        self.addSubview(view)
        setup()
    }
    
    convenience init(frame: CGRect, fact: Fact) {
        self.init(frame: frame)
        self.factOrCategory = fact
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("Square", owner: self, options: nil)
        self.addSubview(view)
        setup()
    }
    
    private func setup() {
        var cornerRadius = self.view.frame.width / 8
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.animation = "zoomOut"
        self.duration = 1
        var colorArray = [UIColor.turquoiseColor(), UIColor.peterRiverColor(), UIColor.amethystColor(), UIColor.concreteColor()]
        var randomNum = Int(arc4random_uniform(UInt32(colorArray.count)))
        view.backgroundColor = colorArray[randomNum]
    }
    
    
    @IBAction private func viewTapped(sender: UITapGestureRecognizer) {
        delegate.viewTapped(self)
    }
}

protocol SquareDelegate {
    func viewTapped(sender:Square)
}