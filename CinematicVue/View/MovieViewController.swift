//
//  MovieViewController.swift
//  CinematicVue
//
//  Created by sagar patil on 15/03/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy private var viewModel = {
        MovieViewControllerViewModel()
    }()
    
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
        viewModel.getMovieData()
        
        viewModel.reloadTableView = {[weak self] in
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: Constants.movieTableViewCellIdentifier, for: indexPath) as? MovieTableViewCell else {
            fatalError(Constants.tableviewCellDequeueError)
        }

        let movieModel = viewModel.getMovieCellDataModel(indexPath: indexPath)
        movieCell.configureTableCell(with: movieModel)
        
        return movieCell
    }
}

