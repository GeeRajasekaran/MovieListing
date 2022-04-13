//
//  ViewController.swift
//  MovieListing
//
//  Created by Rajasekaran Gopal on 10/04/22.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Outlet Declaration
    var collectionView: UICollectionView!
    
    //MARK: - Property Declaration
    enum MovieSections: String {
        case popularMovie = "Popular Movies"
        case upcomingMovie = "Upcoming Movies"
    }
    var dataSource: UICollectionViewDiffableDataSource<MovieSections,MovieList>?
    var snapShot = NSDiffableDataSourceSnapshot<MovieSections,MovieList>()

    
    var movieViewModel:MovieListviewModel = MovieListviewModel()
    var popularMovieList: [MovieList]?
    var upcomingMovieList: [MovieList]?
    var limit = 20
    var totalPages = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalSetup()
    }
    
    
    //MARK: - Custom Methods
    private func initalSetup(){
        collectionViewSetup()
        callMovieListAPI()
        configureDataSource()
    }
    
    private func collectionViewSetup(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: self.createCompositionalLayout()!)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        //Register Cells
        collectionView.register(CollectionViewSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewSectionHeader.reuseIdentifier)
        collectionView.register(SmallGridLayoutCollectionViewCell.self, forCellWithReuseIdentifier: SmallGridLayoutCollectionViewCell.reuseIdentifier)
    }
    
    private func callMovieListAPI(){
        
        movieViewModel.callPopularMovieListAPI(with: 1) { content in
            print(content)
            guard let listOfMovies = content.results else {return}
            self.popularMovieList = listOfMovies
            self.reloadDataWithSnapShot()
        } failureHandler: { error in
            //MARK: - Handle Failure here
        }

        //MARK: - Add the upcoming API Call
    }

    
    //MARK: Diffable datasource configurations
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<MovieSections,MovieList>(collectionView: self.collectionView, cellProvider: { (collectionView, indexpath, movieList) -> UICollectionViewCell? in
            
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: SmallGridLayoutCollectionViewCell.reuseIdentifier,
                                                           for: indexpath) as? SmallGridLayoutCollectionViewCell
            
            cell?.configure(with: movieList)
            return cell
            
        })
        collectionViewSectionHeaderSetup()
    }
    
    private func collectionViewSectionHeaderSetup(){
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            //Here we need to provide a view for a section header
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSectionHeader.reuseIdentifier, for: indexPath) as? CollectionViewSectionHeader else {
                return nil
            }
            
            sectionHeader.sectionTitle.text = "sectionData.title"
            return sectionHeader
        }
    }
    
    private func reloadDataWithSnapShot(){
        snapShot.appendSections([.popularMovie,
                                 .upcomingMovie])
        
        snapShot.appendItems(popularMovieList ?? [], toSection: .popularMovie)
        snapShot.appendItems(upcomingMovieList ?? [], toSection: .upcomingMovie)
        
        dataSource?.apply(snapShot)
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout?{
        
        let compositionalLayout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let layoutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                        heightDimension: .fractionalHeight(0.65))
            
            let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 15)
            
            let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(180),
                                                         heightDimension: .fractionalHeight(0.45))
            
            let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            layoutSection.contentInsets  = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
//            layoutSection.boundarySupplementaryItems = [createCollectionViewSectionHeaderLayout()]
            
            return layoutSection
        }
        return compositionalLayout
    }

}
