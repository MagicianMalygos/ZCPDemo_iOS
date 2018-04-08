//
//  ListCell.swift
//  SwiftDemo
//
//  Created by 朱超鹏 on 2018/1/18.
//  Copyright © 2018年 zcp. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    // MARK: - property
    private lazy var containerView: UIView = {
        () -> UIView in
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
    
    // MARK: - Method
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.accessoryType = UITableViewCellAccessoryType.none
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.frame = CGRect(x: 16, y: 8, width: self.frame.size.width - 32, height: self.frame.size.height - 16)
        self.titleLabel.frame = CGRect(x: 16, y: 0, width: self.containerView.frame.size.width - 32, height: self.containerView.frame.size.height)
    }
    
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
