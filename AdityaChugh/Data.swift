//
//  Data.swift
//  AdityaChugh
//
//  Created by Aditya Chugh on 2015-04-25.
//  Copyright (c) 2015 Aditya Chugh. All rights reserved.
//

import Foundation
import UIKit

class Data {
    
    class func getData() -> [Fact] {
        var data: [Fact] = []
        
        data.append(self.interests())
        data.append(self.technicalSkills())
        data.append(self.extraCurriculars())
        data.append(self.achievements())
        data.append(self.future())
        data.append(self.apps())
        data.append(self.teaching())

        
        return data
    }
    
    class func teaching() -> Fact {
        var teaching = Fact(title: "Teaching", text: "Last year I started the first Software Development Club to teach iOS development at my school. Since then over 20 students have learned to develop iOS apps, and are actively involved in developing apps for the school. I have also been hired by Spark Education, as their lead iOS Development teacher. I already taught my first lesson there, and will be teaching more this summer.", image: UIImage(named: "Teaching"))
        teaching.action = {
            (viewController:UIViewController) -> () in
            viewController.performSegueWithIdentifier("showWebpage", sender: NSURL(string: "http://www.sparkeducation.ca/junior-creators#instructors"))
        }
        teaching.actionText = "SparkEducation.ca"
        return teaching
    }
    
    class func interests() -> Fact {
        var interests = Category(title: "Interests", facts: [])
        
        interests.addFact(Fact(title: "Programming", text: nil, image: nil))
        interests.addFact(Fact(title: "Tennis", text: nil, image: nil))
        interests.addFact(Fact(title: "Graphic Design", text: nil, image: nil))
        interests.addFact(Fact(title: "Reading", text: nil, image: nil))
        interests.addFact(Fact(title: "Cars & Driving", text: nil, image: nil))
        interests.addFact(Fact(title: "Photography", text: nil, image: nil))
        interests.addFact(Fact(title: "Music", text: nil, image: nil))
        interests.addFact(Fact(title: "Teaching", text: nil, image: nil))
        interests.addFact(Fact(title: "Technology", text: nil, image: nil))
        
        return interests
    }
    
    class func technicalSkills() -> Fact {
        var technicalSkills = Category(title: "Technical Skills", facts: [])
        
        technicalSkills.addFact(Fact(title: "Swift \n(Obviously)", text: nil, image: nil))
        technicalSkills.addFact(Fact(title: "Objective C", text: nil, image: nil))
        technicalSkills.addFact(Fact(title: "C++", text: nil, image: nil))
        technicalSkills.addFact(Fact(title: "Java", text: nil, image: nil))
        technicalSkills.addFact(Fact(title: "HTML 5", text: nil, image: nil))
        technicalSkills.addFact(Fact(title: "JS", text: nil, image: nil))
        technicalSkills.addFact(Fact(title: "SQL", text: nil, image: nil))
        technicalSkills.addFact(Fact(title: "Parse", text: nil, image: nil))
        technicalSkills.addFact(Fact(title: "Photoshop", text: nil, image: nil))
        technicalSkills.addFact(Fact(title: "Sketch", text: nil, image: nil))
        technicalSkills.addFact(Fact(title: "Aperture", text: nil, image: nil))
        technicalSkills.addFact(Fact(title: "Arduino", text: nil, image: nil))
        
        return technicalSkills
    }

    class func extraCurriculars() -> Fact {
        var extraCurriculars = Category(title: "Extra Curriculars", facts: [])
        
        extraCurriculars.addFact(Fact(title: "Robotics Club", text: nil, image: nil))
        extraCurriculars.addFact(Fact(title: "School Apps", text: nil, image: nil))
        extraCurriculars.addFact(Fact(title: "School CTO", text: nil, image: nil))
        extraCurriculars.addFact(Fact(title: "High Tech Helper", text: nil, image: nil))
        extraCurriculars.addFact(Fact(title: "Hackathons", text: nil, image: nil))
        
        return extraCurriculars
    }
    
    class func achievements() -> Fact {
        var achievements = Category(title: "Achievements", facts: [])
        
        achievements.addFact(Fact(title: "Software Dev Club", text: "Last year I started the first Software Development Club to teach iOS development at my school. Since then over 20 students have learned to develop iOS apps, and are actively involved in developing apps for the school.", image: UIImage(named: "Software Dev Club")))
        
        var hth = Fact(title: "High Tech Helper", text: "In grade 9, I co-founded High Tech Helper, a website dedicated to providing high quality tech news. We've received over 50,000 visitors in the past 2 years.", image: UIImage(named: "High Tech Helper"))
        hth.action = {
            (viewController:UIViewController) -> () in
            viewController.performSegueWithIdentifier("showWebpage", sender: NSURL(string: "http://hightechhelper.com"))
        }
        hth.actionText = "HighTechHelper.com"
        achievements.addFact(hth)
        
        var sparky = Fact(title: "Sparky", text: "Sparky is an open source iOS tool to help educators teach students fundamental programming concepts. Sparky was made to remove the complications associated with learning programming. It allows beginners to create algorithms without having to deal with managing a UI and complicated language syntax.", image: UIImage(named: "Sparky"))
        sparky.action = {
            (viewController:UIViewController) -> () in
            viewController.performSegueWithIdentifier("showWebpage", sender: NSURL(string: "https://github.com/adityachugh/Sparky"))
        }
        sparky.actionText = "View on GitHub"
        achievements.addFact(sparky)
        
        return achievements
    }
    
    class func future() -> Fact {
        var future = Category(title: "Future", facts: [])
        
        future.addFact(Fact(title: "Teaching", text: "Even though I plan to make app development my full time career, I still want to continue teaching iOS and Mac development on the side. I believe that teaching is one of the best ways to improve one's communication and programming skills.", image: UIImage(named: "Teaching")))
        
        future.addFact(Fact(title: "University", text: "After finishing high school, I would like to attend University in the US. I am very interested in Stanford, as it is in the heart of the Silicon Valley, and because they have a phenomenal reputation for their Computer Science program, and not to mention their gorgeous campus. Another option I am looking into is MIT. Just like Stanford, MIT also has a great Computer Science program.", image: UIImage(named: "University")))
        
        future.addFact(Fact(title: "App Development", text: "I plan to make apps that make learning programming easier for the world. Sparky was my first attempt at this, and so far, the Spark Education community is really liking the idea; that programming is not something that you need superpowers to do, It's something anyone can do.", image: UIImage(named: "App Development")))
        
        return future
    }
    
    class func apps() -> Fact {
        var apps = Category(title: "Apps", facts: [])
        
        var minesweeper = Fact(title: "Minesweeper Mania", text: "Minesweeper Mania is a minimalistic take on the classic Minesweeper game. It is integrated with Game Center, and supports achievements as well as leaderboards. This free game, features no ads or in app purchases.", image: UIImage(named: "Minesweeper"))
        minesweeper.action = {
            (viewController:UIViewController) -> () in
            viewController.performSegueWithIdentifier("showWebpage", sender: NSURL(string: "https://itunes.apple.com/us/app/minesweeper-mania/id972938318?ls=1&mt=8"))
        }
        minesweeper.actionText = "View on App Store"
        apps.addFact(minesweeper)
        
        apps.addFact(Fact(title: "ITGS", text: "ITGS (Information Technology in a Global Society) is course taught in the IB program, and this app is intended to help students study for their exams. The is currently being reviewed by Apple, and should be available on the App Store shortly.", image: UIImage(named: "ITGS")))
        
        apps.addFact(Fact(title: "Announcements", text: "This app is an announcements system built for my school. It is meant to replace the standard announcement system:\n\n1. Make announcements accessible by students anywhere at anytime\n2. Allows students to view announcements from the past\n3. Makes the process of announcement approval hassle and paper free\n\nThis has been approved by the Student Council, and is now waiting for the approval of the school Principal. I plan to take this to the school board level in the coming year.", image: UIImage(named: "Announcements")))
        
        var sparky = Fact(title: "Sparky", text: "Sparky is an open source iOS tool to help educators teach students fundamental programming concepts. Sparky was made to remove the complications associated with learning programming. It allows beginners to create algorithms without having to deal with managing a UI and complicated language syntax.", image: UIImage(named: "Sparky"))
        sparky.action = {
            (viewController:UIViewController) -> () in
            viewController.performSegueWithIdentifier("showWebpage", sender: NSURL(string: "https://github.com/adityachugh/Sparky"))
        }
        sparky.actionText = "View on GitHub"
        apps.addFact(sparky)
        
        return apps
    }
}