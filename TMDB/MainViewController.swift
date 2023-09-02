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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
        setupSearchBar()
        
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
}
    
    
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return trendingItems.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let item = trendingItems[indexPath.row]
            
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
    

