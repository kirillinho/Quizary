//
//  LabelBuilder.swift
//  Quizarium
//
//  Created by Калинин Кирилл Игоревич on 04.06.2018.
//  Copyright © 2018 Kirillinho. All rights reserved.
//

import UIKit

class LabelBuilder {
    
    public func printQuestion(_ issue: UILabel,
                              _ issueId: UILabel,
                              _ attr: NSMutableAttributedString,
                              _ count: Int,
                              _ index: Int) {
        issue.attributedText = attr
        issue.textAlignment = .natural
        issue.sizeToFit()
        issueId.text = "\(index+1)/\(count)"
    }
    
}
