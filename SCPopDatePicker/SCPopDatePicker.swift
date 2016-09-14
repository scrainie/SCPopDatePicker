import UIKit

protocol SCPopDatePickerDelegate: NSObjectProtocol {
    func scPopDatePickerDidSelectDate(_ date: Date)
}


//DatePicker Mode
public enum SCDatePickerType {
    case date, time, countdown
    public func dateType() -> UIDatePickerMode {
        switch self {
        case SCDatePickerType.date: return .date
        case SCDatePickerType.time: return .dateAndTime
        case SCDatePickerType.countdown: return .countDownTimer
        }
    }
}

open class SCPopDatePicker: UIView, UIGestureRecognizerDelegate {
    
    //Delegate
    var delegate: SCPopDatePickerDelegate?
    
    //Properties
    fileprivate var containerView: UIView!
    fileprivate var contentView: UIView!
    fileprivate var backgroundView: UIView!
    fileprivate var datePickerView: UIDatePicker!
    
    //Custom Properties
    open var showBlur = true //Default Yes
    open var datePickerType: SCDatePickerType!
    open var tapToDismiss = true //Default Yes
    open var btnFontColour = UIColor.blue //Default Blue
    open var btnColour = UIColor.clear //Default Clear
    open var datePickerStartDate = Date() //Optional
    open var showShadow = true //Optional
    open var showCornerRadius = true // Optional
    
    
    public init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clear
        
    }
    
    
    
    open func show(attachToView view: UIView) {
        self.show(self, inView: view)
    }
    
    //Show View
    fileprivate func show(_ contentView: UIView, inView: UIView) {
        
        self.contentView = inView
        
        self.containerView = UIView()
        self.containerView.frame = CGRect(x: 0, y: 0, width: inView.bounds.width, height: inView.bounds.height)
        self.containerView.backgroundColor = UIColor.clear
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
            let path = UIBezierPath(roundedRect:self.datePickerView.bounds, byRoundingCorners:[.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10))
            let maskLayer = CAShapeLayer()
            
            maskLayer.path = path.cgPath
            self.datePickerView.layer.mask = maskLayer
        }
        
        self.backgroundView.addSubview(self.addSelectButton())
        
        
        //Show UI Views
        UIView.animate(withDuration: 0.15, animations: {
            self.containerView.alpha = 1
        }, completion: { (success:Bool) in
            UIView.animate(withDuration: 0.30, delay: 0, options: .transitionCrossDissolve, animations: {
                self.backgroundView.frame.origin.y = self.containerView.bounds.height / 2 - 125
                }, completion: { (success:Bool) in
                    
            })
        }) 
        
        if tapToDismiss {
            let tap = UITapGestureRecognizer(target: self, action: #selector(SCPopDatePicker.dismiss(_:)))
            tap.delegate = self
            self.containerView.addGestureRecognizer(tap)
        }
        
        self.layoutSubviews()
    }
    
    
    //Handle Tap Dismiss
    func dismiss(_ sender: UITapGestureRecognizer? = nil) {
        
        UIView.animate(withDuration: 0.15, animations: {
            self.backgroundView.frame.origin.y += self.containerView.bounds.maxY
        }, completion: { (success:Bool) in
            
            UIView.animate(withDuration: 0.05, delay: 0, options: .transitionCrossDissolve, animations: {
                self.containerView.alpha = 0
                }, completion: { (success:Bool) in
                    self.containerView.removeGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(SCPopDatePicker.dismiss(_:))))
                    self.containerView.removeFromSuperview()
                    self.removeFromSuperview()
            })
            
        }) 
        
        
    }
    
    //Show Blur Effect
    fileprivate func _showBlur() {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.contentView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.containerView.addSubview(blurEffectView)
        
    }
    
    //Create DatePicker
    fileprivate func createDatePicker() -> UIDatePicker {
        let datePickerView: UIDatePicker = UIDatePicker(frame: CGRect(x: 0, y: -60, width: self.backgroundView.bounds.width, height: self.backgroundView.bounds.height))
        datePickerView.date = self.datePickerStartDate
        datePickerView.autoresizingMask = [.flexibleWidth]
        datePickerView.clipsToBounds = true
        datePickerView.backgroundColor = UIColor.white
        datePickerView.datePickerMode = self.datePickerType.dateType()
        return datePickerView
    }
    //
    //Create Background Container View
    fileprivate func createBackgroundView() -> UIView {
        let bgView = UIView(frame: CGRect(x: self.containerView.frame.width / 2 - 150, y: self.containerView.bounds.maxY + 100, width: 300, height: 160))
        bgView.autoresizingMask = [.flexibleWidth]
        bgView.backgroundColor = UIColor.clear
        
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
    
    fileprivate func addSelectButton() -> UIButton {
        
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x: self.backgroundView.frame.width / 2 - 150, y: self.datePickerView.frame.maxY, width: self.backgroundView.frame.size.width, height: 48)
        btn.setTitle("Select", for: UIControlState())
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.tintColor = self.btnFontColour
        btn.backgroundColor = self.btnColour
        btn.addTarget(self, action: #selector(SCPopDatePicker.didSelectDate(_:)), for: .touchUpInside)
        
        //Round .Left / .Right Corners of DatePicker View
        if showCornerRadius {
            let path = UIBezierPath(roundedRect: btn.bounds, byRoundingCorners:[.bottomRight, .bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
            let maskLayer = CAShapeLayer()
            
            maskLayer.path = path.cgPath
            btn.layer.mask = maskLayer
        }

        
        return btn
    }
    
    @objc fileprivate func didSelectDate(_ sender: UIButton) {
        if delegate != nil {
            self.delegate?.scPopDatePickerDidSelectDate(self.datePickerView.date)
            self.dismiss()
        }
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

