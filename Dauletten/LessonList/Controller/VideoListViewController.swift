//
//  CourseDetailViewController.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/15/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class VideoListViewController: LoaderBaseViewController {

    var toLoginPageClosure = {() -> () in}
    private var expandable = false
    private var course: Category
    lazy var paymentsVC = PaymantInfoViewController(product: course)

    private var viewModel = LessonsViewModel()

    private lazy var navBarView: BackNavBarView = {
        let view = BackNavBarView(title: "", rightButtonImage: #imageLiteral(resourceName: "feather_search"), rightButtonWidth: 30)
        view.goBack = {
            self.navigationController?.popViewController(animated: true)
        }
        view.rightButtonTarget = {
            self.showSearchView()
        }
        
        return view
    }()

    private lazy var searchTextField: InputView = {
        let textField = InputView(inputType: .plainText, icon: #imageLiteral(resourceName: "Group"), placeholder: "Іздеу...")
        textField.backgroundColor = .upperColor
        textField.iconAction = {
            self.hideSearchView()
        }
        textField.isHidden = true
        textField.textField.delegate = self
        
        return textField
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.getSFProBoldFont(on: 20)
        label.text = "Категория бос"
        label.textAlignment = .center
        label.isHidden = true
        
        return label
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateList), for: .valueChanged)
        refresh.tintColor = .white
        
        return refresh
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: VideoTableViewCell.cellIdentifier())
        tableView.register(PopupTableViewCell.self, forCellReuseIdentifier: PopupTableViewCell.cellIdentifier())
        tableView.register(MoreInformationHeaderView.self, forHeaderFooterViewReuseIdentifier: MoreInformationHeaderView.cellIdentifier())
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.refreshControl = refreshControl
        
        return tableView
    }()
    
    private var bottomBuyView = BottomBuyView()
    
    init(course: Category) {
        self.course = course
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func configureViews() {
        setupView()
        seupActions()
        bind(to: viewModel)
        self.showLoader()
        getList()
    }
    
    private func bind(to viewModel: LessonsViewModel) {
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
        viewModel.videoList.observe(on: self) { _ in
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

    private func setupView() -> Void {
        navBarView.titleLabel.text = course.title
        bottomBuyView.isHidden = course.bought
        bottomBuyView.priceLabel.text = "\(course.price) тг"
        bottomBuyView.buyButton.addTarget(self, action: #selector(buyButtonAction), for: .touchUpInside)
        
        view.backgroundColor = .backColor
        scrollView.removeFromSuperview()
        
        addSubview(navBarView)
        navBarView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(AppConstants.statusBarHeight + AppConstants.navBarHeight)
        }
        
        addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(navBarView.snp.bottom).offset(16)
            make.right.left.equalToSuperview()
        }
        
        addSubview(bottomBuyView)
        bottomBuyView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBarView.snp.bottom).offset(12)
            make.right.left.equalToSuperview()
            make.bottom.equalTo(course.bought ? 0 : bottomBuyView.snp.top)
        }
        
        addSubview(searchTextField)
        searchTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(AppConstants.navBarHeight / 2 + AppConstants.statusBarHeight)
            make.height.equalTo(40)
            make.left.equalTo(navBarView.snp.right)
            make.width.equalTo(AppConstants.screenWidth - 65)
        }
    }
    
    private func seupActions() {
        paymentsVC.toLoginPageClosure = {
            self.navigationController?.popToRootViewController(animated: true)
            self.toLoginPageClosure()
        }
    }

    private func showSearchView() -> Void {
        self.searchTextField.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.searchTextField.snp.remakeConstraints { (make) in
                make.centerY.equalTo(AppConstants.navBarHeight / 2 + AppConstants.statusBarHeight)
                make.height.equalTo(40)
                make.left.equalTo(57)
                make.width.equalTo(AppConstants.screenWidth - 65)
            }
            self.view.superview?.layoutIfNeeded()
        }
        self.searchTextField.textField.becomeFirstResponder()
    }

    private func hideSearchView() -> Void {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.3, animations: {
            self.searchTextField.snp.remakeConstraints { (make) in
                make.centerY.equalTo(AppConstants.navBarHeight / 2 + AppConstants.statusBarHeight)
                make.height.equalTo(40)
                make.left.equalTo(self.navBarView.snp.right)
                make.width.equalTo(AppConstants.screenWidth - 65)
            }
            self.view.superview?.layoutIfNeeded()
            
        }) { (Bool) in
            self.searchTextField.isHidden = true
        }
        self.searchTextField.textField.text = ""
        self.updateList()
    }
    
    private func getList(searchText: String = "") -> Void {
        viewModel.getVideoList(courseId: course.id, search: searchText)
    }

    @objc func buyButtonAction() {
 
        paymentsVC.modalPresentationStyle = .overCurrentContext
        paymentsVC.modalTransitionStyle = .crossDissolve

        self.present(paymentsVC, animated: true, completion: nil)
    }
    
    @objc func updateList() -> Void {
        getList(searchText: searchTextField.textField.text!)
    }
}

extension VideoListViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        getList(searchText: searchTextField.textField.text!)
    }
}

extension VideoListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [expandable == false ? 0 : 1, viewModel.videoList.value.count][section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.cellIdentifier(), for: indexPath) as! VideoTableViewCell
            cell.configuration(video: viewModel.videoList.value[indexPath.row], isFree: course.bought)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PopupTableViewCell.cellIdentifier(), for: indexPath) as! PopupTableViewCell
            cell.configure(course: course)
            
            cell.reloadSection = {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MoreInformationHeaderView.cellIdentifier()) as! MoreInformationHeaderView
        header.isOpen = expandable
        header.tintColor = .backColor
        
        header.actionEvent = {[weak self] in
            
            self?.expandable = !self!.expandable
            
            if self?.expandable == true{
                tableView.insertRows(at: [IndexPath.init(row: 0, section: section)], with: .automatic)
            }
            else{
                tableView.deleteRows(at:[IndexPath.init(row: 0, section: section)], with: .fade)
            }
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return 0 }
        
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if course.bought {
            self.navigationController?.pushViewController(LessonDetailViewController(id: viewModel.videoList.value[indexPath.row].id, course: course), animated: true)
        } else {
            paymentsVC.modalPresentationStyle = .overCurrentContext
            paymentsVC.modalTransitionStyle = .crossDissolve
            self.present(paymentsVC, animated: true, completion: nil)

        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}



