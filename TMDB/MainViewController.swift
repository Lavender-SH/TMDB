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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
        
    }
    func loadData() {
        TrendAPICallRequest { [weak self] items in
                    guard let weakSelf = self, let items = items else { return }
                    weakSelf.trendingItems = items
                    weakSelf.tableView.reloadData()
            print(#function)
            print("==1==", weakSelf.trendingItems)
                }
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
                
                return cell
                
            case .tv:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TVCell", for: indexPath) as! TVTableViewCell
                
                return cell
                
            case .person:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonTableViewCell
                
                return cell
            }
        }
    }
    

