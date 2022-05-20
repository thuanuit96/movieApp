//
//  MovieRouter.swift
//  VIPER-demo
//
//  Created by Bipin on 7/2/18.
//  Copyright © 2018 Tootle. All rights reserved.
//

import Foundation
import UIKit

protocol MovieRouter: AnyObject {
    
    static func createMovieModule() -> MovieViewController
    
}

class MovieRouterImplementation: MovieRouter{
    static func createMovieModule() -> MovieViewController {
        let view = MovieViewController()
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,
                                                completionHandlerQueue: OperationQueue.main)
        let request = ListMovieApiRequest()
        let movieParseData = MovieParseJson()
        let movieInteractor = MovieInteractorImplementation(apiClient: apiClient, movieRequest : request, movieParse: movieParseData)
        //
        let presenter = MoviePresenterImplementation(movieInteractor: movieInteractor , movieView:MovieViewController(), router: MovieRouterImplementation())
        view.moviePresenter = presenter
        presenter.view = view
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
}
