//
//  Movie.swift
//  movies-tvos
//
//  Created by Velkei Miklós on 2018. 01. 20..
//  Copyright © 2018. NeonatCore. All rights reserved.
//

import Foundation
class Movie{
    var title: String!
    var posterPath: String!
    
    
    init(movieDict: Dictionary<String,AnyObject>) {
        
        if let title = movieDict[CO_TITLE] as? String{
            self.title = title
        }
        
        if let path = movieDict[CO_POSTER_PATH] as? String{
            self.posterPath = "\(CO_POSTER_URL_BASE)\(path)"
        }
        
    }
    
}
