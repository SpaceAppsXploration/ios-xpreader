//
//  Articles.swift
//  XpReader
//
//  Created by Andrea Cerra on 29/09/15.
//  Copyright © 2015 Andrea Cerra. All rights reserved.
//

import Foundation

class Articles {
    
    var img: String?
    var title: String?
    var date: String?
    var tags: [String]
    var text: String?
    var type: String?
    var keyworldUrl: String?
    var index: NSInteger?

    init(image: String, title: String, date: String, tags: [String], text: String, type: String){
        
        self.img = image
        self.title = title
        self.date = date
        self.tags = tags
        self.text = text
        self.type = type
    }
    
    init(json: NSDictionary) {
        
        self.img = nil
        self.title = json["title"] as? String
        self.date = json["stored"] as? String
        self.tags = []
        self.text = json["abstract"] as? String
        self.type = json["type_of"] as? String
        self.keyworldUrl = json["keywords_url"] as? String
        self.index = 0
    }
    
}