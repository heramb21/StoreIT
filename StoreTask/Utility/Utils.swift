//
//  Utils.swift
//  StoreTask
//
//  Created by Mac on 01/07/18.
//  Copyright © 2018 Me. All rights reserved.
//

import UIKit

// MARK: - Utility Class For Basic Functionalities.
class Utils: NSObject {
    
    // MARK: - Alert View
    func SubmitAlertView(viewController : UIViewController,title : String, message : String){
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}
