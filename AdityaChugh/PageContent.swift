//
//  PageContent.swift
//  AdityaChugh
//
//  Created by Aditya Chugh on 2015-04-21.
//  Copyright (c) 2015 Aditya Chugh. All rights reserved.
//

import Foundation
import UIKit

class PageContent {
    
    var title: String!
    var firstLine: String!
    var secondLine: String!
    var thirdLine: String!
    var backgroundImage: UIImage!
    var iconImage: UIImage!
    var titleAnimation = "slideRight"
    var firstLineAnimation = "slideRight"
    var secondLineAnimation = "slideRight"
    var thirdLineAnimation = "slideRight"
    var pictureAnimation = "zoomIn"
    var audioFileName: String!
    var audioFileExtension: String!
    var pictureDelay: CGFloat = 2
    var performPicturePop = false
    var action:(()->())?
    
    init(title: String, firstLine: String, secondLine: String, thirdLine: String, backgroundImageName: String, iconImageName: String) {
        self.title = title
        self.firstLine = firstLine
        self.secondLine = secondLine
        self.thirdLine = thirdLine
        self.iconImage = UIImage(named: iconImageName)!
        self.backgroundImage = UIImage(named: backgroundImageName)!
    }
}