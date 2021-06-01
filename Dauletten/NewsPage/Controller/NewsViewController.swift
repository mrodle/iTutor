//
//  NewsViewController.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/15/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class NewsViewController: LoaderBaseViewController {
    
//    MARK: - Properties
    private var viewModel = NewsViewModel()
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateList), for: .valueChanged)
        refresh.tintColor = .white
        
        return refresh
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.cellIdentifier())
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.refreshControl = refreshControl
        
        return tableView
    }()
    
//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureViews() {
        setupView()
        removeScrollView()
        bind(to: viewModel)
        self.showLoader()
        self.updateList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.navigationController?.navigationBar.title = ""
        self.navigationController?.navigationBar.isHidden = false
        setNavBarWithLarge(title: "Жаңалықтар")
    }
    
    private func bind(to viewModel: NewsViewModel) {
        viewModel.error.observe(on: self) { [weak self] in
            guard  let `self` = self else { return }
            self.showAlert(type: .error, $0)}
        viewModel.loading.observe(on: self) { loading in
            if (loading) {
                self.showLoader()
            } else {
                self.view.isHidden = false
                self.hideLoader()
            }
        }
        viewModel.newsList.observe(on: self) { _ in
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    

//    MARK: - Setup functions
    private func setupView() -> Void {
        view.backgroundColor = .backColor
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    @objc func updateList() {
        viewModel.page = 1
        viewModel.getNewsList()
    }
}

extension NewsViewController: ProcessViewDelegate {
    func updateUI() {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func endRefreshing() {
        self.refreshControl.endRefreshing()
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.cellIdentifier(), for: indexPath) as! NewsTableViewCell
        if !viewModel.newsList.value.isEmpty {
            cell.configuration(news: viewModel.newsList.value[indexPath.row])
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.newsList.value.count - 1 && viewModel.lastPage > viewModel.page {
            viewModel.page += 1
            viewModel.getNewsList()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsDetailViewController(id: viewModel.newsList.value[indexPath.row].id)
        self.tabBarController!.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

