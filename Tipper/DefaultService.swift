//
//  DefaultService.swift
//  Tipper
//
//  Created by Simple Solutions on 2/10/17.
//  Copyright © 2017 Kelsey Kjeldsen. All rights reserved.
//

import Foundation
import UIKit

class DefaultService {
    static let TIP_INDEX_KEY = "defaultTipSelectedIndex"
    static let BILL_AMOUNT_KEY = "default_bill_amount"
    static let LAST_OPENED_DATE_KEY = "last_opened_date"
    static let THEME_COLOR_KEY = "theme_color"

    static let DEFAULT_BILL_AMOUNT = 0.0
    // 10 minutes in seconds
    static let EXPIRED_TIME_LIMIT: Double = 60 * 10
    static let LIGHT_GREEN = UIColor(red: 43.0/255.0, green: 252.0/255.0, blue: 188.0/255.0, alpha: 1.0)
    static let LIGHT_GREY = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    var sharedInstance: DefaultService!
    
    
    // SET BACKGROUND COLOR 
    static func getBackgroundColor() -> UIColor {
        let defaults = UserDefaults.standard

        // Start color off with a default value
        var color = LIGHT_GREEN
        
        if let backColor = defaults.object(forKey:THEME_COLOR_KEY) as? String {
            switch backColor {
                case "lightGreen": color = LIGHT_GREEN
                case "lightGrey": color = LIGHT_GREY
                default: break
            }
        }
        
        return color
        
    }
    
    // GET THEME COLOR STRING
    static func getThemeSwitchValue() -> Bool{
        
        //grey is on 
        let color = getBackgroundColor()
        if(color == LIGHT_GREY){
            return true
        }
        
        //green off 
        return false
    }
    
    // SAVE THEME COLOR STRING 
    static func saveThemeToService(string: String, withKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(string, forKey: key)
        defaults.synchronize()
    }
    
    static func getDefaultTipIndex() -> Int {
        return getSavedIntegerForKey(key: TIP_INDEX_KEY)
    }
    
    static func getDefaultBillAmount() -> Double {
        let billAmount = getSavedDoubleForKey(key: BILL_AMOUNT_KEY)
        
        if billAmount == 0 || shouldClearBillAmount() {
            return DEFAULT_BILL_AMOUNT
        }
        
        return billAmount
    }
    
    static func getLastOpenedDate() -> NSDate {
        let defaults = UserDefaults.standard
        let lastOpenedDate = defaults.object(forKey: LAST_OPENED_DATE_KEY)
        
        if lastOpenedDate == nil {
            return NSDate()
        }
        
        return lastOpenedDate! as! NSDate
    }
    
    static func saveTipIndex(index: Int) {
        saveIntegerToService(integer: index, withKey: TIP_INDEX_KEY)
    }
    
    static func saveBillAmount(billAmount: Double) {
        saveDoubleToToService(double: billAmount, withKey: BILL_AMOUNT_KEY)
    }
    
    static func saveLastOpenedDate() {
        let defaults = UserDefaults.standard
        defaults.object(forKey: LAST_OPENED_DATE_KEY)
        defaults.synchronize()
    }
    
    static private func getSavedIntegerForKey(key: String) -> Int {
        // returns 0 if key nil
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: key)
    }
    static private func saveIntegerToService(integer: Int, withKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(integer, forKey: key)
        defaults.synchronize()
    }
    
    static private func getSavedDoubleForKey(key: String) -> Double {
        let defaults = UserDefaults.standard
        return defaults.double(forKey: key)
    }
    
    static private func saveDoubleToToService(double: Double, withKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(double, forKey: key)
        defaults.synchronize()
    }
    
    static private func shouldClearBillAmount() -> Bool {
        let lastOpenedDate = getLastOpenedDate()
        return lastOpenedDate.timeIntervalSinceNow * -1.0 > EXPIRED_TIME_LIMIT
    }
}
