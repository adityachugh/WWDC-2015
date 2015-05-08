//
//  Category.swift
//  AdityaChugh
//
//  Created by Aditya Chugh on 2015-04-22.
//  Copyright (c) 2015 Aditya Chugh. All rights reserved.
//

import Foundation
import UIKit

class Category: Fact {
    
    init(title: String, facts: [Fact]) {
        super.init(title: title, text: nil, image: nil)
        self.facts = facts
    }
    
    func addFact(fact:Fact) {
        self.facts?.append(fact)
    }
    
    var facts: [Fact]?
    
    
}