//
//  String+Utils.swift
//  SwiftDemo
//
//  Created by 朱超鹏 on 2018/1/19.
//  Copyright © 2018年 zcp. All rights reserved.
//

import UIKit

extension String {
    func isEqual(to: String) -> Bool {
        return self.caseInsensitiveCompare(to) == ComparisonResult.orderedSame
    }
}
