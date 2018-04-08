//
//  ProjectManager.swift
//  SwiftDemo
//
//  Created by 朱超鹏 on 2018/1/18.
//  Copyright © 2018年 zcp. All rights reserved.
//

import UIKit

class ProjectManager: NSObject {
    weak var navigationController: UINavigationController?
    var projectList: [String] = []
    
    subscript(i: Int) -> String {
        return projectList[i]
    }
    
    func getProjectSel(index: Int) -> Selector? {
        if index < 0 || index > projectList.count  {
            return nil
        }
        return Selector("project\(index + 1)")
    }
    
    init(_ nav: UINavigationController) {
        self.navigationController = nav
        self.projectList = ["Project 1", "Project 2", "Project 3", "Project 4"]
    }
    
    func project1() {
        let vc = P1TimerViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func project2() {
        
    }
    func project3() {
        
    }
    func project4() {
        
    }
}
