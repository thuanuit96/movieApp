

import Foundation

typealias Result<T> = Swift.Result<T, Error>
protocol MovieInteractor: AnyObject {
    func fetchData(completionHandler :@escaping (Result<[Movie]>) -> Void)
    func shouldGetMovies() -> Bool
}

class MovieInteractorImplementation: MovieInteractor {
    
    var currentPage = 0
    var totalPages  = 1
    var apiClient : ApiClient
    var movieParse : MovieParse
    var movieRequest : ListMovieApiRequest
    
    init(apiClient : ApiClient, movieRequest : ListMovieApiRequest  , movieParse : MovieParse) {
        self.apiClient = apiClient
        self.movieRequest = movieRequest
        self.movieParse = movieParse
    }
    
    func fetchData(completionHandler :@escaping (Result<[Movie]>) -> Void) {
        movieRequest.setCurrentPage(page: currentPage + 1)
        apiClient.execute(request:movieRequest) { (result: Result<ApiResponse>)  in
            switch result {
            case let .success(reponse):
                self.movieParse.parseData(data: reponse.data ?? Data()) { [weak self] resultParse in
                    guard let self = self else {
                        return
                    }
                    switch resultParse {
                        case let .success(reponseDataParsed):
                            print("reponseDataParsed.page :\( reponseDataParsed.page)")
                            self.currentPage = reponseDataParsed.page
                            self.totalPages = reponseDataParsed.totalPages
                            completionHandler(.success(reponseDataParsed.listMovie))
                        case let .failure(error):
                            print("error when parse data :\(error)")
                            completionHandler(.failure(error))

                    }
                }
            case let .failure(error):
                completionHandler(.failure(error))
            }
            
        }
    }
    
    func shouldGetMovies() -> Bool {
        if currentPage > totalPages {
            return false
        }
        
        return true
    }
}

