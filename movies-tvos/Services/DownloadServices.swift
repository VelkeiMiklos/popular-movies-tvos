//
//  DownloadServices.swift
//  movies-tvos
//
//  Created by Velkei Miklós on 2018. 01. 20..
//  Copyright © 2018. NeonatCore. All rights reserved.
//

import Foundation
import UIKit
class DownloadServices{
    static let instance = DownloadServices()
    
    
    func downloadData(complationHandler: @escaping(_ success: Bool, _ downloadedMoviesData: [Movie]?)->()){
        var movies = [Movie]()
        let url = URL(string: CO_URL_BASE)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, AnyObject>
                let posts = json![CO_RESULTS] as? [Dictionary<String, AnyObject>]
                print(posts)
                
                for obj in posts!{
                    let movie = Movie(movieDict: obj)
                    movies.append(movie)
                }
                complationHandler(true, movies)
            } catch let error as NSError {
                complationHandler(false, nil)
                print(error)
            }
        }).resume()
        
    }
    
    func downloadImage(movie: Movie, completionHandler: @escaping(_ isSuccess:Bool, _ image:  UIImage?)->()){
        if let image = movie.posterPath{
            print(movie.posterPath)
            let url = URL(string: image)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                DispatchQueue.global().async {
                    do{
                        let data = try Data(contentsOf: url!)
                        DispatchQueue.main.sync {
                            let img = UIImage(data: data as Data)
                            completionHandler(true, img)
                        }
                    }
                    catch {
                        print("hiba a kép letöltése során")
                    }
                }
            }).resume()
        }
    }
}
