//
//  ViewController.swift
//  movies-tvos
//
//  Created by Velkei Miklós on 2018. 01. 20..
//  Copyright © 2018. NeonatCore. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var movies = [Movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        DownloadServices.instance.downloadData { (isSuccess, returnedMovies) in
            if isSuccess{
                self.movies = returnedMovies!
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CO_CELL, for: indexPath) as? MovieCell else { return UICollectionViewCell() }
        let movie = movies[indexPath.row]
        cell.configureCell(movie: movie)
        return cell
    }

}

