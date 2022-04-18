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
    @IBOutlet private weak var noMoviesView: UIView!
    @IBOutlet private weak var noMoviesLabel: UILabel!
    
    private var favoritesPresenter: FavoritesPresenterProtocol?
    private var isTableViewEditable = false
    private var editButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesPresenter = FavoritesPresenter(favoritesView: self)
        favoritesPresenter?.fetchFavoriteMovies()
        setupViews()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesPresenter?.fetchFavoriteMovies()
        updateView()
    }
    
    private func updateView() {
        guard let movies = favoritesPresenter?.favoritedMovies else { return }
        if movies.isEmpty {
            noMoviesView.isHidden = false
        } else {
            noMoviesView.isHidden = true
        }
    }
    
    private func localization() {
        noMoviesLabel.text = NSLocalizedString("No favorited movies yet", comment: "")
    }
    
    private func setupViews() {
        localization()
        title = NSLocalizedString("Favorites", comment: "")
        updateView()
        editButton = UIBarButtonItem(title: NSLocalizedString("Edit", comment: ""), style: .plain, target: self, action: #selector(editButtonTapped))
        editButton.tintColor = UIColor(rgb: Constants.Colors.primaryYellowColor)
        self.navigationItem.rightBarButtonItem  = editButton
    }
    
    @objc private func editButtonTapped() {
        if tableView.isEditing {
            tableView.isEditing = false
            editButton.title = NSLocalizedString("Edit", comment: "")
        } else {
            tableView.isEditing = true
            editButton.title = NSLocalizedString("Done", comment: "")
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setEditing(false, animated: true)
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
        favoritesPresenter?.navigateToMovie(at: indexPath.row)
    }
    
    //Allowing both swipe to right to delete & use of "Edit" bar button.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let movie = favoritesPresenter?.favoritedMovies?[indexPath.row] else { return }
            favoritesPresenter?.deleteMovieFromFavorites(movie: movie)
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
