//
//  ResultDat.swift
//  WereWolfram
//
//  Created by QUANG on 7/16/18.
//  Copyright © 2018 QUANG. All rights reserved.
//

import UIKit

class Pod {

    //MARK: Variables
    var title: String
    var imageLink: URL
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    var plainText: String

    //MARK: Initializers
    init(title: String, imageLink: URL, imageWidth: CGFloat, imageHeight: CGFloat, plainText: String) {
        self.title = title
        self.imageLink = imageLink
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.plainText = plainText
    }
}
