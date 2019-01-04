//
//  WordDefinitionViewController.swift
//  Final Project
//
//  Created by Natalie F on 12/6/17.
//  Copyright © 2017 Natalie Fung. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WordDefinitionViewController: UIViewController {
    
    var wordView: UIView!
    var synonymButton: UIButton!
    var word: String = ""
    var pronunciation: UILabel!
    var definition: UILabel!
    var etymology: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = word
        view.backgroundColor = .white
        
        wordView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        
        synonymButton = UIButton(frame: CGRect(x: 50, y: 490, width: 100, height: 20))
        synonymButton.setTitle("Synonyms", for: .normal)
        synonymButton.setTitleColor(.blue, for: .normal)
        synonymButton.sizeToFit()
        synonymButton.addTarget(self, action: #selector(pressedSynonymButton), for: .touchUpInside)
        
        pronunciation = UILabel(frame: CGRect(x: 50, y: 130, width: 300, height: 30))
        
        definition = UILabel(frame: CGRect(x: 50, y: 150, width: 250, height: 150))
        definition.numberOfLines = 0
        
        etymology = UILabel(frame: CGRect(x: 50, y: 320, width: 250, height: 150))
        etymology.numberOfLines = 0
        
        view.addSubview(wordView)
        view.addSubview(synonymButton)
        
        let word_id = word.lowercased()
        let language = "en"
        
        let url = URL(string: "https://od-api.oxforddictionaries.com:443/api/v1/entries/\(language)/\(word_id)")!
        let headers: [String: String]? = ["app_id" : "69ed59a9", "app_key" : "    5f63860a801f7de4a018669a744fee31"]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let json):
                let json = JSON(json)
                
                if let definitionText = json["results"].array?.first?["lexicalEntries"].array?.first?["entries"].array?.first?["senses"].array?.first?["definitions"].array?.first?.string {
                    self.definition.text = "Definition: " + definitionText
                }
                
                if let pronunciationText = json["results"].array?.first?["lexicalEntries"].array?.first?["pronunciations"].array?.first?["phoneticSpelling"].string {
                    self.pronunciation.text = "Pronunciation: " + pronunciationText
                    self.pronunciation.sizeToFit()
                }
                
                if let etymologyText = json["results"].array?.first?["lexicalEntries"].array?.first?["entries"].array?.first?["etymologies"].array?.first?.string {
                    self.etymology.text = "Etymology: " + etymologyText
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        view.addSubview(pronunciation)
        view.addSubview(definition)
        view.addSubview(etymology)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pressedSynonymButton() {
        let synonymViewController = SynonymViewController()
        synonymViewController.wordText = word
        navigationController?.pushViewController(synonymViewController, animated: true)
    }
    
    
}
