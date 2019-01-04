//
//  ViewController.swift
//  Final Project
//
//  Created by Natalie F on 12/6/17.
//  Copyright © 2017 Natalie Fung. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UISearchBarDelegate {
    
    var homeView: UIView!
    var searchText: String = ""
    
    var searchField: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Dictionary"
        view.backgroundColor = .white
        
        homeView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        searchField = UISearchBar(frame: CGRect(x: 40, y: 150, width: 300, height: 100))
        searchField.placeholder = "Enter word here"
        searchField.prompt = "Tell me about the word..."
        searchField.showsSearchResultsButton = true
        searchField.delegate = self
        
        view.addSubview(homeView)
        view.addSubview(searchField)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // called when keyboard search button pressed
        let wordDefinitionViewController = WordDefinitionViewController()
        wordDefinitionViewController.word = searchField.text!
        navigationController?.pushViewController(wordDefinitionViewController, animated: true)
    }

}

