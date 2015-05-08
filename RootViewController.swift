//
//  RootViewController.swift
//  AdityaChugh
//
//  Created by Aditya Chugh on 2015-04-21.
//  Copyright (c) 2015 Aditya Chugh. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageViewController: UIPageViewController!
    var pageContents: [PageContent] = []
    var viewControllers: [InitialViewController] = []
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.blackColor()
        setupData()
        setupViewControllers()
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        var startVC = self.viewControllerAtIndex(0) as InitialViewController
        startVC.isFirstViewController = true
        var viewControllers: [InitialViewController] = [startVC]
        
        self.pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    func setupViewControllers() {
        for var i = 0; i < pageContents.count; ++i {
        var vc :InitialViewController = self.storyboard?.instantiateViewControllerWithIdentifier("InitialViewController") as! InitialViewController
        vc.pageContent = pageContents[i]
        vc.pageIndex = i
        self.viewControllers.append(vc)
        }
    }
    
    func setupData() {
        var page1 = PageContent(title: "Hi", firstLine: "My name is Aditya Chugh,", secondLine: "I'm 16 years old,", thirdLine: "and I'm an iOS development teacher!", backgroundImageName: "Background1.jpg", iconImageName: "Profile Picture.jpg")
        page1.audioFileName = "Page1"
        page1.audioFileExtension = "m4a"
        page1.pictureDelay = 1.5
        
        var page2 = PageContent(title: "Education", firstLine: "I'm currently studying", secondLine: "in grade 11,", thirdLine: "in the IB program!", backgroundImageName: "Background2.jpg", iconImageName: "IB Logo.jpg")
        page2.audioFileName = "Page2"
        page2.audioFileExtension = "m4a"
        page2.titleAnimation = "zoomIn"
        page2.firstLineAnimation = "zoomIn"
        page2.secondLineAnimation = "zoomIn"
        page2.thirdLineAnimation = "zoomIn"
        page2.pictureAnimation = "slideLeft"
        page2.pictureDelay = 2.5
        page2.action = {
            self.performSegueWithIdentifier("showWebpage", sender: NSURL(string: "http://www.ibo.org/en/university-admission/benefits-to-universities-and-colleges-of-accepting-ib-students/"))
        }
        
        var page3 = PageContent(title: "Teaching", firstLine: "I teach iOS App Development at the", secondLine: "Software Dev Club", thirdLine: "and\nSpark Education!", backgroundImageName: "Background3.jpg", iconImageName: "Sparked Logo.png")
        page3.audioFileName = "Page3"
        page3.audioFileExtension = "m4a"
        page3.titleAnimation = "fadeInUp"
        page3.firstLineAnimation = "fadeInUp"
        page3.secondLineAnimation = "fadeInUp"
        page3.thirdLineAnimation = "fadeInUp"
        page3.pictureAnimation = "squeezeRight"
        page3.pictureDelay = 2.5
        page3.action = {
            self.performSegueWithIdentifier("showWebpage", sender: NSURL(string: "http://www.sparkeducation.ca/junior-creators#instructors"))
        }
        
        var page4 = PageContent(title: "More", firstLine: "Want to learn more?", secondLine: "Tap the", thirdLine: "image below!", backgroundImageName: "Background4.jpg", iconImageName: "Profile Picture.jpg")
        page4.audioFileName = "Page4"
        page4.audioFileExtension = "m4a"
        page4.pictureDelay = 2.5
        page4.titleAnimation = "slideDown"
        page4.firstLineAnimation = "slideDown"
        page4.secondLineAnimation = "slideDown"
        page4.thirdLineAnimation = "slideDown"
        page4.pictureAnimation = "slideUp"
        page4.action = {
            self.performSegueWithIdentifier("showMenu", sender: self)
        }
        
        pageContents.append(page1)
        pageContents.append(page2)
        pageContents.append(page3)
        pageContents.append(page4)
    }
    
    func viewControllerAtIndex(index:Int) -> InitialViewController {
        if (self.pageContents.count == 0) || (index >= self.pageContents.count) {
            return InitialViewController()
        }
        
        return viewControllers[index]
    }
    
    //UIPageViewControllerDelegate
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var vc = viewController as! InitialViewController
        var index = vc.pageIndex
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index = index - 1 //--index isn't working for some reason
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var vc = viewController as! InitialViewController
        var index = vc.pageIndex
        if index == NSNotFound {
            return nil
        }
        index = index + 1 //++index isn't working for some reason
        if index == self.pageContents.count {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageContents.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [AnyObject]) {
        for vc in pendingViewControllers as! [InitialViewController] {
            if vc.animationHasCompleted == false {
                vc.startAnimation()
                vc.animationHasCompleted = true
            }
        }
    }
    
    //Misc
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWebpage" {
            ((segue.destinationViewController as! UINavigationController).viewControllers[0] as! WebViewController).url = sender as! NSURL
        }
    }
}
