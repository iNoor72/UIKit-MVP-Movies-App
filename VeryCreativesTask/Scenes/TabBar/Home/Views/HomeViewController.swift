//
//  HomeViewController.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 13/04/2022.
//

import UIKit
import MOLH

protocol HomeViewControllerProtocol: AnyObject, NavigationRoute {
    func reloadData()
}

@available(iOS 13.0, *)
class HomeViewController: UIViewController, HomeViewControllerProtocol {
    //MARK: IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var helloLabel: UILabel!
    @IBOutlet private weak var moviesLabel: UILabel!
    
    
    //MARK: Variables
    private var homePresenter: HomePresenterProtocol?
    private var result : (Int, MovieType)?
    private var page = 1
    
    private var topRatedItem: UIAction!
    private var popularItem: UIAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homePresenter = HomePresenter(homeView: self)
        
        //By default, Top Rated movies are fetched.
        UserDefaults.standard.set(MovieType.topRated.rawValue, forKey: "UserPreference")
        result = getMovieCountAndType(preference: "TopRated")
        
        setupViews()
        setupCollectionView()
        checkConnectivity()
    }
    
    @objc private func languageButtonTapped() {
        //Do some logic here to change language, I've written some code but it requires the app to be forced to exit, the code is commented here (This code doesn't require any pods)
        
        //You can run: command+option+R and specify the device language from: Run -> Options -> App Language
        //Change it to Arabic or English to see the difference
        
//        if Locale.current.languageCode == "ar" {
//            LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
//            exit(0)
//        } else {
//            LocalizationSystem.sharedInstance.setLanguage(languageCode: "ar")
//            exit(0)
//        }
        
        //Another way is using the MOLH pod, activiting it in the AppDelegate file and conforming to MOLHResetable protocol
//        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
//        MOLH.reset()
    }
    
    private func localization() {
        usernameLabel.text = NSLocalizedString("VeryCreatives!", comment: "")
        helloLabel.text = NSLocalizedString("Hello,", comment: "")
        moviesLabel.text = NSLocalizedString("Checkout these movies!", comment: "")
        
        self.tabBarController?.viewControllers?[0].title = NSLocalizedString("Top Rated Movies", comment: "")
        self.tabBarController?.viewControllers![1].title = NSLocalizedString("Favorites", comment: "")
    }
    
    private func setupViews() {
        if Locale.current.languageCode == "en" {
            let languageButton = UIBarButtonItem(image: UIImage(systemName: "textformat.size.smaller.ar"), style: .plain, target: self, action: #selector(languageButtonTapped))
            languageButton.tintColor = UIColor.systemYellow
            self.navigationItem.leftBarButtonItem  = languageButton
        } else if Locale.current.languageCode == "ar" {
            let languageButton = UIBarButtonItem(title: "A", style: .plain, target: self, action: #selector(languageButtonTapped))
            languageButton.tintColor = UIColor.systemYellow
            self.navigationItem.leftBarButtonItem  = languageButton
        }
        localization()
        navigationController?.navigationBar.tintColor = UIColor(rgb: Constants.Colors.primaryYellowColor)
        title = NSLocalizedString("Top Rated Movies", comment: "")
        if #available(iOS 14.0, *) {
            
            topRatedItem = UIAction(title: NSLocalizedString("Top Rated Movies", comment: ""), image: UIImage(systemName: "chart.line.uptrend.xyaxis.circle"), handler: { [weak self] _ in
                guard let self = self else { return }
                UserDefaults.standard.set(MovieType.topRated.rawValue, forKey: "UserPreference")
                self.homePresenter?.fetchTopRatedMovies(page: self.page)
                self.result = self.getMovieCountAndType(preference: MovieType.topRated.rawValue)
                self.title = NSLocalizedString("Top Rated Movies", comment: "")
            })
            
            popularItem = UIAction(title: NSLocalizedString("Popular Movies", comment: ""), image: UIImage(systemName: "flame"), handler: { [weak self] _ in
                guard let self = self else { return }
                UserDefaults.standard.set(MovieType.popular.rawValue, forKey: "UserPreference")
                self.homePresenter?.fetchPopularMovies(page: self.page)
                self.result = self.getMovieCountAndType(preference: MovieType.popular.rawValue)
                self.title = NSLocalizedString("Popular Movies", comment: "")
            })
            
            let menuItems: [UIAction] = [topRatedItem, popularItem]
            
            let menu =
            UIMenu(title: NSLocalizedString("Show movies menu", comment: ""), image: nil, identifier: nil, options: [], children: menuItems)
            let sortButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "list.bullet"), primaryAction: nil, menu: menu)
            
            navigationItem.rightBarButtonItem = sortButton
            navigationItem.rightBarButtonItem?.tintColor = UIColor(rgb: Constants.Colors.primaryYellowColor)
        }
        
        else {
            // Fallback on earlier versions
        }
        
    }
    
    private func checkConnectivity() {
        if Reachability.isConnectedToNetwork() {
            //Get data from Internet
            homePresenter?.fetchPopularMovies(page: page)
            homePresenter?.fetchTopRatedMovies(page: page)
        } else {
            //Switch to Favorites Tab
            let alert = UIAlertController(title: NSLocalizedString("You're disconnected to Internet.", comment: ""), message: NSLocalizedString("Your phone is not connected to internet. You have been switched to Favorites movies.", comment: ""), preferredStyle: .alert)
            let action = UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
            self.tabBarController?.selectedIndex = 1
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constants.XIBs.MovieCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.CollectionViewCells.MovieCell)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: 170, height: 285)
        flowLayout.minimumLineSpacing = 8.0
        flowLayout.minimumInteritemSpacing = 8.0
        self.collectionView.semanticContentAttribute = .unspecified
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func getMovieCountAndType(preference: String) -> (Int, MovieType) {
        guard let topRatedMoviesCount = homePresenter?.topRatedMoviesList?.results?.count, let popularMoviesCount = homePresenter?.popularMoviesList?.results?.count else { return (0, MovieType.topRated) }
        
        switch MovieType(rawValue: preference) {
        case .topRated:
            if MovieType.topRated.rawValue == preference {
                return (topRatedMoviesCount, MovieType.topRated)
            }
        case .popular:
            if MovieType.popular.rawValue == preference {
                return (popularMoviesCount, MovieType.popular)
            }
        case .none:
            return (0, MovieType.topRated)
        }
        
        return (0, MovieType.topRated)
    }
    
    //MARK: Protocol Functions
    func reloadData() {
        DispatchQueue.main.async {[weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

//MARK: Extensions

//MARK: CollectionView
@available(iOS 13.0, *)
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let userPreference = UserDefaults.standard.value(forKey: "UserPreference") else { return 0 }
        result = getMovieCountAndType(preference: userPreference as! String)
        return result?.0 ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCells.MovieCell, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        guard let userPreference = UserDefaults.standard.value(forKey: "UserPreference") else { return UICollectionViewCell() }
        result = getMovieCountAndType(preference: userPreference as! String)
        
        switch result?.1 ?? MovieType.topRated {
        case .topRated:
            cell.configure(name: homePresenter?.topRatedMoviesList?.results?[indexPath.row].title ?? "", movieImageURL: homePresenter?.topRatedMoviesList?.results?[indexPath.row].poster_path ?? "")
            
        case .popular:
            cell.configure(name: homePresenter?.popularMoviesList?.results?[indexPath.row].title ?? "", movieImageURL: homePresenter?.popularMoviesList?.results?[indexPath.row].poster_path ?? "")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch result?.1 ?? MovieType.topRated {
        case .topRated:
            homePresenter?.userMoviePreference = .topRated
            homePresenter?.navigateToMovie(at: indexPath.row)
        case .popular:
            homePresenter?.userMoviePreference = .popular
            homePresenter?.navigateToMovie(at: indexPath.row)
        }
    }
    
    //MARK: Pagination
    //UICollectionView extends UIScrollView, so we can access its functions
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > (self.collectionView.contentSize.height-30-scrollView.frame.size.height) {
            switch result?.1 ?? MovieType.topRated {
            case .topRated:
                self.page += 1
                print(page)
                self.homePresenter?.fetchTopRatedMovies(page: self.page)
            case .popular:
                self.page += 1
                self.homePresenter?.fetchPopularMovies(page: self.page)
            }
        }
    }
}
