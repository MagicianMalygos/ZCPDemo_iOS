//
//  ListViewController.swift
//  SwiftDemo
//
//  Created by 朱超鹏 on 2018/1/18.
//  Copyright © 2018年 zcp. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let cellIdentify = "cell"
    private var tableView: UITableView?
    private lazy var projectManager: ProjectManager = {
        return ProjectManager(self.navigationController!)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        self.tableView?.backgroundColor = UIColor(red: 200.0/255, green: 200.0/255, blue: 220.0/255, alpha: 1)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(self.tableView!)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableView?.frame = self.view.bounds
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projectManager.projectList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: ListCell? = tableView.dequeueReusableCell(withIdentifier: self.cellIdentify) as? ListCell
        if cell == nil {
            cell = ListCell(style: UITableViewCellStyle.default, reuseIdentifier: self.cellIdentify)
            cell?.setTitle(title: self.projectManager[indexPath.row])
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 + 16
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sel: Selector? = self.projectManager.getProjectSel(index: indexPath.row)
        if sel != nil {
            self.projectManager.perform(sel)
        }
    }
}
