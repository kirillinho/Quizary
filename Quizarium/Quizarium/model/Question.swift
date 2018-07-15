//
//  Question.swift
//  Quizarium
//
//  Created by Калинин Кирилл Игоревич on 19.10.2017.
//  Copyright © 2017 Kirillinho. All rights reserved.
//

import Foundation

public class Question:Decodable   {
    
    let id: Int?
    let text: String?
    let right: String?
    let wrong: [String]?
    let annotation: String?
    
    public init(id:Int, text:String, right:String, wrong:[String], annotation: String) {
        self.id = id
        self.text = text
        self.right = right
        self.wrong = wrong
        self.annotation = annotation
    }
    
    public func toString() -> String {
        return "Id \(id!), text \(text!), right \(right!) wrong \(wrong!)"
    }
}
