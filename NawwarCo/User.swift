//
//  User.swift
//  NawwarCo
//
//  Created by ardMac on 09/06/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import UIKit

class User{
    static let currentUser = User()
    
    var id : String?
    var username : String?
    
    init(){
        id = ""
        username = ""
    }
    
    
    init(withAnId: String, withUsername: String){
        id = withAnId
        username = withUsername
    }
}

extension UIViewController{
    func warningPopUp(withTitle title : String?, withMessage message : String?){
        let popUP = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        popUP.addAction(okButton)
        present(popUP, animated: true, completion: nil)
    }
}
