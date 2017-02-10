//
//  SettingsViewController.swift
//  Tipper
//
//  Created by Simple Solutions on 2/9/17.
//  Copyright © 2017 Kelsey Kjeldsen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var themeLabel: UILabel!
    
    let defaults = UserDefaults.standard
    let lightGreen = UIColor(red: 43.0/255.0, green: 252.0/255.0, blue: 188.0/255.0, alpha: 1.0)
    let lightGrey = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //reflect default value if not nil in segment control
        defaultTipControl.selectedSegmentIndex = defaults.integer(forKey: "defaultTipSelectedIndex")
        
        // Start color off with a default value
        var color = lightGreen
        
        if let backColor = defaults.object(forKey:"themeColor") as? String {
            switch backColor {
            case "lightGreen":
                color = lightGreen
                themeSwitch.isOn = false;
            case "lightGrey":
                color = lightGrey
                themeSwitch.isOn = true;
            default: break
            }
        }
        
       view.backgroundColor = color
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func changeDefaultTip(_ sender: Any) {
        //save key to defaults
        defaults.set(defaultTipControl.selectedSegmentIndex, forKey: "defaultTipSelectedIndex")
        defaults.synchronize()
    }
    
    @IBAction func themeChanged(_ sender: Any) {
        //change the backgrounds of the app 
        //if switched on theme is grey
        
        if(themeSwitch.isOn){
            //change to grey 
            view.backgroundColor = lightGrey
            //change defaults 
            defaults.set("lightGrey", forKey: "themeColor")
            defaults.synchronize()
        } else {
            //change to green
            view.backgroundColor = lightGreen
            //change defaults
            defaults.set("lightGreen", forKey: "themeColor")
            defaults.synchronize()
            
        }
        
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
