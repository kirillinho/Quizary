//
//  RestConnection.swift
//  Quizarium
//
//  Created by Калинин Кирилл Игоревич on 02.10.2017.
//  Copyright © 2017 Kirillinho. All rights reserved.
//

import Foundation

public class RestConnect {
    
    private var result = [Question]()
    
    public init ()  {
        parseJSON()
    }
    
    private struct QuestionModelList: Decodable {
        var questionModelList = [Question]()
    }
 
    public func parseJSON() {
        let url = URL(string: "https://raw.githubusercontent.com/kirillinho/MyRepo/master/quizwithannotation.json")
        print("Start")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data  =  data  else  { return }

            if error != nil {
                print("error")
            }
            
            do {
                let questions = try JSONDecoder().decode(QuestionModelList.self, from: data)
                var list = [Question]()
                let rnd = Util.shuffle(questions.questionModelList.count)
                for i in 0..<4 {
                    list.append(questions.questionModelList[rnd[i]])
                }
                self.result = list
            } catch let error {
                print(error)
            }
        }.resume()
    }

    public func getQuestions() -> [Question] {
        return result
    }

}
