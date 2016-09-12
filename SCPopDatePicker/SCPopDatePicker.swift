//
//  SCPopDatePicker.swift
//  SCPopDatePicker
//
//  Created by Stewart Crainie on 12/09/2016.
//  Copyright © 2016 Stewart Crainie. All rights reserved.
//

import UIKit

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
        
        inView.addSubview(self.containerView)
        
        if showBlur {
            _showBlur()
        }
    }
    
    private func _showBlur() {
    
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.contentView.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        self.containerView.addSubview(blurEffectView)

    }
    
    public override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
