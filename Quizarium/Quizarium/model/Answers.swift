//
//  File.swift
//  Quizarium
//
//  Created by Калинин Кирилл Игоревич on 18.10.2017.
//  Copyright © 2017 Kirillinho. All rights reserved.
//

import Foundation

public class Answer {
    
    private let type:Bool 
    private let answer:String
    
    public init(_ type:Bool, _ answer:String){
        self.type = type
        self.answer = answer
    }
    
    public func getType() -> Bool {
        return type
    }
    
    public func getAnswer() -> String {
        return answer
    }
}
