//
//  MyCoursesViewController.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/16/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class MyCoursesViewController: LoaderBaseViewController {

    private var viewModel = MyCoursesViewModel()
    private var tableView = UITableView()
    private var refreshControl = UIRefreshControl()
        

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureViews() {
        setupViews()
        removeScrollView()
        bind(to: viewModel)
        self.showLoader()
        updateList()
    }
    
    private func bind(to viewModel: MyCoursesViewModel) {
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
        viewModel.categotyList.observe(on: self) { _ in
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        setNavBarWithLarge(title: "Менің сабақтарым", isLargeTitle: false)
    }
    
    @objc func updateList() {
        viewModel.page = 1
        viewModel.getCategoryList(page: viewModel.page)
    }
}

extension MyCoursesViewController {
    private func setupViews() {
        addSubviews()
        addConstraints()
        stylizeViews()
    }
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func addConstraints() {
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func stylizeViews() {
        view.backgroundColor = .backColor
                
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CoursesTableViewCell.self, forCellReuseIdentifier: CoursesTableViewCell.cellIdentifier())
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(updateList), for: .valueChanged)
        refreshControl.tintColor = .white
    }
    
}

extension MyCoursesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categotyList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoursesTableViewCell.cellIdentifier(), for: indexPath) as! CoursesTableViewCell
        if !viewModel.categotyList.value.isEmpty {
            cell.configuration(category: viewModel.categotyList.value[indexPath.item], index: indexPath.row, isMy: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = VideoListViewController(course: viewModel.categotyList.value[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
