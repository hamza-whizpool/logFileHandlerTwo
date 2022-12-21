# logFileHandlerIOS

[![CI Status](https://img.shields.io/travis/Hamza Mughal/logFileHandlerIOS.svg?style=flat)](https://travis-ci.org/Hamza Mughal/logFileHandlerIOS)
[![Version](https://img.shields.io/cocoapods/v/logFileHandlerIOS.svg?style=flat)](https://cocoapods.org/pods/logFileHandlerIOS)
[![License](https://img.shields.io/cocoapods/l/logFileHandlerIOS.svg?style=flat)](https://cocoapods.org/pods/logFileHandlerIOS)
[![Platform](https://img.shields.io/cocoapods/p/logFileHandlerIOS.svg?style=flat)](https://cocoapods.org/pods/logFileHandlerIOS)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Features

 1) create new log file Everyday with current date name.
 2) compress zip and Make password on it (optional).
 3) Delete old files depending on the no. of days provided to by developer
 4) Display a alert which take textual input from user about the issue / bug they are facing
 5) The theme of alert view can be customizable
 6) The send-to email should be provided by developer
 7) A JSON file should also get attached with following information:
        -> Device manufacturer
        -> Device model
        -> OS installed on device
        -> Currently running app version
        -> Free storage space available

## Usage Swift

        // initilization sdk
        SLog.shared.initilization()
        
        // Write Logs in Logs File with message
        SLog.shared.summaryLog(text: "Hello World!!")
        
        // Set zip archive Password
        SLog.shared.setPassword(password: "Password12345")
        
        // set days for Logs Deletion
        SLog.shared.setDaysForLog(numberOfDays: 7)
        
        // delete logs files forcefully
        SLog.shared.deleteOldLogs(forcefullyDelete: true)
        
        // set Title
        SLog.shared.setTitle(title: "Map App")
        
        // Attachment Files
        SLog.shared.addAttachment(fileName: "icon", url: filePath, mimeType: "image/png")
        
        // set email
        SLog.shared.setEmail(text: "abc@xyz.com")
        
        // set email Subject
        SLog.shared.setSubjectToEmail(sub: "BUG REPORT ")
        
        // set place holder for the text views
        SLog.shared.setPlaceHolder(text: "Enter Your Bug Detail")
        
        // set final log file name which is going to be emailed
        SLog.shared.setLogFileName(text: "finalLog")
        
        // set image to the close button
        SLog.shared.setSendBtnImage(img: UIImage(named: "testImg")!)
        
        //set nobe and line color
        SLog.shared.setKnobColor(color: .red)
        SLog.shared.setLineColor(color: .green)
                
        // set text view text, font name, font size, and text color
        SLog.shared.setTextViewBackgroundColor(backgroundColor: .brown)
        SLog.shared.setTextViewTextColor(color: .green)
        SLog.shared.setTextViewFont(fontName: "Marker Felt Thin")
        SLog.shared.setTextViewFontSize(fontSize: 17)
        
        // set title text, font name, font size and text color
        SLog.shared.setTitle(title: "Title Here")
        SLog.shared.setTitleFont(fontName: "Marker Felt Thin")
        SLog.shared.setTitleFontSize(fontSize: 22)
        SLog.shared.setTitleColor(color: .purple)

        // set send button view text, font name, font size, and text color
        SLog.shared.setSendButtonText(text: "Send Button Text")
        SLog.shared.setSendBtnFont(fontName: "Marker Felt Thin")
        SLog.shared.setSendBtnFontSize(fontSize: 30)
        SLog.shared.setSendBtnTextColor(color: .green)
        SLog.shared.setSendButtonBackgroundColor(backgroundColor: .black)
        
        // Open Main View for Mailing Log Files on Button Action
        let amazingBundle = Bundle(for: AlertViewController.self)
        let secondView = AlertViewController(nibName: "AlertViewController", bundle: amazingBundle)
        secondView.modalPresentationStyle = .fullScreen
        self.present(secondView, animated: true, completion: nil)
        
## Usage Objective C

        // import the pod file in .m file
        @import logFileHandlerIOS;
        
        // initilization sdk
        [ [SLog shared] initilization ];

        // use the function of the pods
        [ [SLog shared] summaryLogWithText:@"LOL" ];

        // call the alert view Controller
        NSBundle *myBundle = [NSBundle bundleForClass:[AlertViewController class]];
        AlertViewController *VC = [[AlertViewController alloc] initWithNibName:@"AlertViewController" bundle:myBundle];
        [self presentViewController:VC animated:YES completion:nil];
        
        
## Requirements

## Installation

logFileHandlerIOS is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'logFileHandlerIOS'
```

## Log Levels

The following log levels are supported:

 - `Debug`
 - `Info`
 - `Warning`
 - `Error`
 - `Message`
 
 ## Let's Log

```swift
 // let's import the logging API package
import SystemSupport

 // initilization Sdk
SLog.shared.initilization()

 // we're now ready to use it
 // summary log is used to print in console and it will also write the log into file 
SLog.shared.summaryLog(text: "Hello World!!")

 // detail log is used to print in console and it will also write the log into file (optional)
SLog.shared.detailLog(text: "Hello World!!", writeIntoFile: false)
```


# Output

```
2022-03-02 15:12:19.507 Hello World!!

```

## License

logFileHandlerIOS is available under the MIT license. See the LICENSE file for more info.
