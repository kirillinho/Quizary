//
//  MainViewController.swift
//  Quizarium
//
//  Created by Калинин Кирилл Игоревич on 10.04.2018.
//  Copyright © 2018 Kirillinho. All rights reserved.
//

import UIKit

class MainView: UIViewController {
    
    @IBOutlet weak var startConstr:   NSLayoutConstraint!
    @IBOutlet weak var settingConstr: NSLayoutConstraint!
    @IBOutlet weak var historyConstr: NSLayoutConstraint!
    
    override func viewDidLoad() {
        print("Main is loaded")
        startConstr.constant   -= view.bounds.width
        settingConstr.constant -= view.bounds.width
        historyConstr.constant -= view.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.startConstr.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.settingConstr.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            self.historyConstr.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func startQuiz(_ sender: Any) {
        print("QUIZ STARTED")
    }
    
}
