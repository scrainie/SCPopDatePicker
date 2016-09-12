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

enum DatePickerType {
    case <#case#>
}


public class SCPopDatePicker: UIView {

    
    //Properties
    private var containerView: UIView!
    private var contentView: UIView!
    
    
    //Custom Properties
    public var showBlur = true //Default Yes
    
    public init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clearColor()
    }

    
    public func show(attachToView view: UIView) {
        self.show(self, inView: UIApplication.sharedApplication().keyWindow!)
    }

    
    private func show(contentView: UIView, inView: UIView) {

        self.contentView = inView
        
        self.containerView = UIView()
        self.containerView.frame = CGRectMake(0, 0, inView.bounds.width, inView.bounds.height)
        self.containerView.backgroundColor = UIColor.clearColor()
        self.containerView.layer.cornerRadius = 7.5
        
        inView.addSubview(self.containerView)
        
        if showBlur {
            _showBlur()
        }
        
        self.containerView.addSubview(createDatePicker())
    }
    
    private func _showBlur() {
    
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.contentView.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        self.containerView.addSubview(blurEffectView)

    }
    
    private func createDatePicker() -> UIDatePicker {
        let datePickerView: UIDatePicker = UIDatePicker(frame: CGRect(x: 5, y: self.containerView.frame.height / 2, width: self.containerView.bounds.width, height: self.containerView.bounds.height / 2))
        datePickerView.backgroundColor = UIColor.whiteColor()
        return datePickerView
    }
    
    
    public override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
