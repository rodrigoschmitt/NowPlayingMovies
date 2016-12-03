//
//  MovieDetailVC.swift
//  Movies
//
//  Created by Rodrigo Andrade on 3/13/16.
//  Copyright © 2016 Rodrigo Andrade. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieDetailVC: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var movie: Movie!
    
    func addFavoriteMovie () {
//        let moviesManager = MoviesManager()
//        
//        moviesManager.addFavoriteMovie(movie) { (succeed, error) -> () in
//            
//            if succeed == false {
//                self.showAlert("Ops", message: "Problem to save this movie!")
//            }
//            
//        }
    }
    
    //MARK: - Lifecycle VC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(movie.posterURL!, method:.get).responseImage { response in
            guard let image = response.result.value else { return }
            self.backgroundImageView.image = image
            self.posterImageView.image = image
        }
        movieNameLabel.text = movie.name!
        voteAverageLabel.text = "Average Rating: \(movie.voteAverage!) / 10"
        releaseDateLabel.text = "Release: \(movie.releaseDate!)"
        overviewTextView.text = movie.overview!
    }
    
    @IBAction func addToWatchingList(_ sender: AnyObject) {
        addFavoriteMovie()
    }
    
    func showAlert(_ title: String!, message: String!) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
        present(alert, animated: true, completion: nil)
    }
}
