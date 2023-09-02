//
//  PersonTableViewCell.swift
//  TMDB
//
//  Created by 이승현 on 2023/09/03.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    
    static let reuseIdentifier = "PersonCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: PersonTableViewCell.reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
