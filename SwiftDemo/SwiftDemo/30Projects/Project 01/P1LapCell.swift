//
//  P1LapCell.swift
//  SwiftDemo
//
//  Created by 朱超鹏 on 2018/2/6.
//  Copyright © 2018年 zcp. All rights reserved.
//

import UIKit

class P1LapCell: UITableViewCell {
    
    // MARK: - Property
    lazy var titleLabel: UILabel = {
        var label           = UILabel()
        label.font          = UIFont.systemFont(ofSize: 14.0)
        label.textColor     = UIColor.white
        return label
    }()
    lazy var descLabel: UILabel = {
        var label           = UILabel()
        label.font          = UIFont.systemFont(ofSize: 14.0)
        label.textColor     = UIColor.white
        return label
    }()
    
    // MARK: - life cycle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType      = UITableViewCellAccessoryType.none
        self.selectionStyle     = UITableViewCellSelectionStyle.none
        self.backgroundColor    = UIColor.clear
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.descLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel.frame = CGRect(x: 16, y: 0, width: 100, height: self.height)
        self.descLabel.frame = CGRect(x: self.width - 76, y: 0, width: 60, height: self.height)
    }
    
    // MARK: - public
    func update(desc: String) {
        self.descLabel.text = desc
    }
}
