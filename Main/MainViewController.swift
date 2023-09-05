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
}

class MainViewController: BaseViewController {
    
    let mainView = MainView()
    var trendingItems: [TrendingItem] = []
    var filteredItems: [TrendingItem] = []
    var personItems: [Result] = []
    var isPersonSelected: Bool = false
    var isEnd = false
    var page = 1
    
    var selectedMedia: MediaSelection? = nil {
        didSet {
            switch selectedMedia {
            case .movie:
                filteredItems = trendingItems.filter { $0.mediaType == .movie }
            case .tv:
                filteredItems = trendingItems.filter { $0.mediaType == .tv }
            case .none:
                break
            }
            mainView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(type: "movie", page: page)
        personLoadData(type: "person", page: page)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.prefetchDataSource = self
        mainView.searchBar.delegate = self
        
        mainView.movieButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        mainView.tvButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        mainView.personButton.addTarget(self, action: #selector(personButtonTapped(_:)), for: .touchUpInside)
        
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .yellow
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        title = ""
    }
    
    
    func loadData(type: String? = nil, page: Int) {
        TrendAPIAllCallRequest(type: type, page: page) { [weak self] items in
            guard let weakSelf = self, let items = items else { return }
            weakSelf.trendingItems.append(contentsOf: items)
            weakSelf.filteredItems.append(contentsOf: items)
            weakSelf.mainView.tableView.reloadData()
            print(#function)
            //print("==0==", weakSelf.trendingItems)
        }
    }
    //⭐️⭐️⭐️
    func personLoadData(type: String? = nil, page: Int) {
        TrendAPIPersonCallRequest(type: type, page: page) { [weak self] items in
            //print("===333===", items)
            guard let weakSelf = self, let items = items else { return }
            weakSelf.personItems.append(contentsOf: items)
            weakSelf.mainView.tableView.reloadData()
            print(#function)
            print("==444==", weakSelf.personItems.count, page)
        }
    }
    
    
    @objc func filterButtonTapped(_ sender: UIButton) {
        isPersonSelected = false
        switch sender.tag {
        case 0:
            selectedMedia = .movie
        case 1:
            selectedMedia = .tv
        default:
            selectedMedia = nil
        }
        mainView.tableView.reloadData()
    }
    
    @objc func personButtonTapped(_ sender: UIButton) {
        selectedMedia = nil
        isPersonSelected = true
        personLoadData(type: "person", page: page)
        mainView.tableView.reloadData()
    }
}

// MARK: - tableView 확장
extension MainViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isPersonSelected {
            return personItems.count
        }
        switch selectedMedia {
        case .movie, .tv:
            return filteredItems.count
        case .none:
            return 0
        }
    }

    //⭐️⭐️⭐️
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isPersonSelected {
            guard indexPath.row < personItems.count else {
                return UITableViewCell()
            }
            
            let personItem = personItems[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonTableViewCell
            cell.configure(with: personItem)
            return cell
        }
        
        switch selectedMedia {
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
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print(#function)
        for indexPath in indexPaths {
            
            page = 1
        

            print("=====99999999999======", personItems.count, page)
            if isPersonSelected {
                if personItems.count - 1 == indexPath.row && page < 15 && isEnd == false {
                    personItems.removeAll()
                    page += 1
                    print("===788888777===", page)
                    //personLoadData(type: mainView.searchBar.text, page: page)
                    personLoadData(type: "person", page: page)
                    
                }
                print("=====99999999999======", personItems.count, page)
            } else {
                if filteredItems.count - 1 == indexPath.row && page < 15 && isEnd == false {
                    personItems.removeAll()
                    page += 1
                    print("===77777777===", page)
                    //loadData(type: mainView.searchBar.text, page: page)
                    loadData(type: "movie", page: page)
                    
                }
            }
            print("=====99999999999======", personItems.count, page) } 
    }
    
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("=====취소: \(indexPaths)")
    }
}

// MARK: - SearchBar 확장
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if range.location == 0 {
            searchBar.text = text.lowercased()
            return false
        }
        return true
    }
    
    //⭐️⭐️⭐️
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        loadData(type: searchText, page: page)
        personLoadData(type: searchText, page: page)
        mainView.tableView.reloadData()
    }
}


