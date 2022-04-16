//
//  FavoritesViewController.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 14/04/2022.
//

import UIKit

protocol FavoritesViewControllerProtocol: AnyObject, NavigationRoute {
    func reloadData()
}

class FavoritesViewController: UIViewController, FavoritesViewControllerProtocol {
    @IBOutlet private weak var tableView: UITableView!
    private var favoritesPresenter: FavoritesPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        favoritesPresenter = FavoritesPresenter(favoritesView: self)
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesPresenter?.fetchFavoriteMovies()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reloadData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.XIBs.FavoriteMovieTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.TableViewCells.FavoriteMovieCell)
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesPresenter?.favoritedMovies?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCells.FavoriteMovieCell, for: indexPath) as? FavoriteMovieTableViewCell else { return UITableViewCell() }
        guard let movie = favoritesPresenter?.favoritedMovies?[indexPath.row] else { return UITableViewCell() }
                                                               
        cell.configure(movie: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
