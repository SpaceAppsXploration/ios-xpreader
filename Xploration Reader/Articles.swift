//
//  Articles.swift
//  XpReader
//
//  Created by Andrea Cerra on 29/09/15.
//  Copyright © 2015 Andrea Cerra. All rights reserved.
//

import Foundation

class Articles {
    
    var img: String
    var title: String
    var date: String
    var tags: [String]
    var text: String

    init(image: String, title: String, date: String, tags: [String], text: String){
        
        self.img = image
        self.title = title
        self.date = date
        self.tags = tags
        self.text = text
    }
    
}