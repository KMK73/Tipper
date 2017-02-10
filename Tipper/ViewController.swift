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

        setDefaultValues()
        
        if(billTextField.text != nil){
            calculateTip(self)
        }
        
    }
    
    private func setDefaultValues() {
        
        //reflect default value if not nil in segment control
        percentSegmentControl.selectedSegmentIndex = DefaultService.getDefaultTipIndex()
        view.backgroundColor = DefaultService.getBackgroundColor()
        
        let defaultBillAmount = DefaultService.getDefaultBillAmount()
        billTextField.text = String(defaultBillAmount)
    }
    
    private func saveToDefaultService() {
        DefaultService.saveBillAmount(billAmount: Double(billTextField.text!) ?? 0)
        DefaultService.saveLastOpenedDate()
    }
    
    func appDidEnterBackground() {
        //save when user enters background 
        saveToDefaultService()
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        //tip array
        let tipPercentages = [0.18, 0.2, 0.25]
        
        //get bill value default 0
        let bill = Double(billTextField.text!) ?? 0
        let tip = bill * tipPercentages[percentSegmentControl.selectedSegmentIndex]
        DefaultService.saveTipIndex(index: percentSegmentControl.selectedSegmentIndex)
        let total = bill * tip;
        
        //set labels
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        saveToDefaultService()
    }
    
    @IBAction func OnTap(_ sender: Any) {
        view.endEditing(true)
    }


}

