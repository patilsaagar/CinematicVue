//
//  MovieViewController.swift
//  CinematicVue
//
//  Created by sagar patil on 15/03/2022.
//

import UIKit

class HomeViewController: UIViewController {
    var viewModel: MovieViewControllerViewModel?
    
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
        
        self.setupBinding()
    }
    
    private func setupBinding() {
        let movieResource = MovieResource()
        viewModel = MovieViewControllerViewModel(movieResource: movieResource)
        
        guard let viewModel = viewModel else { return }
        viewModel.getMovieData()

        viewModel.bindDataToViewController = {[weak self] movieDetails, errorString in
            
            if errorString?.count == 0 { return }
            
            self?.viewModel?.populateMovieCellModelViewArray(movieDetails: movieDetails)
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        
        return viewModel.numberOfRowForTableView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: Constants.movieTableViewCellIdentifier, for: indexPath) as? MovieTableViewCell,
                let viewModel = viewModel else {
            fatalError(Constants.tableviewCellDequeueError)
        }

        let movieModel = viewModel.getMovieCellDataModel(indexPath: indexPath)
        movieCell.configureTableCell(with: movieModel)
        
        return movieCell
    }
}

