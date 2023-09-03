//
//  Main.swift
//  TMDB
//
//  Created by 이승현 on 2023/09/03.
//

import UIKit

class MainView: BaseView {

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rowHeight = UITableView.automaticDimension
        view.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        view.register(TVTableViewCell.self, forCellReuseIdentifier: "TVCell")
        view.register(PersonTableViewCell.self, forCellReuseIdentifier: "PersonCell")
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = ""
        return searchBar
    }()
    
    lazy var movieButton: UIButton = {
        let button = UIButton()
        button.setTitle("Movie", for: .normal)
        button.tag = 0
        button.backgroundColor = .gray
        return button
    }()
    
    lazy var tvButton: UIButton = {
        let button = UIButton()
        button.setTitle("TV", for: .normal)
        button.tag = 1
        button.backgroundColor = .green
        return button
    }()
    
    lazy var personButton: UIButton = {
        let button = UIButton()
        button.setTitle("Person", for: .normal)
        button.tag = 2
        button.backgroundColor = .purple
        return button
    }()
    
    override func configureView() {
        addSubview(searchBar)
        addSubview(tableView)
        setupButtons()
        
    }
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
        
    }

    
    private func setupButtons() {
        let stackView = UIStackView(arrangedSubviews: [movieButton, tvButton, personButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-10)
            make.left.right.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
}
