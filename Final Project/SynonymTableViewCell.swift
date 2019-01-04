//
//  SynonymTableViewCell.swift
//  Final Project
//
//  Created by Natalie F on 12/13/17.
//  Copyright © 2017 Natalie Fung. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SynonymTableViewCell: UITableViewCell {
    
    let padding: CGFloat = 10
    static let height: CGFloat = 60
    var titleLabel: UILabel!
    var number: Int = 0
    var word: String = ""
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel = UILabel(frame: CGRect(x: padding, y: 10, width: UIScreen.main.bounds.width, height: 20))
        
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpTitle(input: String) {
        let word_id = input.lowercased()
        let language = "en"
        
        let synonymUrl = URL(string: "https://od-api.oxforddictionaries.com:443/api/v1/entries/\(language)/\(word_id)/synonyms")!
        let headers: [String: String]? = ["app_id" : "69ed59a9", "app_key" : "    5f63860a801f7de4a018669a744fee31"]
        
        Alamofire.request(synonymUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let json):
                let json = JSON(json)
                if let syn = json["results"].array?.first?["lexicalEntries"].array?.first?["entries"].array?.first?["senses"].array?.first?["subsenses"].array?.first?["synonyms"].array?[self.number]["text"].string {
                    self.titleLabel.text = syn
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
