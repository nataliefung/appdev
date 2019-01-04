//
//  SynonymViewController.swift
//  Final Project
//
//  Created by Natalie F on 12/6/17.
//  Copyright © 2017 Natalie Fung. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SynonymViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var word: Word!
    var wordText: String = ""
    var synonymList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Synonyms"
        view.backgroundColor = .white
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SynonymTableViewCell.self, forCellReuseIdentifier: "SynonymTableViewCell")
        tableView.rowHeight = SynonymTableViewCell.height
        
        word = Word(word: wordText)
        
        view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return word.getNumberOfSynonyms(input: word.wordText)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SynonymTableViewCell", for: indexPath) as? SynonymTableViewCell else {return UITableViewCell()
        }
        cell.number = indexPath.row
        cell.word = word.wordText
        cell.setUpTitle(input: word.wordText)
        return cell
    }
    
    
}
