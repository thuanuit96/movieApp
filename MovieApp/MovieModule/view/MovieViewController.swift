//
// MovieViewController.swift
// MovieApp
//
// Created by VN01-MAC-0006 on 18/05/2022.
//
//

import Foundation
import UIKit

class MovieViewController: UIViewController {
    
    lazy var listMovieView : ListView = {
        let mvView = ListView()
        mvView.presenter = moviePresenter
        return mvView
    }()
    
    var moviePresenter : MoviePresenter?
    
    override func viewDidLoad() {
        title = "Popular list"
        self.view.addSubview(listMovieView)
        listMovieView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        moviePresenter?.getData()
    }
}


extension MovieViewController : MovieView {
    
    func refreshView() {
        listMovieView.reloadData {}
    }
    
    func displayNewsRetrievalError(title: String, message: String) {
        
        hideProgressIndicator(view: self.view)
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Data", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showDialog() {
        presentAlert(with: "Success", message: "add  success")
    }
    
    private func presentAlert(with title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertVC.addAction(.init(title: "Ok", style: .default, handler: nil))
        
        present(alertVC, animated: true, completion: nil)
    }
    func showDetailView(movie : Movie) {
        //To do
    }
    func reloadRow(at indexPath: IndexPath) {}
    
}
