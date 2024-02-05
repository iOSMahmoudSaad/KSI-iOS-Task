//
//  ViewController + Extension.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import UIKit

@available(iOS 12.0, *)
extension UIViewController {
    
    func createAlert(title: String? = nil,erroMessage: String,createButton:Bool? = true,completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title ?? "", message: erroMessage, preferredStyle: UIAlertController.Style.alert)

        if createButton == true {
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { action in
                
                if let completion = completion {
                    completion()
                } else {
                    
                    alert.dismiss(animated: true)
                }
            }
        alert.addAction(okButton)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    

    class func loadController() -> Self {
        
            let controller = Self(nibName: String(describing: self), bundle: nil)
             return controller
           
        }
    func presentInFullScreen(_ viewController: UIViewController,transition:UIModalTransitionStyle = .coverVertical,
                             animated: Bool,
                             completion: (() -> Void)? = nil) {
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = transition
        present(viewController, animated: animated, completion: completion)
    }
    func presentPopScreen(_ viewController: UIViewController,
                             animated: Bool,
                             completion: (() -> Void)? = nil) {
        
        viewController.modalPresentationStyle = .overCurrentContext
        present(viewController, animated: animated, completion: completion)
    }
    func navigateToNewVC(_ VC:UIViewController){
        navigationController?.pushViewController(VC, animated: true)
    }
    func PopToOldPage(){
        navigationController?.popViewController(animated: true)
    }
    func cleanNavStackWithNewVC(_ VC:UIViewController){
        
        navigationController?.setViewControllers([VC], animated: true)
    }
    func getError (error : [String : [String]]) -> String {
        
        var   text = ""
        for (_,v) in error {
            for i in v {
                text += " \(i) "
            }
        }
        return text
    }

    func createUpdateAlert(title:String = "UPDATE",message:String = "Please Update Your App") {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let updateButton = UIAlertAction(title: "Update", style: UIAlertAction.Style.default) {[weak self] _ in
            guard let _ = self else{return}
            if let url = URL(string: "itms-apps://apple.com/app/id1639618299") {
                UIApplication.shared.open(url)
            }
        }
        alert.addAction(updateButton)
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true, completion: nil)
    }
}

import MBProgressHUD
 

extension UIViewController {
    
    func showIndicator(withTitle title: String? = nil, and description: String? = nil) {
        
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.label.text = title
        indicator.isUserInteractionEnabled = false
        indicator.detailsLabel.text = description
        indicator.show(animated: true)
        self.view.isUserInteractionEnabled = false
    }
    func hideIndicator() {
        
        MBProgressHUD.hide(for: self.view, animated: true)
        self.view.isUserInteractionEnabled = true
    }

}
