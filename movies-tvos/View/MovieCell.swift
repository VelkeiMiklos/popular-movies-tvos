//
//  MovieCell.swift
//  movies-tvos
//
//  Created by Velkei Miklós on 2018. 01. 20..
//  Copyright © 2018. NeonatCore. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLbl: UILabel!
    
    func configureCell(movie: Movie){
        self.movieLbl.text = movie.title
        DownloadServices.instance.downloadImage(movie: movie) { (isSucces, downloadedImage) in
            if isSucces{
                self.movieImage.image = downloadedImage
            }
        }
    }
    
}
