# SCPopDatePicker

1. Drag and drop SCPopDatePicker.swift into project.
2. Add SCPopDatePickerDelegate to ViewController

# Usage
```Swift
        let datePicker = SCPopDatePicker()
        datePicker.tapToDismiss = true //Optional
        datePicker.datePickerType = SCDatePickerType.date //Optional
        datePicker.showBlur = true // Optional
        datePicker.btnFontColour = UIColor.redColor() //Optional
        datePicker.delegate = self
        datePicker.show(attachToView: self.view)
 ```
 # Delegate Protocol
 ```Swift
