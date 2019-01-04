//
//  Word.swift
//  Final Project
//
//  Created by Natalie F on 12/13/17.
//  Copyright © 2017 Natalie Fung. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Word: NSObject {
    var wordText: String = ""
    var synonyms: [String] = []
    var listLength: Int = 0
    
    init(word: String) {
        self.wordText = word
    }
    
    func getNumberOfSynonyms(input: String) -> Int {
        let theWord = input
        let word_id = theWord.lowercased()
        let language = "en"
        
        let url = URL(string: "https://od-api.oxforddictionaries.com:443/api/v1/entries/\(language)/\(word_id)/synonyms")!
        let headers: [String: String]? = ["app_id" : "69ed59a9", "app_key" : "    5f63860a801f7de4a018669a744fee31"]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let json):
                let json = JSON(json)
                if let numberOfSynonyms = json["results"].array?.first?["lexicalEntries"].array?.first?["entries"].array?.first?["senses"].array?.first?["subsenses"].array?.first?["synonyms"].array?.count {
                    self.listLength = numberOfSynonyms
                }
            case .failure(let error):
                print(error)
            }
        }
        return self.listLength
    }
    
    func getSynonyms(input: Word) -> [String] {
        let theWord = input.wordText
        let word_id = theWord.lowercased()
        let language = "en"
        
        let url = URL(string: "https://od-api.oxforddictionaries.com:443/api/v1/entries/\(language)/\(word_id)/synonyms")!
        let headers: [String: String]? = ["app_id" : "69ed59a9", "app_key" : "    5f63860a801f7de4a018669a744fee31"]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let json):
                let json = JSON(json)
                if let synonym = json["results"].array?.first?["lexicalEntries"].array?.first?["entries"].array?.first?["senses"].array?.first?["subsenses"].array?.first?["synonyms"].array?[self.listLength]["text"].string {
                    self.synonyms.append(synonym)
                }
            case .failure(let error):
                print(error)
            }
        }
        
        return synonyms
    }
}


