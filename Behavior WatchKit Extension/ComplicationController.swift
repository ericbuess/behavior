//
//  ComplicationController.swift
//  Behavior WatchKit Extension
//
//  Created by Eric Buess on 9/11/16.
//  Copyright © 2016 Eric Buess. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
//        var data : Dictionary =
        var entry : CLKComplicationTimelineEntry?
        let now = Date()
        
        // Create the template and timeline entry
        if complication.family == .modularSmall {
//            let longText = data[
            let textTemplate = CLKComplicationTemplateModularSmallStackText()
            
//textProviderWithStartDate:[NSDate date] endDate:[NSDate dateWithTimeIntervalSinceNow:((6*60*60)+(18*60))];
        
            let appGroupDefaults = UserDefaults(suiteName: "com.ericbuess.Behavior")
            let child1 = appGroupDefaults?.value(forKey: "child1") as! Int
            let child2 = appGroupDefaults?.value(forKey: "child2") as! Int
//            let firstBad = appGroupDefaults?.value(forKey: "firstBad") as! Int
//            let secondBad = appGroupDefaults?.value(forKey: "secondBad") as! Int
//            textTemplate.line1TextProvider = CLKSimpleTextProvider.init(text: "\(firstGood) \(firstBad)")
//            textTemplate.line2TextProvider = CLKSimpleTextProvider.init(text: "\(secondGood) \(secondBad)")
            textTemplate.line1TextProvider = CLKSimpleTextProvider.init(text: "\(child1)")
            textTemplate.line2TextProvider = CLKSimpleTextProvider.init(text: "\(child2)")
            textTemplate.highlightLine2 = false
            entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: textTemplate)
        }
        handler(entry)
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }
    
}
