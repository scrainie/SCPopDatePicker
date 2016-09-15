# SCPopDatePicker
Simple UIDatePicker -> Requires Swift 3.0

1. Drag and drop SCPopDatePicker.swift into project.
2. Add SCPopDatePickerDelegate to ViewController

#Usage
```Swift
        let datePicker = SCPopDatePicker()
        datePicker.tapToDismiss = true //Optional
        datePicker.datePickerType = SCDatePickerType.date //Optional
        datePicker.showBlur = true // Optional
        datePicker.btnFontColour = UIColor.redColor() //Optional
        datePicker.delegate = self
        datePicker.show(attachToView: self.view)
```
#Delegate Protocol

```Swift
 func scPopDatePickerDidSelectDate(date: NSDate) {
        
        //returns NSDate
 }
```
#Optionals
```Swift
    public var showBlur = true //Default Yes
    public var datePickerType: SCDatePickerType!
    public var tapToDismiss = true //Default Yes
    public var btnFontColour = UIColor.blueColor() //Default Blue
    public var btnColour = UIColor.clearColor() //Default Clear
    public var datePickerStartDate = NSDate() //Optional
    public var showShadow = true //Optional
    public var showCornerRadius = true // Optional
```
