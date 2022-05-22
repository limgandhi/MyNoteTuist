//
//  Note.swift
//  MyNote
//
//  Created by Hyunyou Lim on 2022/04/10.
//

import Foundation

struct Note {
    var id: UUID
    var title: String
    var content: String
    var time: Date
    
    init(title: String,content: String){
        self.id = UUID()
        self.title = title
        self.content = content
        self.time = Date()
    }
}
