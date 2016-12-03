//
//  MoviesManager.swift
//  Movies
//
//  Created by Rodrigo Andrade on 3/10/16.
//  Copyright © 2016 Rodrigo Andrade. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
//import CloudKit

class MoviesManager: NSObject {
    
/*
     // MARK: - CloudKit
    
    var database: CKDatabase
    let container = CKContainer.default()
    
    override init() {
        database = container.publicCloudDatabase
    }
    
    func addFavoriteMovie(_ movie: Movie, callback: @escaping (_ succeed: Bool, _ error: NSError?) -> ()) {
        let record = CKRecord(recordType: "Favorites")
        record.setObject(movie.id! as CKRecordValue?, forKey: "favoriteId")
        record.setObject(movie.name! as CKRecordValue?, forKey: "name")
        database.save(record, completionHandler: { (record, error) -> Void in
            
            if error != nil {
                print(#function, error.debugDescription)
            } else {
                print("Saved")
            }
            
            callback((error == nil), error as NSError?)
        })
    }
 */
    
    // MARK: - JSONs TheMovieDB
    
    let feedURL = "https://api.themoviedb.org/3/movie/now_playing?api_key=13f8cae49f248b7fcc3923c9450261c3"
    let posterURL = "https://image.tmdb.org/t/p/w500/"
    
    func getMovies(_ callback:@escaping (_ movies: [Movie]?, _ error: Error?) -> ()) {
        
        Alamofire.request(feedURL, method: .get).responseData { (response) -> Void in
            var movies:[Movie] = [Movie]()
            let json = JSON(data: response.data!)
            for (_, subJSON):(String, JSON) in json["results"] {
                
                let path = self.posterURL + subJSON["poster_path"].string!
                let movie = Movie(
                    id: subJSON["id"].int,
                    name: subJSON["title"].string,
                    voteAverage: subJSON["vote_average"].float,
                    overview: subJSON["overview"].string,
                    posterURL: URL(string: path),
                    releaseDate: subJSON["release_date"].string
                )
                movies.append(movie)
            }
            callback(movies, response.result.error)
        }
    }
}
