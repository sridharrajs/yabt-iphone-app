//
//  ArticleModel.swift
//  myreader
//
//  Created by Sridhar on 18/07/16.
//  Copyright © 2016 Sridhar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol ArticleModelDelegate{
    func dataReady()
}

class ArticleModel: NSObject {
    
    var delegate:ArticleModelDelegate?
    
    var articleArray = [Article]()
    
    let TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0Njg5MjM4NDEwMDksInVzZXJJZCI6IjU2YjgyOGJjZmRiMGFmNTExNWJjZDI1MyJ9.9AbNM7hZ2aTRX7QBqLNWMWg7pN0SCGoj2-kZ6ra5iKc"
    
    let HEADERS = [
        "authorization":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0Njg5MjM4NDEwMDksInVzZXJJZCI6IjU2YjgyOGJjZmRiMGFmNTExNWJjZDI1MyJ9.9AbNM7hZ2aTRX7QBqLNWMWg7pN0SCGoj2-kZ6ra5iKc"
    ];
    
    func getArticles() {
        
        Alamofire.request(.GET, "http://myreader.sridhar.co/api/articles", encoding: ParameterEncoding.URL, headers: HEADERS)
            .responseJSON { (response) -> Void in
                
                let json = JSON(data: response.data!)
                var artciles = [Article]()
                
                for (_,article):(String, JSON) in json["data"]["articles"] {
                    let a1 = Article()
                    a1.id=article["_id"].stringValue
                    a1.title=article["title"].stringValue
                    a1.articleDescription=article["description"].stringValue
                    artciles.append(a1)
                }
                
                self.articleArray = artciles;
                
                if self.delegate != nil{
                    self.delegate?.dataReady()
                }
                
        }
        
    }

}
