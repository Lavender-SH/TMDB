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

class MainViewController: BaseViewController {
    
    let mainView = MainView()
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
            mainView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.searchBar.delegate = self
        mainView.movieButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        mainView.tvButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        mainView.personButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        
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
            weakSelf.mainView.tableView.reloadData()
            print(#function)
            print("==0==", weakSelf.trendingItems)
        }
    }
    
    func personLoadData(type: String? = nil) {
        TrendAPIPersonCallRequest(type: type) { [weak self] items in
            guard let weakSelf = self, let items = items else { return }
            weakSelf.personItems.append(contentsOf: items)
            weakSelf.mainView.tableView.reloadData()
            print(#function)
            print("==0.00==", weakSelf.trendingItems)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        loadData(type: searchText)
        personLoadData(type: searchText)
    }
    
    
    @objc func filterButtonTapped(_ sender: UIButton) {r
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
        mainView.tableView.reloadData()
    }
}

// MARK: - tableView 확장
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

// MARK: - SearchBar 확장
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if range.location == 0 {
            searchBar.text = text.lowercased()
            return false
        }
        return true
    }
}














