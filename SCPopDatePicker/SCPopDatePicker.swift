//
//  SCPopDatePicker.swift
//  SCPopDatePicker
//
//  Created by Stewart Crainie on 12/09/2016.
//  Copyright © 2016 Stewart Crainie. All rights reserved.
//

import UIKit

protocol SCPopDatePickerDelegate: NSObjectProtocol {
    func scPopDatePickerDidSelectDate(date: NSDate)
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

public class SCPopDatePicker: UIView, UIGestureRecognizerDelegate {
    
    //Delegate
    var delegate: SCPopDatePickerDelegate?
    
    //Properties
    private var containerView: UIView!
    private var contentView: UIView!
    private var backgroundView: UIView!
    private var datePickerView: UIDatePicker!
    
    //Custom Properties
    public var showBlur = true //Default Yes
    public var datePickerType: SCDatePickerType!
    public var tapToDismiss = true //Default Yes
    public var btnFontColour = UIColor.blueColor() //Default Blue
    public var btnColour = UIColor.clearColor() //Default Clear
    public var datePickerStartDate = NSDate() //Optional
    public var showShadow = true //Optional
    public var showCornerRadius = true // Optional
    
    
    public init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clearColor()
        
    }
    
    
    
    public func show(attachToView view: UIView) {
        self.show(self, inView: view)
    }
    
    //Show View
    private func show(contentView: UIView, inView: UIView) {
        
        self.contentView = inView
        
        self.containerView = UIView()
        self.containerView.frame = CGRectMake(0, 0, inView.bounds.width, inView.bounds.height)
        self.containerView.backgroundColor = UIColor.clearColor()
        self.containerView.alpha = 0
        
        self.contentView.addSubview(self.containerView)
        
        
        if showBlur {
            _showBlur()
        }
        
        self.backgroundView = createBackgroundView()
        self.containerView.addSubview(self.backgroundView)
        
        self.datePickerView = createDatePicker()
        self.backgroundView.addSubview(self.datePickerView)
        
        //Round .Left / .Right Corners of DatePicker View
        if showCornerRadius {
            let path = UIBezierPath(roundedRect:self.datePickerView.bounds, byRoundingCorners:[.TopRight, .TopLeft], cornerRadii: CGSizeMake(10, 10))
            let maskLayer = CAShapeLayer()
            
            maskLayer.path = path.CGPath
            self.datePickerView.layer.mask = maskLayer
        }
        
        self.backgroundView.addSubview(self.addSelectButton())
        
        
        //Show UI Views
        UIView.animateWithDuration(0.15, animations: {
            self.containerView.alpha = 1
        }) { (success:Bool) in
            UIView.animateWithDuration(0.30, delay: 0, options: .TransitionCrossDissolve, animations: {
                self.backgroundView.frame.origin.y = self.containerView.bounds.height / 2 - 125
                }, completion: { (success:Bool) in
                    
            })
        }
        
        if tapToDismiss {
            let tap = UITapGestureRecognizer(target: self, action: #selector(SCPopDatePicker.dismiss(_:)))
            tap.delegate = self
            self.containerView.addGestureRecognizer(tap)
        }
        
        self.layoutSubviews()
    }
    
    
    //Handle Tap Dismiss
    func dismiss(sender: UITapGestureRecognizer? = nil) {
        UIView.animateWithDuration(0.15, animations: {
            self.backgroundView.frame.origin.y += CGRectGetMaxY(self.containerView.bounds)
        }) { (success:Bool) in
            
            UIView.animateWithDuration(0.05, delay: 0, options: .TransitionCrossDissolve, animations: {
                self.containerView.alpha = 0
                }, completion: { (success:Bool) in
                    self.containerView.removeGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(SCPopDatePicker.dismiss(_:))))
                    self.contentView.removeFromSuperview()
                    self.containerView.removeFromSuperview()
                    self.removeFromSuperview()
            })
            
        }
        
        
    }
    
    //Show Blur Effect
    private func _showBlur() {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.contentView.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        self.containerView.addSubview(blurEffectView)
        
    }
    
    //Create DatePicker
    private func createDatePicker() -> UIDatePicker {
        let datePickerView: UIDatePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.backgroundView.bounds.width, height: self.backgroundView.bounds.height))
        datePickerView.date = self.datePickerStartDate
        datePickerView.autoresizingMask = [.FlexibleWidth]
        datePickerView.clipsToBounds = true
        datePickerView.backgroundColor = UIColor.whiteColor()
        datePickerView.datePickerMode = self.datePickerType.dateType()
        return datePickerView
    }
    //
    //Create Background Container View
    private func createBackgroundView() -> UIView {
        let bgView = UIView(frame: CGRect(x: self.containerView.frame.width / 2 - 150, y: CGRectGetMaxY(self.containerView.bounds) + 100, width: 300, height: 160))
        bgView.autoresizingMask = [.FlexibleWidth]
        bgView.backgroundColor = UIColor.whiteColor()
        
        if showShadow {
            bgView.layer.shadowOffset = CGSize(width: 3, height: 3)
            bgView.layer.shadowOpacity = 0.7
            bgView.layer.shadowRadius = 2
        }
        if showCornerRadius {
            bgView.layer.cornerRadius = 10.0
        }
        return bgView
    }
    
    private func addSelectButton() -> UIButton {
        
        let btn = UIButton(type: .System)
        btn.frame = CGRect(x: self.backgroundView.frame.width / 2 - 150, y: self.datePickerView.frame.maxY, width: self.backgroundView.frame.size.width, height: 48)
        btn.setTitle("Select", forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(20)
        btn.tintColor = self.btnFontColour
        btn.backgroundColor = self.btnColour
        btn.addTarget(self, action: #selector(SCPopDatePicker.didSelectDate(_:)), forControlEvents: .TouchUpInside)
        
        if showCornerRadius {
            btn.layer.cornerRadius = 10.0
        }
        
        return btn
    }
    
    @objc private func didSelectDate(sender: UIButton) {
        if delegate != nil {
            self.delegate?.scPopDatePickerDidSelectDate(self.datePickerView.date)
            self.dismiss()
        }
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
