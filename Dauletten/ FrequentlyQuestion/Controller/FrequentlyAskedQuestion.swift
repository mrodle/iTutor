//
//  FrequentlyAskedQuestion.swift
//  VideoHosting
//
//  Created by Eldor Makkambayev on 12/23/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit
class FrequentlyAskedQuestion: LoaderBaseViewController {
    
    //    MARK: - Properties
    var expandable = [Bool]()
    var questionList = [Question]() {
        didSet {
            for _ in questionList {
                expandable.append(false)
            }
            tableView.reloadData()
        }
    }

    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .white
        refresh.addTarget(self, action: #selector(updateList), for: .valueChanged)
        return refresh
    }()
        
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white.withAlphaComponent(0.6)
        label.font = UIFont.getSFProBoldFont(on: 14)
        label.text = "Категория бос"
        label.textAlignment = .center
        label.isHidden = true
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .clear
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.register(QuestionHeaderView.self, forHeaderFooterViewReuseIdentifier: "headerViewId")
        tableview.register(QuestionTableViewCell.self, forCellReuseIdentifier: "questionCell")
        tableview.refreshControl = refreshControl
        
        return tableview
    }()
    
    //    MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureViews() {
        self.removeScrollView()
        self.view.backgroundColor = .backColor
        self.setupView()
        self.showLoader()
        self.getQuestions()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavBarWithLarge(title: "Сұрақтарға жауап")
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: - Setup Functions
    
    private func setupView() -> Void {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.right.bottom.equalToSuperview()
        }
        tableView.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.left.right.equalTo(view)
        }
    }
    
    //    MARK: - Parse functions
    
    private func getQuestions() -> Void {
        ParseManager.shared.getRequest(url: AppConstants.API.getQuestionList, success: { (result: [Question]) in
            self.expandable.removeAll()
            self.questionList = result
            self.emptyLabel.isHidden = !self.questionList.isEmpty
            self.hideLoader()
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }) { (error) in
            self.refreshControl.endRefreshing()
            self.showErrorMessage(error)
        }
    }
    
    @objc func updateList() {
        getQuestions()
    }
    
}

// MARK: - TableView
extension FrequentlyAskedQuestion: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return expandable.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expandable[section] == false ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as! QuestionTableViewCell
        cell.subtitleLabel.text = questionList[indexPath.section].answer
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerViewId") as! QuestionHeaderView
        
        header.titleLabel.text = "\(section+1)) \(questionList[section].question ?? "")"
        
        header.actionEvent = {[weak self] in
            
            self?.expandable[section] = !self!.expandable[section]
            
            if self?.expandable[section] == true{
                tableView.insertRows(at: [IndexPath.init(row: 0, section: section)], with: .automatic)
            }
            else{
                tableView.deleteRows(at:[IndexPath.init(row: 0, section: section)], with: .fade)
            }
        }
        
        return header
    }
}
