//
//  ViewController.swift
//  MovieListing
//
//  Created by Rajasekaran Gopal on 10/04/22.
//

import UIKit

class ViewController: UIViewController {

    var movieViewModel:MovieListviewModel = MovieListviewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        movieViewModel.callPopularMovieListAPI(with: 1) { content in
            print(content)
        } failureHandler: { error in
            
        }
        
    }

//
}

