//
//  ApiService.swift
//  PopularMovies
//
//  Created by Mahmudul Hasan on 15/5/23.
//

import Foundation

class ApiService {
    private var dataTask: URLSessionDataTask?
    
    func getPopularMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        
        let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
        guard let url = URL(string: popularMoviesURL) else {return}
        
        //create URL session
        dataTask = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            //Handle error
            if let error = error {
                completion(.failure(error))
                print("DataTask error\(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                //Handle Empty response
                print("Empty response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Empty data")
                
                return
            }
            
            do {
                //Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
}
