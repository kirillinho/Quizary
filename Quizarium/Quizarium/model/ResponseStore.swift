//
//  ResponseStore.swift
//  Quizarium
//
//  Created by Калинин Кирилл Игоревич on 31.05.2018.
//  Copyright © 2018 Kirillinho. All rights reserved.
//

import Foundation

public class ResponseStore {
    private static var quizs = [Quiz]()
    private static var quizId: Int = 0
    
    public static func addQuiz(_ newQuiz: Quiz) -> Void{
        quizs.append(newQuiz)
    }
    
    public static func getQuizs() -> [Quiz] {
        return ResponseStore.quizs
    }
    
    public static func setQuizId(_ quizId: Int) -> Void {
        self.quizId = quizId
    }
    
    public static func getQuizId() -> Int {
        return quizId
    }
}
