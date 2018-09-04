//
//  ColorizationParser.swift
//  Quizarium
//
//  Created by Калинин Кирилл Игоревич on 02.10.2017.
//  Copyright © 2017 Kirillinho. All rights reserved.
//

import Foundation
import UIKit

public class Colorization {
    
     public func painting(_ question:String) -> NSMutableAttributedString  {
          let result = NSMutableAttributedString.init(string: question)
          
          let words = toColor(question)
          for (word, type) in words {
               for place in 0..<question.count-word.count {
                    let start = question.index(question.startIndex, offsetBy: place)
                    let end = question.index(question.startIndex, offsetBy: place + word.count-1)
                    let substring = question[start...end]
                    if substring.elementsEqual(word){
                         let painted = NSRange(location:place, length:word.count)
                         result.setAttributes([NSAttributedStringKey.foregroundColor: type], range: painted)
                    }
               }
          }
          
          let positions = getQuotesPlaces(question)
          if positions.count > 0 {
               for from in 0..<positions.count-1 {
                    if (from%2 == 0) || (from == 0) {
                         let painted = NSRange(location:positions[from]+1,
                                               length:positions[from+1]-positions[from]-1)
                         result.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.red], range: painted)
                    }
               }
          }
          
          result.append(NSAttributedString(string: "\n \nСhoose the answer: \n"))
          return result
     }
    
    private func toColor(_ question:String) -> [(word:String, type:UIColor)] {
        var toColor = [(word:String, type:UIColor)]()
        for ct in Words.specialWords() {
            for word in ct.words {
                if(question.contains(word)){
                    toColor.append((word, ct.types))
                }
            }
        }
        return toColor
    }
    
     private func getQuotesPlaces(_ question:String) -> [Int] {
          var index = 0
          var list:[Int] = [Int]()
          for quote in question {
               if(quote == "\""){
                    list.append(index)
               }
               index = index + 1
          }
          return list
     }
    
    public init() {
        
    }
}
