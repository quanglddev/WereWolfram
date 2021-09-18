//
//  getResult_Helper.swift
//  WereWolfram
//
//  Created by QUANG on 7/16/18.
//  Copyright © 2018 QUANG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension HomeTVC {
    
    func getDataWith(search: String, completion: @escaping ([Pod]) -> ()) {
        
        var resultPods = [Pod]()
        
        var title = ""
        var imageLink: URL!
        var imageWidth = CGFloat(0.0)
        var imageHeight = CGFloat(0.0)
        var plainText = ""
        
        let configuredSearch = search.replacingOccurrences(of: " ", with: "%20")
        
        Alamofire.request(URL(string: "http://api.wolframalpha.com/v2/query?appid=\(WolframAPI)&input=\(configuredSearch)&output=json")!)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    return
                }
                
                do {
                    let receivedJSON = try JSON(data: response.data!)
                    
                    if let numberOfPods = receivedJSON["queryresult"]["pods"].array {
                        for i in 0..<numberOfPods.count {
                            if let newTitle = numberOfPods[i]["title"].string {
                                title = newTitle
                            }
                            if let newImageLink = numberOfPods[i]["subpods"][0]["img"]["src"].string {
                                imageLink = URL(string: newImageLink)!
                            }
                            if let newImageWidth = numberOfPods[i]["subpods"][0]["img"]["width"].int {
                                imageWidth = CGFloat(Float(newImageWidth))
                            }
                            if let newImageHeight = numberOfPods[i]["subpods"][0]["img"]["height"].int {
                                imageHeight = CGFloat(Float(newImageHeight))
                            }
                            if let newPlainText = numberOfPods[i]["subpods"][0]["plaintext"].string {
                                plainText = newPlainText
                            }
                            
                            let newPod = Pod(title: title, imageLink: imageLink!, imageWidth: imageWidth, imageHeight: imageHeight, plainText: plainText)
                            resultPods.append(newPod)
                            
                            if resultPods.count == numberOfPods.count {
                                completion(resultPods)
                            }
                        }
                    }
                }
                catch {}
        }
    }
    
}
