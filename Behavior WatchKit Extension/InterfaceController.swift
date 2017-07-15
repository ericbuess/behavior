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
        pointsForChild1 = 0
        pointsForChild2 = 0
    }
    
    @IBAction func incrementChild1Button() {
        pointsForChild1 += 1
    }
    @IBAction func decrementChild1Button() {
        pointsForChild1 -= 1
    }
    @IBAction func incrementChild2Button() {
        pointsForChild2 += 1
    }
    @IBAction func decrementChild2Button() {
        pointsForChild2 -= 1
    }
    
    @IBOutlet var pointsForChild1Label: WKInterfaceLabel!
    
    @IBOutlet var pointsForChild2Label: WKInterfaceLabel!
    
    let appGroupDefaults = UserDefaults(suiteName: "com.ericbuess.Behavior")
    
    var pointsForChild1 = 0 {
        didSet {
            if pointsForChild1 < 0 {
                pointsForChild1 = 0
            }
            pointsForChild1Label.setText(("\(pointsForChild1)"))
        }
    }
    
    var pointsForChild2 = 0 {
        didSet {
            if pointsForChild2 < 0 {
                pointsForChild2 = 0
            }
            pointsForChild2Label.setText("\(pointsForChild2)")
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        pointsForChild1 = appGroupDefaults?.value(forKey: "child1") as? Int ?? 0
        pointsForChild2 = appGroupDefaults?.value(forKey: "child2") as? Int ?? 0
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        var changes = false
        if appGroupDefaults?.value(forKey: "child1") as? Int != pointsForChild1 {
            appGroupDefaults?.set(pointsForChild1, forKey: "child1")
            changes = true
        }
        if appGroupDefaults?.value(forKey: "child2") as? Int != pointsForChild2 {
            appGroupDefaults?.set(pointsForChild2, forKey: "child2")
            changes = true
        }
        if changes {
            appGroupDefaults?.synchronize()
            let server=CLKComplicationServer.sharedInstance()
            for comp in (server.activeComplications)! {
                server.reloadTimeline(for: comp)
            }
        }
        
    }
}
