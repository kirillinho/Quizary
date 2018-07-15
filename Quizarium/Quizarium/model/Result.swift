//
//  Result.swift
//  Quizarium
//
//  Created by Калинин Кирилл Игоревич on 13.05.2018.
//  Copyright © 2018 Kirillinho. All rights reserved.
//

import Foundation

public class Result {
    
    private let result:Bool
    private let index:Int
    private let shuffled:[Int]
    private let answers:[Answer]
    
    public init(_ result:Bool,_ index:Int,
                _ shuffled:[Int],_ answers:[Answer]) {
        self.result = result
        self.index = index
        self.shuffled = shuffled
        self.answers = answers
    }
    
    public func getAnswers() -> [Answer] {
        return answers
    }
    
    public func getResult() -> Bool {
        return result
    }
    
    public func getIndex() -> Int {
        return index
    }
    
    public func getShuffled() -> [Int]{
        return shuffled
    }
}
