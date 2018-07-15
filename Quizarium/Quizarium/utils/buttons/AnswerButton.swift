//
//  File.swift
//  Quizarium
//
//  Created by Калинин Кирилл Игоревич on 08.04.2018.
//  Copyright © 2018 Kirillinho. All rights reserved.
//

import Foundation
import UIKit

class AnswerButton: UIButton {
    
    var action: (()->())?
    
    func clickAction(action: @escaping ()->()) {
        self.action = action
        self.addTarget(self, action: #selector(AnswerButton.clicked), for: .touchUpInside)
    }
    
    @objc func clicked() {
        action?()
    }
}
