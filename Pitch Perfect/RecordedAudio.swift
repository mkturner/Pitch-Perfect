//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Marvin T. on 4/5/15.
//  Copyright (c) 2015 Marvin Turner. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathURL: NSURL!
    var title: String!
    
    init(raurl: NSURL!, ratitle: String!) {
        self.filePathURL = raurl
        self.title = ratitle
    }
    
}