//
//  AlertViewController.swift
//  logFileHandlerIOS
//
//  Created by Himy Mughal on 13/12/2022.
//

import UIKit
import SSZipArchive
import Foundation
import MessageUI

public class AlertViewController: UIViewController {
    
    
    // ********************* Outlets *********************//
    // MARK: - View controller Outlets -
    
    // Tittle Label Outlet
    @IBOutlet weak var titleLbl: UILabel!

    // Send Button outlet
    @IBOutlet weak var sendBtnLbl: UILabel!
    @IBOutlet weak var sendBtnView: UIView!

    // skip button outlet
//    @IBOutlet weak var skip_btn_outlet: UIButton!

    // main view outlet
    @IBOutlet weak var mainAlertView: UIView!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var mainTextFieldViewHeight : NSLayoutConstraint!

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var knobView: UIView!
    
    // Bugs TextView Outlet
    @IBOutlet weak var bugsTextview: GrowingTextView!

    // Close Btn outlet
//    @IBOutlet weak var closeBtnOutlet: UIButton!

    @IBOutlet weak var sendBtnImage : UIImageView!
    
    
    var bDarkMode = false
    
    //MARK: - // ********************* ViewDidLoad *********************// -
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Textview Editing function
        textviewEditing()
        
        // calling function of NewControllerInitilizer() for showing main view
        newControllerInitilizer()
        
        self.bDarkMode = self.checkDarkMode()
    }
    
    // MARK: - // ********************* ACTION MEHTODS *********************// -
    
    @IBAction func sendBtnAction(_ sender: UIButton)
    {
        // Send Button Action where we can check textview is empty or check text is equal to placeholder when both condition are ture we can show alert message Bug Detail is Missing if condition is false then we can proceed further
        
        if bugsTextview.text.isEmpty || bugsTextview.text == SLog.shared.textViewPlaceHolder || bugsTextview.text.count <= 10
        {
            // show alert when textview is empty
            let alert = UIAlertController(title: "Alert", message: "Bug Detail is Missing", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let recieverEmail = SLog.shared.sendToEmail
            guard MFMailComposeViewController.canSendMail()  else {
                
                let alert = UIAlertController(title: "Alert", message: "Email not configure", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let composer = MFMailComposeViewController()
            composer.mailComposeDelegate = self
            composer.setToRecipients([recieverEmail])
            composer.setSubject(SLog.shared.emailSubject)
            composer.setMessageBody(bugsTextview.text, isHTML: true)
            let filePath = SLog.shared.getRootDirPath()
            let url = URL(string: filePath)
            let zipPath = url!.appendingPathComponent("/\(SLog.shared.logFileNewFolderName)")
            do {
                self.createPasswordProtectedZipLogFile(at: zipPath.path, composer: composer)

                if MFMailComposeViewController.canSendMail() {
                    self.present(composer, animated: true)
                }
            }
        }
    }
    
    // MARK: - // ********************* Methods *********************// -
    
    func newControllerInitilizer()
    {
        textFieldView.isHidden = false
        //view.backgroundColor = UIColor(white: 1, alpha: 0.4)
        view.backgroundColor = .init(white: 0, alpha: 1.0)
    }
    
    //****************************************************
    
    // Function create zip and create password on it
    func createPasswordProtectedZipLogFile(at logfilePath: String, composer viewController: MFMailComposeViewController)
    {
        var isZipped:Bool = false
        // calling combine all files into one file
        SLog.shared.combineLogFiles { filePath in
            //
            SLog.shared.makeJsonFile { jsonfilePath in
                //
                let contentsPath = logfilePath
                
                // create a json file and call a function of makeJsonFile
                if FileManager.default.fileExists(atPath: contentsPath)
                {
                    let createZipPath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(SLog.shared.finalLogFileNameAfterCombine).zip").path
                    if SLog.shared.password.isEmpty{
                        isZipped = SSZipArchive.createZipFile(atPath: createZipPath, withContentsOfDirectory: contentsPath)
                    }
                    else{
                        isZipped = SSZipArchive.createZipFile(atPath: createZipPath, withContentsOfDirectory: contentsPath, keepParentDirectory: true, withPassword: SLog.shared.password)
                    }
                    
                    if isZipped {
                        var data = NSData(contentsOfFile: createZipPath) as Data?
                        if let data = data
                        {
                            viewController.addAttachmentData(data, mimeType: "application/zip", fileName: ("\(SLog.shared.finalLogFileNameAfterCombine).zip"))
                        }
                        data = nil
                    }
                }
            }
        }
    }
    
    //****************************************************
    
    /// this fuction executed right after when phone enables or disables the dark mode \
    /// upone that we have to update the uicolors of views
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?)
    {
        self.bDarkMode = self.checkDarkMode()
        
        // textFieldView backgroundColor color handling along with dark mode
        if SLog.shared.textViewBackgroundColor != nil
        {
            self.textFieldView.backgroundColor = SLog.shared.textViewBackgroundColor
        }
        
        
        // setup main alert view background color
        if SLog.shared.alertBackgroundColor != nil
        {
            self.mainAlertView.backgroundColor = SLog.shared.alertBackgroundColor
        }
        
        
        // bugsTextview text color handling along with dark mode
        self.bugsTextview.textColor = SLog.shared.defaultColorBlack
        if SLog.shared.textViewTextColor != nil
        {
            self.bugsTextview.textColor = SLog.shared.textViewTextColor
        }
        else if self.bDarkMode
        {
            self.bugsTextview.textColor = SLog.shared.defaultColorWhite
        }
        
        
        // title color handling along with dark mode
        if SLog.shared.titleTextColor != nil
        {
            self.titleLbl.textColor = SLog.shared.titleTextColor
        }
    }
}

// ********************* Extensions *********************//

// Extension for mail composing delegate
extension AlertViewController:MFMailComposeViewControllerDelegate
{
    public func mailComposeController (_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error
        {
            controller.dismiss(animated: true, completion: nil)
        }
        switch result {
        case .cancelled:
            print("cancel")
        case .saved:
            print("saved")
        case .sent:
            print("sent")
        case .failed:
            print("failed")
        default:
            print("default")
        }
        controller.dismiss(animated: true, completion: nil)
    }
}


// Extension for Textview Editing or Delegate
extension AlertViewController:UITextViewDelegate {
    
    // setting textview, buttons colors and set app name to tittle label
    func textviewEditing() {
        
        DispatchQueue.main.async {
            //
            self.bugsTextview.delegate = self
            self.bugsTextview.layer.cornerRadius = 12.0
//            self.bugsTextview.maxHeight = (UIScreen.main.bounds.size.height / 2) - 140
//            self.bugsTextview.minHeight = (UIScreen.main.bounds.size.height / 2) - 140
            self.bugsTextview.trimWhiteSpaceWhenEndEditing = true
            self.bugsTextview.placeholder = SLog.shared.textViewPlaceHolder
            self.bugsTextview.placeholderColor = UIColor(white: 0.8, alpha: 1.0)
//            self.bugsTextview.backgroundColor = SLog.shared.textViewBackgroundColor
            self.bugsTextview.textColor = SLog.shared.textViewTextColor
            self.bugsTextview.font = UIFont(name: SLog.shared.textViewFont, size: CGFloat(SLog.shared.textViewFontSize))
            self.bugsTextview.translatesAutoresizingMaskIntoConstraints = false
            self.bugsTextview.becomeFirstResponder()

            self.mainTextFieldViewHeight.constant = (self.view.bounds.size.height / 2) - 100
            
            
            // main view corner radius
            self.textFieldView.layer.cornerRadius = 12.0
            
            if SLog.shared.textViewBackgroundColor != nil
            {
                self.textFieldView.backgroundColor = SLog.shared.textViewBackgroundColor
            }
            
            self.mainAlertView.layer.cornerRadius = 12.0
//            self.mainAlertView.backgroundColor = SLog.shared.alertBackgroundColor
//            self.titile_lbl.textColor = SLog.shared.textColor
            
            
            // set the image of the send Btn
            if SLog.shared.sendBtnImage != nil
            {
                self.sendBtnImage.image = SLog.shared.sendBtnImage
            }

            
            // set line and knob color
            if SLog.shared.knobColor != nil
            {
                self.lineView.backgroundColor = SLog.shared.lineColor
            }
            
            self.knobView.layer.cornerRadius = 3
            if SLog.shared.lineColor != nil
            {
                self.knobView.backgroundColor = SLog.shared.knobColor
            }
            
            
            // Title text color , size and font
            self.titleLbl.textColor = SLog.shared.titleTextColor
            self.titleLbl.font = UIFont(name: SLog.shared.titleFont, size: CGFloat(SLog.shared.titleFontSize))
            
            
            // Send Button corner radius, text and text color
            self.sendBtnView.layer.cornerRadius = 12.0
            
            if SLog.shared.sendButtonBackgroundColor != nil
            {
                self.sendBtnView.backgroundColor = SLog.shared.sendButtonBackgroundColor
            }
            
            // send button text color , size and font
            self.sendBtnLbl.textColor = SLog.shared.SendBtntextColor
            self.sendBtnLbl.font = UIFont(name: SLog.shared.sendBtnFont, size: CGFloat(SLog.shared.sendBtnFontSize))
            
            
            // set appName to tittle label
            if SLog.shared.titleText.isEmpty
            {
                let appName = Bundle.main.infoDictionary!["CFBundleName"] as! String
                self.titleLbl.text = appName
            }
            else
            {
                self.titleLbl.text = SLog.shared.titleText
            }
            
            // set Send button Lable
            if SLog.shared.sendBtnText.isEmpty
            {
                self.sendBtnLbl.text = "Send"
            }
            else
            {
                self.sendBtnLbl.text = SLog.shared.sendBtnText
            }
        }
    }
    
    //****************************************************
    
    // when textview is Editing
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == SLog.shared.textViewPlaceHolder{
            textView.text = ""
        }
    }
    
    //****************************************************
    
    // when textview text is change
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if text == "\n"{
//            textView.resignFirstResponder()
//        }
        return true
    }
    
    //****************************************************
    
    // when textview text is end
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = SLog.shared.textViewPlaceHolder
        }
    }
    
    //****************************************************
    
    func checkDarkMode() -> Bool
    {
        if #available(iOS 12.0, *) {
            if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyle.dark)
            {
                return true
            }
            else
            {
                return false
            }
        }
        
        return false
    }
}
