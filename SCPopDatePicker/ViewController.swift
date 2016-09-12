//
//  ViewController.swift
//  SCPopDatePicker
//
//  Created by Stewart Crainie on 12/09/2016.
//  Copyright © 2016 Stewart Crainie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let datePicker = SCPopDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        datePicker.tapToDismiss = true
        datePicker.datePickerType = SCDatePickerType.date
        datePicker.showBlur = true
        datePicker.show(attachToView: self.view)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

