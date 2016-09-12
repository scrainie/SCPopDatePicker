//
//  SCPopDatePicker.swift
//  SCPopDatePicker
//
//  Created by Stewart Crainie on 12/09/2016.
//  Copyright © 2016 Stewart Crainie. All rights reserved.
//

import UIKit

extension UIScreen {
    func onePixelSize() -> CGFloat {
        return 1.0 / self.scale
    }
}

//DatePicker Mode
public enum SCDatePickerType {
    case date, time, countdown
    public func dateType() -> UIDatePickerMode {
        switch self {
        case SCDatePickerType.date: return .Date
        case SCDatePickerType.time: return .DateAndTime
        case SCDatePickerType.countdown: return .CountDownTimer
        }
    }
}

public class SCPopDatePicker: UIView {

    
    //Properties
    private var containerView: UIView!
    private var contentView: UIView!
    private var datePickerView: UIDatePicker!
    
    //Custom Properties
    public var showBlur = true //Default Yes
    public var datePickerType: SCDatePickerType!
    public var tapToDismiss = true //Default Yes
    
    public init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clearColor()
        
    }

    
    public func show(attachToView view: UIView) {
        self.show(self, inView: UIApplication.sharedApplication().keyWindow!)
    }

    
    private func show(contentView: UIView, inView: UIView) {

        self.contentView = inView
        
        if tapToDismiss {
            let tap = UITapGestureRecognizer(target: self, action: #selector(SCPopDatePicker.dismiss(_:)))
            self.contentView.addGestureRecognizer(tap)
        }
        
        self.containerView = UIView()
        self.containerView.frame = CGRectMake(0, 0, inView.bounds.width, inView.bounds.height)
        self.containerView.backgroundColor = UIColor.clearColor()
    
        
        inView.addSubview(self.containerView)
        
        if showBlur {
            _showBlur()
        }
        
        self.datePickerView = createDatePicker()
        self.containerView.addSubview(self.datePickerView)
    }
    
    //Handle Tap Dismiss
    func dismiss(sender: UITapGestureRecognizer? = nil) {
        print("view tapped")
    }
    
    //Show Blur Effect
    private func _showBlur() {
    
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.contentView.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        self.containerView.addSubview(blurEffectView)

    }
    
    //Create DatePicker
    private func createDatePicker() -> UIDatePicker {
        let datePickerView: UIDatePicker = UIDatePicker(frame: CGRect(x: 0, y: CGRectGetMaxY(self.containerView.frame) - 216, width: self.containerView.bounds.width, height: 216))
        datePickerView.clipsToBounds = true
        datePickerView.backgroundColor = UIColor.whiteColor()
        datePickerView.datePickerMode = self.datePickerType.dateType()
        return datePickerView
    }
    
    
    public override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
