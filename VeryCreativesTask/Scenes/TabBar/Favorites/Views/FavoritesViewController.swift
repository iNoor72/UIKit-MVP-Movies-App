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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        favoritesPresenter?.fetchFavoriteMovies()
    }
    
    private func setupViews() {
        title = "Favorites"
        editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
        editButton.tintColor = UIColor.systemYellow
        self.navigationItem.rightBarButtonItem  = editButton
    }
    
    @objc private func editButtonTapped() {
        if tableView.isEditing {
            tableView.isEditing = false
            editButton.title = "Edit"
        } else {
            tableView.isEditing = true
            editButton.title = "Done"
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
        //Gives an error + can't unfavorite the movie
        //        favoritesPresenter?.navigateToMovie(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if (self.tableView.isEditing) {
            return UITableViewCell.EditingStyle.delete
        }
        return UITableViewCell.EditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //This line gives an error, but deletes data correctly from Core Data
            favoritesPresenter?.deleteMovieFromFavorites(movie: (favoritesPresenter?.favoritedMovies?[indexPath.row])!)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
           }
    }
}
