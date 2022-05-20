//
// MovieCollectionViewCell.swift
// MovieApp
//
// Created by VN01-MAC-0006 on 18/05/2022.
//
//


import Foundation
import  UIKit
import SDWebImage
class MovieCollectionViewCell: UICollectionViewCell , MovieCellView{
    
    lazy var title : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.text = "title"
        lb.textColor = .white
        return lb
        
    }()
    
    lazy var  publicDate  : UILabel = {
        let lb = UILabel()
        lb.text = "lb"
        lb.textColor  = .darkGray
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        
        return lb
        
    }()
    
    
    lazy var  thumbnailView  : UIImageView = {
        let imgV = UIImageView()
        imgV.translatesAutoresizingMaskIntoConstraints = false
        imgV.contentMode = .scaleAspectFill
        return imgV
        
    }()
    
    lazy var  wrapperContentView  : UIView = {
        let v = UIView()
        return v
        
    }()
    
    lazy var  ratingView  : UIView = {
        let v = UIView()
        v.backgroundColor = .orange
        return v
        
    }()
    
    lazy var  ratingText  : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 1
        lb.textColor = .white
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textAlignment = .center
        return lb
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        self.contentView.addSubview(thumbnailView)
        self.contentView.addSubview(wrapperContentView)
        self.contentView.addSubview(ratingView)
        
        ratingView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        ratingView.layer.masksToBounds = true
        ratingView.layer.cornerRadius = 15
        ratingView.addSubview(ratingText)
    
        ratingText.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.contentView.bringSubviewToFront(wrapperContentView)
        self.contentView.bringSubviewToFront(ratingView)

        
        wrapperContentView.addSubview(title)
        wrapperContentView.addSubview(publicDate)
       
        
        thumbnailView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        wrapperContentView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(0)
        }

        publicDate.leadingAnchor.constraint(equalTo: wrapperContentView.leadingAnchor,constant: 10).isActive = true
        publicDate.trailingAnchor.constraint(equalTo: wrapperContentView.trailingAnchor,constant: -10).isActive = true
        publicDate.topAnchor.constraint(equalTo: wrapperContentView.topAnchor,constant: 5).isActive = true
        publicDate.bottomAnchor.constraint(equalTo: title.topAnchor,constant: 0).isActive = true
        title.leadingAnchor.constraint(equalTo: wrapperContentView.leadingAnchor,constant: 10).isActive = true
        title.trailingAnchor.constraint(equalTo: wrapperContentView.trailingAnchor,constant: -10).isActive = true
        title.topAnchor.constraint(equalTo: publicDate.bottomAnchor,constant: 5).isActive = true
        title.bottomAnchor.constraint(equalTo: wrapperContentView.bottomAnchor,constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func display(movie: Movie) {
        self.title.text = movie.title
        self.publicDate.text = movie.releaseYear
        self.ratingText.text = String(movie.voteAverage)
        guard  let  urlStringEndcode = movie.posterFullPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        self.thumbnailView.sd_setImage(with: URL(string: urlStringEndcode)) { image, error, _, _ in
            if error != nil {
            }
        }
    }
    
}
