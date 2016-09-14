//
//  ViewController.swift
//  SCPopDatePicker
//
//  Created by Stewart Crainie on 12/09/2016.
//  Copyright © 2016 Stewart Crainie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SCPopDatePickerDelegate {

    
    let datePicker = SCPopDatePicker()
    let date = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        self.datePicker.tapToDismiss = true
        self.datePicker.datePickerType = SCDatePickerType.date
        self.datePicker.showBlur = true
        self.datePicker.datePickerStartDate = self.date
        self.datePicker.btnFontColour = UIColor.whiteColor()
        self.datePicker.btnColour = UIColor.darkGrayColor()
        self.datePicker.showCornerRadius = false
        self.datePicker.delegate = self
        self.datePicker.show(attachToView: self.view)
    }
    
    func scPopDatePickerDidSelectDate(date: NSDate) {
        print(date)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

