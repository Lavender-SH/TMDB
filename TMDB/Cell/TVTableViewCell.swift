//
//  TVTableViewCell.swift
//  TMDB
//
//  Created by 이승현 on 2023/09/03.
//

import UIKit

class TVTableViewCell: UITableViewCell {
    
    
    static let reuseIdentifier = "TVCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: TVTableViewCell.reuseIdentifier)
        
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
