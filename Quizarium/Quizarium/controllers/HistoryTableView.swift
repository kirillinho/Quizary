//
//  HistoryTableView.swift
//  Quizarium
//
//  Created by Калинин Кирилл Игоревич on 14.08.2018.
//  Copyright © 2018 Kirillinho. All rights reserved.
//

import UIKit

class HistoryTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private var result = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("History table loaded")
        for x in ResponseStore.getQuizs() {
            result.append(x.getCompletionDate())
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTable()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ResponseStore.setQuizId(indexPath.row)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let rv = storyBoard.instantiateViewController(
            withIdentifier: "ResultView") as! ResultView
        self.present(rv, animated:true, completion:nil)
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default,
                                   reuseIdentifier: "cell")
        cell.textLabel?.text = result[indexPath.row]
        return cell
    }
    
    func animateTable() {
        tableView.reloadData()
        let cells = tableView.visibleCells
        
        let tableViewHeight = tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75,
                           delay: Double(delayCounter) * 0.05,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
}
