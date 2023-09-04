//
//  PersonTableViewCell.swift
//  TMDB
//
//  Created by 이승현 on 2023/09/03.
//

import UIKit
import Kingfisher

class PersonTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "PersonCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 5
        return label
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: PersonTableViewCell.reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupUI() {
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(posterImageView)
        
        
        posterImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(posterImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(posterImageView.snp.right).offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    
    func configure(with item: Result) {
        if let firstKnownFor = item.knownFor.first {
            titleLabel.text = firstKnownFor.title
            overviewLabel.text = firstKnownFor.overview
            if let posterPath = firstKnownFor.posterPath {
                let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
               posterImageView.kf.setImage(with: url)
            }
        }
    }
}


