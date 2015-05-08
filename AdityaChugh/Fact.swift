//
//  Fact.swift
//  AdityaChugh
//
//  Created by Aditya Chugh on 2015-04-22.
//  Copyright (c) 2015 Aditya Chugh. All rights reserved.
//

import Foundation
import UIKit

class Fact : NSObject {
    
    init(title:String, text:String?, image:UIImage?) {
        self.title = title
        self.text = text
        self.image = image
    }
    
    var action:((viewController:UIViewController)->())?
    var actionText: String?
    var title: String!
    var text: String?
    var image: UIImage?
    var isCategory: Bool {
        get {
            return self.isKindOfClass(Category)
        }
    }
}