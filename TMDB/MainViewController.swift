//
//  MainViewController.swift
//  TMDB
//
//  Created by 이승현 on 2023/09/02.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var trendingItems: [TrendingItem] = []
    var filteredItems: [TrendingItem] = []
    var selectedMediaType: MediaType? = nil {
        didSet {
            if let mediaType = selectedMediaType {
                filteredItems = trendingItems.filter { $0.mediaType == mediaType }
            } else {
                filteredItems = trendingItems
            }
            tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rowHeight = UITableView.automaticDimension
        view.delegate = self
        view.dataSource = self
        view.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        view.register(TVTableViewCell.self, forCellReuseIdentifier: "TVCell")
        view.register(PersonTableViewCell.self, forCellReuseIdentifier: "PersonCell")
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = ""
        return searchBar
    }()
    
    lazy var movieButton: UIButton = {
        let button = UIButton()
        button.setTitle("Movie", for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        button.tag = 0
        button.backgroundColor = .gray
        return button
    }()
    
    lazy var tvButton: UIButton = {
        let button = UIButton()
        button.setTitle("TV", for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        button.tag = 1
        button.backgroundColor = .green
        return button
    }()
    
    lazy var personButton: UIButton = {
        let button = UIButton()
        button.setTitle("Person", for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        button.tag = 2
        button.backgroundColor = .purple
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
        setupSearchBar()
        setupButtons()
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .yellow
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        title = ""
    }
    func loadData(type: String? = nil) {
        TrendAPICallRequest(type: type) { [weak self] items in
            guard let weakSelf = self, let items = items else { return }
            weakSelf.trendingItems.append(contentsOf: items)
            weakSelf.tableView.reloadData()
            print(#function)
            print("==0==", weakSelf.trendingItems)
        }
    }
    
    
    
    private func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        loadData(type: searchText)
    }
    
    
    
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func setupButtons() {
        let stackView = UIStackView(arrangedSubviews: [movieButton, tvButton, personButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
    @objc func filterButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            selectedMediaType = .movie
        case 1:
            selectedMediaType = .tv
        case 2:
            selectedMediaType = .person
        default:
            selectedMediaType = nil
        }
        tableView.reloadData()
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = filteredItems[indexPath.row]
        
        switch item.mediaType {
        case .movie:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
            cell.configure(with: item)
            print("==1==")
            return cell
            
        case .tv:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVCell", for: indexPath) as! TVTableViewCell
            cell.configure(with: item)
            print("==2==")
            return cell
            
        case .person:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonTableViewCell
            cell.configure(with: item)
            print("==3==")
            return cell
        }
    }
    
}
    
    extension MainViewController: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            
            if range.location == 0 {
                searchBar.text = text.lowercased()
                return false
            }
            return true
        }
    }
    
    
