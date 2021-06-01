//
//  CoursesViewController.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/13/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class CoursesViewController: LoaderBaseViewController {

    
    private var updateIndex = 3
    private var viewModel = CoursesViewModel()
    static var reloadData: Bool = false
    private var isFree = 1 {
        didSet {
            viewModel.isFree = self.isFree
            updateList()
        }
    }

    private var tableView = UITableView()
    private var refreshControl = UIRefreshControl()
    private var emptyLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        label.font = UIFont.getSFProBoldFont(on: 14)
        label.text = "Категория бос"
        label.textAlignment = .center
        label.isHidden = true
        
        return label
    }()


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
        checkVersion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadActiveSession()
        tableView.setContentOffset(.zero, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .backColor
        self.navigationController?.navigationBar.backgroundColor = .backColor
        setNavBarWithLarge(title: "Барлық сабақтар")
    }
    
    private func bind(to viewModel: CoursesViewModel) {
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

    private func reloadActiveSession() -> Void {
        if CoursesViewController.reloadData && UserManager.getCurrentUser() == nil {
            updateList()
        } else if !CoursesViewController.reloadData && UserManager.getCurrentUser() != nil{
            updateList()
        }
        CoursesViewController.reloadData = UserManager.getCurrentUser() != nil
    }

    
    private func checkVersion() -> Void {
        ParseManager.shared.getRequest(url: AppConstants.API.checkVersion, success: { (result: VersionResponse) in
            if self.updateIndex != result.ios {
                self.showAlertWithAction(title: "Қосымша App Store-да жаңартылды.", message: "Жаңарту керек пе?") {
                    guard let url = URL(string: "https://apps.apple.com/kz/app/dauletten/id1488095059") else { return }
                    UIApplication.shared.open(url)
                    
                }
            }
        }) { (error) in
        }
    }

    @objc func updateList() {
        viewModel.page = 1
        viewModel.getCategoryList()
    }

}

extension CoursesViewController {
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
        CoursesViewController.reloadData = UserManager.getCurrentUser() != nil

        
        view.backgroundColor = .backColor
                
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CoursesTableViewCell.self, forCellReuseIdentifier: CoursesTableViewCell.cellIdentifier())
        tableView.register(SegmentHeaderView.self, forHeaderFooterViewReuseIdentifier: "headerViewId")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(updateList), for: .valueChanged)
        refreshControl.tintColor = .white
    }
}

extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categotyList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoursesTableViewCell.cellIdentifier(), for: indexPath) as! CoursesTableViewCell
        if !viewModel.categotyList.value.isEmpty {
            cell.configuration(category: viewModel.categotyList.value[indexPath.row], index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.categotyList.value.count - 1 && viewModel.lastPage > viewModel.page {
            viewModel.page += 1
            viewModel.getCategoryList()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = VideoListViewController(course: viewModel.categotyList.value[indexPath.row])
        vc.toLoginPageClosure = {
            self.tabBarController?.selectedIndex = 3
        }
        self.tabBarController!.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerViewId") as! SegmentHeaderView
        header.segmentView.firstButtonTarget = {
            if self.isFree != 1 {
                self.isFree = 1
            }
        }
        
        header.segmentView.secondButtonTarget = {
            if self.isFree != 2 {
                self.isFree = 2
            }
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
