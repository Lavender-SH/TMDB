//
//  MainViewController.swift
//  TMDB
//
//  Created by 이승현 on 2023/09/02.
//

import UIKit
import SnapKit

enum MediaSelection {
    case movie
    case tv
    case person
}

class MainViewController: UIViewController {
    
    var trendingItems: [TrendingItem] = []
    var filteredItems: [TrendingItem] = []
    var personItems: [Result] = []
    
    var selectedMedia: MediaSelection? = nil {
        didSet {
            switch selectedMedia {
            case .movie:
                filteredItems = trendingItems.filter { $0.mediaType == .movie }
            case .tv:
                filteredItems = trendingItems.filter { $0.mediaType == .tv }
            case .person:
                
                break
            case .none:
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
        TrendAPIAllCallRequest(type: type) { [weak self] items in
            guard let weakSelf = self, let items = items else { return }
            weakSelf.trendingItems.append(contentsOf: items)
            weakSelf.filteredItems.append(contentsOf: items)
            weakSelf.tableView.reloadData()
            print(#function)
            print("==0==", weakSelf.trendingItems)
        }
    }
    
    func personLoadData(type: String? = nil) {
        TrendAPIPersonCallRequest(type: type) { [weak self] items in
            guard let weakSelf = self, let items = items else { return }
            weakSelf.personItems.append(contentsOf: items)
            weakSelf.tableView.reloadData()
            print(#function)
            print("==0.00==", weakSelf.trendingItems)
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
        personLoadData(type: searchText)
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
            selectedMedia = .movie
        case 1:
            selectedMedia = .tv
        case 2:
            selectedMedia = .person
            personLoadData()
        default:
            selectedMedia = nil
        }
        tableView.reloadData()
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedMedia {
        case .person:
            return personItems.count
        default:
            return filteredItems.count
        }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectedMedia {
        case .person:
            let personItem = personItems[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonTableViewCell
            cell.configure(with: personItem)
            return cell
        case .movie:
            let item = filteredItems[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
            cell.configure(with: item)
            return cell
        case .tv:
            let item = filteredItems[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVCell", for: indexPath) as! TVTableViewCell
            cell.configure(with: item)
            return cell
        
        case .none:
            return UITableViewCell()
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














