//
//  CustomTableViewCell.swift
//  TMDB
//
//  Created by 이승현 on 2023/09/02.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "MovieCell"
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: MovieTableViewCell.reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
}
