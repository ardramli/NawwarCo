//
//  Item.swift
//  NawwarCo
//
//  Created by ardMac on 13/06/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import Foundation

class Item {
    
    var name : String?
    var photoURL : String?
    var color : String?
    var quantity : Int = 0
    
    init(){
        name = ""
        photoURL = ""
        color = ""
        quantity = 0
    }
    
    init(withName : String, withPhoto : String, withColor : String, withQuantity: Int){
        name = withName
        photoURL = withPhoto
        color = withColor
        quantity = withQuantity
    }
    
}
