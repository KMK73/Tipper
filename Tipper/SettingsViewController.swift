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
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //reflect default value if not nil in segment control
        defaultTipControl.selectedSegmentIndex = defaults.integer(forKey: "defaultTipSelectedIndex")
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
