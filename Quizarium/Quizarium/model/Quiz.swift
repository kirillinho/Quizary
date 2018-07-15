//
//  Issue.swift
//  Quizarium
//
//  Created by Калинин Кирилл Игоревич on 31.05.2018.
//  Copyright © 2018 Kirillinho. All rights reserved.
//

import Foundation

public class Quiz {
    
    private let completionDate: String
    private let attributes: [NSMutableAttributedString]
    private let answersBank: [Int: Result]
    private let annotation: [String]
    
    public init(_ completionDate: String,
                _ attributes: [NSMutableAttributedString],
                _ answersBank: [Int: Result],
                _ annotation: [String]) {
        self.completionDate = completionDate
        self.attributes = attributes
        self.answersBank = answersBank
        self.annotation = annotation
    }
    
    public func getAnnotations() -> [String] {
        return annotation
    }
    
    public func getCompletionDate() -> String {
        return completionDate
    }
    
    public func getAttributes() -> [NSMutableAttributedString] {
        return attributes
    }
    
    public func getAnswersBank() -> [Int: Result] {
        return answersBank
    }
}
