//
//  ViewController.swift
//  PopularMovies
//
//  Created by Mahmudul Hasan on 15/5/23.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = MovieViewModel()
    
    // var apiService = ApiService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        apiService.getPopularMoviesData { (result) in
//
//            print(result)
//        }
       
        loadPopularMoviesData()
}

    private func loadPopularMoviesData() {
           viewModel.fetchPopularMoviesData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }
}


//table view
extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
                
            let movie = viewModel.cellForRowAt(indexPath: indexPath)
            cell.setCellWithValuesOf(movie)
                
            return cell
    }
    
    
}
