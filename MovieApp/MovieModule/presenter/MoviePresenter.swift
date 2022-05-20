

import Foundation
import UIKit


protocol MovieView {
    func refreshView()
    func reloadRow(at indexPath: IndexPath)
    func showDetailView(movie : Movie)
    func displayNewsRetrievalError(title: String, message: String)
    func presentView(view : UIViewController)
    func showDialog()

}
extension MovieView {
    func presentView(view: UIViewController) {}
    func showDialog(){}
    
}

protocol MovieCellView {
    func display(movie: Movie)
}

extension MovieCellView {
    func display(imageURL: String) {}
    
}

protocol MoviePresenter {
    var view: MovieView? {get set}
    var movieInteractor :  MovieInteractor?{get set}
    var numberOfMovie: Int { get }
    var isFechingData : Bool {get set}
    var listMovies : [Movie] {get set}
    func getData()
    func configure(cell: MovieCellView, forRow indexPath: IndexPath)
    func didSelect(row: Int)
    var router: MovieRouter? {get set}
}

class MoviePresenterImplementation: MoviePresenter {
    var view: MovieView?
        
    var listMovies = [Movie]()
    var numberOfMovie: Int {
        return listMovies.count
    }
    var movieInteractor :  MovieInteractor?
    var router: MovieRouter?
    var isFechingData = false
    
    init(movieInteractor :  MovieInteractor, movieView : MovieView, router : MovieRouter) {
        self.movieInteractor = movieInteractor
        self.view = movieView
        self.router = router

    }
    
    func configure(cell: MovieCellView, forRow indexPath : IndexPath) {
        let movie = listMovies[indexPath.row]
        cell.display(movie: movie)
    }
    
    
    func getData() {
        if !(movieInteractor?.shouldGetMovies() ?? false) || isFechingData { return }
        self.isFechingData = true
        movieInteractor?.fetchData() { [weak self] result in
            guard let self = self else {
                return
            }
            self.isFechingData = false
            switch result {
            case let .success(listMovie):
                self.listMovies.append(contentsOf: listMovie)
                self.view?.refreshView()
            case let .failure(err):
                self.view?.displayNewsRetrievalError(title: "Error", message: err.localizedDescription)
            }
        }
    }
    
    func didSelect(row: Int) {
        view?.showDetailView(movie: self.listMovies[row])
    }
}
