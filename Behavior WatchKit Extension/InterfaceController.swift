//
//  InterfaceController.swift
//  Behavior WatchKit Extension
//
//  Created by Eric Buess on 9/11/16.
//  Copyright © 2016 Eric Buess. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBAction func resetMenuItemTapped() {
        firstGood = 0
//        firstBad = 0
        secondGood = 0
//        secondBad = 0
    }
    
    let appGroupDefaults = UserDefaults(suiteName: "com.ericbuess.Behavior")
    
    var firstGood = 0 {
        didSet {
            if firstGood < 0 {
                firstGood = 0
            }
            firstUpButton.setTitle("\(firstGood)")
        }
    }
    
    var secondGood = 0 {
        didSet {
            if secondGood < 0 {
                secondGood = 0
            }
            secondUpButton.setTitle("\(secondGood)")
        }
    }
    
//    var firstBad = 0 {
//        didSet {
//            if firstBad > 0 {
//                firstBad = 0
//            }
//            firstDownButton.setTitle("\(firstBad)")
//        }
//    }
    
//    var secondBad = 0 {
//        didSet {
//            if secondBad > 0 {
//                secondBad = 0
//            }
//            secondDownButton.setTitle("\(secondBad)")
//        }
//    }
    
    @IBOutlet var firstUpButton: WKInterfaceButton!

//    @IBOutlet var firstDownButton: WKInterfaceButton!
    
    @IBOutlet var secondUpButton: WKInterfaceButton!
    
//    @IBOutlet var secondDownButton: WKInterfaceButton!
    
    @IBAction func firstUpButtonTapped() {
        firstGood += 1
    }
    
//    @IBAction func firstDownButtonTapped() {
//        firstBad -= 1
//    }
    
    @IBAction func secondUpButtonTapped() {
        secondGood += 1
    }
    
//    @IBAction func secondDownButtonTapped() {
//        secondBad -= 1
//    }
    
    @IBAction func firstUpButtonSwipedDown(_ sender: AnyObject) {
        firstGood -= 1
    }
    
    @IBAction func secondUpButtonSwipedDown(_ sender: AnyObject) {
        secondGood -= 1
    }
    
//    @IBAction func firstDownButtonSwipedUp(_ sender: AnyObject) {
//        firstBad += 1
//    }
    
//    @IBAction func secondDownButtonSwipedUp(_ sender: AnyObject) {
//        secondBad += 1
//    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        firstGood = appGroupDefaults?.value(forKey: "firstGood") as? Int ?? 0
        secondGood = appGroupDefaults?.value(forKey: "secondGood") as? Int ?? 0
//        firstBad = appGroupDefaults?.value(forKey: "firstBad") as? Int ?? 0
//        secondBad = appGroupDefaults?.value(forKey: "secondBad") as? Int ?? 0
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        var changes = false
        if appGroupDefaults?.value(forKey: "firstGood") as? Int != firstGood {
            appGroupDefaults?.set(firstGood, forKey: "firstGood")
            changes = true
        }
        if appGroupDefaults?.value(forKey: "secondGood") as? Int != secondGood {
            appGroupDefaults?.set(secondGood, forKey: "secondGood")
            changes = true
        }
//        if appGroupDefaults?.value(forKey: "firstBad") as? Int != firstBad {
//            appGroupDefaults?.set(firstBad, forKey: "firstBad")
//            changes = true
//        }
//        if appGroupDefaults?.value(forKey: "secondBad") as? Int != secondBad {
//            appGroupDefaults?.set(secondBad, forKey: "secondBad")
//            changes = true
//        }
        if changes {
            appGroupDefaults?.synchronize()
            let server=CLKComplicationServer.sharedInstance()
            for comp in (server.activeComplications)! {
                server.reloadTimeline(for: comp)
            }
        }
        
    }
}
