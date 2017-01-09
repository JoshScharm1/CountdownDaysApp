//
//  CountdownClass.swift
//  CountdownDaysApp
//
//  Created by JScharm on 12/15/16.
//  Copyright © 2016 JScharm. All rights reserved.
//

import UIKit

class CountdownClass: NSObject, NSCoding
{
    
    var name : String
    var days : String
    
    init(name: String, days: String)
        {
            self.name = name
            self.days = days
            
        }
        
        // initalizer used when loading objects of the class
        required init?(coder aDecoder: NSCoder)
        {
            name = aDecoder.decodeObject(forKey: "name") as! String
            days = aDecoder.decodeObject(forKey: "days") as! String
        }
        
        // use for saving
        func encode(with aCoder: NSCoder)
        {
            aCoder.encode(name,forKey: "name")
            aCoder.encode(name,forKey: "days")
        }
    

    

}
