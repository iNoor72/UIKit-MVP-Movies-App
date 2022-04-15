//
//  HomeViewController.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 13/04/2022.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func reloadData()
}

class HomeViewController: UIViewController, HomeViewControllerProtocol {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var usernameLabel: UILabel!
    
    private var homePresenter: HomePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homePresenter = HomePresenter(homeView: self)
        UserDefaults.standard.set("TopRated", forKey: "UserPreference")
        setupViews()
        setupCollectionView()
        checkConnectivity()
    }
    
    private func setupViews() {
        if #available(iOS 14.0, *) {
            let menuItems: [UIAction] =
            [
                UIAction(title: "Top Rated Movies", image: UIImage(systemName: "chart.line.uptrend.xyaxis.circle"), handler: { (_) in
                }),
                UIAction(title: "Popular Movies", image: UIImage(systemName: "flame"), handler: { (_) in
                }),
                UIAction(title: "Favorite Movies", image: UIImage(systemName: "star"), handler: { (_) in
                })
            ]
            
            let demoMenu: UIMenu =
                 UIMenu(title: "Show movies menu", image: nil, identifier: nil, options: [], children: menuItems)
            
            
                let sortButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "list.bullet"), primaryAction: nil, menu: demoMenu)
            navigationItem.rightBarButtonItem = sortButton
            
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    private func checkConnectivity() {
        if Reachability.isConnectedToNetwork() {
            //Get data from Internet
            homePresenter?.fetchPopularMovies()
            homePresenter?.fetchTopRatedMovies()
        } else {
            //Get data from Database
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constants.XIBs.MovieCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.CollectionViewCells.MovieCell)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: 150, height: 230)
        flowLayout.minimumLineSpacing = 8.0
        flowLayout.minimumInteritemSpacing = 8.0
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.showsHorizontalScrollIndicator = false
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let topRatedMoviesCount = homePresenter?.topRatedMoviesList?.results?.count, let popularMoviesCount = homePresenter?.popularMoviesList?.results?.count {
            guard let userPreference = UserDefaults.standard.value(forKey: "UserPreference") else { return 0 }
            
            //Just for now
            return topRatedMoviesCount
        }
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCells.MovieCell, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        guard let userPreference = UserDefaults.standard.value(forKey: "UserPreference") else { return UICollectionViewCell() }
        
        //Just for now
        cell.configure(name: homePresenter?.topRatedMoviesList?.results?[indexPath.row].title ?? "", imageURL: Constants.noImage)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
        vc.detailsPresenter = MovieDetailsPresenter(movie: (homePresenter?.topRatedMoviesList?.results?[indexPath.row])!, detailsView: vc)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
