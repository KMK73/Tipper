//
//  ViewController.swift
//  Tipper
//
//  Created by Simple Solutions on 2/9/17.
//  Copyright © 2017 Kelsey Kjeldsen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var percentSegmentControl: UISegmentedControl!
    
    let defaults = UserDefaults.standard
    let lightGreen = UIColor(red: 43.0/255.0, green: 252.0/255.0, blue: 188.0/255.0, alpha: 1.0)
    let lightGrey = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 241.0/255.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Start color off with a default value
        var color = lightGreen
        
        if let backColor = defaults.object(forKey:"themeColor") as? String {
            switch backColor {
                case "lightGreen": color = lightGreen
                case "lightGrey": color = lightGrey
                default: break
            }
        }
    
        view.backgroundColor = color
        
        
        //reflect default value if not nil in segment control 
        percentSegmentControl.selectedSegmentIndex = defaults.integer(forKey: "defaultTipSelectedIndex")
        
        if(billTextField.text != nil){
            calculateTip(self)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //print("view did disappear")
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        //tip array
        let tipPercentages = [0.18, 0.2, 0.25]
        
        //get bill value default 0
        let bill = Double(billTextField.text!) ?? 0
        let tip = bill * tipPercentages[percentSegmentControl.selectedSegmentIndex]
        let total = bill * tip;
        
        //set labels
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func OnTap(_ sender: Any) {
        view.endEditing(true)
    }
}

