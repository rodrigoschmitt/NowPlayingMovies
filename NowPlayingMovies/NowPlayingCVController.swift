//
//  NowPlayingCVC.swift
//  Movies
//
//  Created by Rodrigo Andrade on 3/13/16.
//  Copyright © 2016 Rodrigo Andrade. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

private let reuseIdentifier = "CustomCellIdentifier"

class NowPlayingCVController: UICollectionViewController {
    
    var movies:[Movie] = [Movie]()
    
    func loadData() {
        if Reachability().hasConnection {
            let moviesManager = MoviesManager()
            
            moviesManager.getMovies({ (movies, error) -> () in
                if error == nil {
                    self.movies = movies!
                    self.performSelector(onMainThread: #selector(NowPlayingCVController.updateCollectionView), with: nil, waitUntilDone: false)
                } else {
                    print(#function, error.debugDescription)
                }
            })
        }
        else {
            let alert = UIAlertController(title: "Movies", message: "BAD :-( No internet connection!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { (alertAction) -> Void in
                self.loadData()
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func updateCollectionView() {
        self.collectionView!.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Now Playing"
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath: IndexPath = sender as! IndexPath
        let movieDetailViewController = segue.destination as! MovieDetailViewController
        movieDetailViewController.movie = movies[(indexPath as NSIndexPath).row]
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NowPlayingCollectionViewCell
        
        cell.nameLabel.text = movies[(indexPath as NSIndexPath).row].name!
        Alamofire.request(movies[(indexPath as NSIndexPath).row].posterURL!, method: .get).responseImage { response in
            guard let image = response.result.value else { return }
            cell.poster.image = image
        }
        
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "MovieDetail", sender: indexPath)
    }


}
