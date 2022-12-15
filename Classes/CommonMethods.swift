//
//  CommonMethods.swift
//  logFileHandlerIOS
//
//  Created by Himy Mughal on 15/12/2022.
//

import Foundation

class CommonMethods
{
    static func showAlertWith(csTitle:String, csMessage:String, viewController:UIViewController)
    {
        let alertVC = UIAlertController(title: csTitle, message: csMessage, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: Constants.ok, style: .default, handler: { action in
            //
            
        }))
        
        DispatchQueue.main.async {
            viewController.present(alertVC, animated: true, completion: nil)
        }
    }
    
    /********************************************************/
    
    static func showAlertWithHandler(viewContoller : UIViewController , title : String , message : String, leftButtonText : String? , rightButtonText :String? , leftButtonActionHandler: (()->())?, rightButtonActionHandler: (()->())? )
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if  rightButtonText != nil && rightButtonText != ""
        {
            alert.addAction(UIAlertAction(title: rightButtonText, style: .default, handler: { (alertAction) in
               rightButtonActionHandler?()
            }))
        }
        
        if  leftButtonText != nil && leftButtonText != ""
        {
            alert.addAction(UIAlertAction(title: leftButtonText, style: .cancel, handler: { (alertAction) in
                leftButtonActionHandler?()
            }))
        }
        
        DispatchQueue.main.async {
            viewContoller.present(alert, animated: true, completion: nil)
        }
    }
    
    // ****************************************
    
    // screen width
    static func screenWidth () -> CGFloat{
        return UIScreen.main.bounds.width
    }

    // ****************************************
    
    // Screen height.
    static func screenHeight () -> CGFloat{
        return UIScreen.main.bounds.height
    }
}
