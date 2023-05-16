//
//  MovieTableViewCell.swift
//  PopularMovies
//
//  Created by Mahmudul Hasan on 15/5/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieOverView: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    
    private var urlString : String = ""
    
    //setup movies value
    func setCellWithValuesOf(_ movie:Movie) {
        updateUI(title: movie.title, releaseDate: movie.year!, rating: movie.rating, overview: movie.overview, poster: movie.posterImage)
    }
    
    //Update UI
    private func updateUI(title: String? , releaseDate: String, rating: Double?, overview: String?, poster: String?) {
        self.movieTitle.text = title
        self.movieYear.text = convertDateFormater(releaseDate)
        guard let rate = rating else {return}
        self.movieRate.text = String(rate)
        self.movieOverView.text = overview
        
        guard let posterString = poster else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
                
        guard let posterImageURL = URL(string: urlString) else {
            self.moviePoster.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // Before we download the image we clear out the old one
        self.moviePoster.image = nil
        
        getImageDataFrom(url: posterImageURL)
    }
    
    // MARK: - Get image data
      private func getImageDataFrom(url: URL) {
          URLSession.shared.dataTask(with: url) { (data, response, error) in
              // Handle Error
              if let error = error {
                  print("DataTask error: \(error.localizedDescription)")
                  return
              }
              
              guard let data = data else {
                  // Handle Empty Data
                  print("Empty Data")
                  return
              }
              
              DispatchQueue.main.async {
                  if let image = UIImage(data: data) {
                      self.moviePoster.image = image
                  }
              }
          }.resume()
      }
    
    // MARK: - Convert date format
        func convertDateFormater(_ date: String?) -> String {
            var fixDate = ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let originalDate = date {
                if let newDate = dateFormatter.date(from: originalDate) {
                    dateFormatter.dateFormat = "dd.MM.yyyy"
                    fixDate = dateFormatter.string(from: newDate)
                }
            }
            return fixDate
        }
    
}
