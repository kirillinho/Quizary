//
//  SpecialWords.swift
//  Quizarium
//
//  Created by Калинин Кирилл Игоревич on 04.12.2017.
//  Copyright © 2017 Kirillinho. All rights reserved.
//

import Foundation
import UIKit

public class Words {

    private static let blueWords:[String] = ["out", "main"]
    private static let purpleWords:[String] = [
        "class", "static", "private", "public", "void", "this", "super",
        "try", "catch", "new", "throws", "if", "else", "while", "byte"
    ]

    public static func specialWords() -> [(words:[String], types:UIColor)] {
        var colorTypes = [(words:[String], types:UIColor)]()
        colorTypes.append((blueWords, UIColor.blue))
        colorTypes.append((purpleWords, UIColor.purple))
        return colorTypes
    }
}
