//
//  HomeViewController.swift
//  CinematicVue
//
//  Created by sagar patil on 15/03/2022.
//

import UIKit

class HomeViewController: UIViewController, HomeViewControllerViewModelProtocol {
    private var viewModel: HomeViewControllerViewModel?
    private var movieDetails = [MovieDetails]()
    
    @IBOutlet weak var movieTableView: UITableView! {
        didSet {
            let nibName = UINib(nibName: Constants.movieTableViewCellIdentifier, bundle: nil)
            movieTableView.register(nibName, forCellReuseIdentifier: Constants.movieTableViewCellIdentifier)
            movieTableView.estimatedRowHeight = movieTableView.rowHeight
            movieTableView.rowHeight = UITableView.automaticDimension
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.homeViewControllerTitle
        self.viewModel = HomeViewControllerViewModel()
        self.viewModel?.delegate = self
        self.viewModel?.getMovieData()
    }
    
    func didGetMovieData(movieData: [MovieDetails]) {
        self.movieDetails = movieData
        DispatchQueue.main.async {
            self.movieTableView.reloadData()
        }
    }
    
    func didGetError(errorMessage: String) {
        self.showAlert(alertTitle: "Error", errorMessage: errorMessage)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.movieTableViewCellIdentifier, for: indexPath) as? MovieTableViewCell else {
            fatalError(Constants.tableviewCellDequeueError)
        }
        
        let movieModel = MovieTableCellViewModel(movieModel: movieDetails[indexPath.row])
        cell.configureTableCell(with: movieModel)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO
    }
}


