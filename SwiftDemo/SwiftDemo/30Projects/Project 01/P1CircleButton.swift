//
//  P1CircleButton.swift
//  SwiftDemo
//
//  Created by 朱超鹏 on 2018/1/23.
//  Copyright © 2018年 zcp. All rights reserved.
//

import UIKit

fileprivate let TouchEdge:CGFloat = 50.0


protocol P1CircleButtonDelegate: class {
    func clickCircleButton(_ button: P1CircleButton)
}

class P1CircleButton: UIButton {
    
    // MARK: - Property
    var tempBGColor: UIColor?
    weak var delegate: P1CircleButtonDelegate?
    
    // MARK: - Touch
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view === self {
            // 背景透明
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.4)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first?.location(in: self)
        let size = self.layer.frame.size
        
        if (point?.x)! > -TouchEdge &&
            (point?.x)! < size.width + TouchEdge &&
            (point?.y)! < size.height + TouchEdge &&
            (point?.y)! > -TouchEdge {
            // 背景透明
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.4)
        } else {
            // 背景恢复
            self.backgroundColor = self.tempBGColor
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 背景恢复
        self.backgroundColor = self.tempBGColor
        
        let point = touches.first?.location(in: self)
        let size = self.layer.frame.size
        
        if (point?.x)! > -TouchEdge &&
            (point?.x)! < size.width + TouchEdge &&
            (point?.y)! < size.height + TouchEdge &&
            (point?.y)! > -TouchEdge {
            // 事件响应
            self.delegate?.clickCircleButton(self)
        }
    }
    
    // MARK: - public
    
    /// 更新按钮状态
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - titleColor: 标题颜色
    ///   - backgroundColor: 背景颜色
    func update(title: String?, titleColor: UIColor?, backgroundColor: UIColor?) {
        if let t = title {
            self.setTitle(t, for: UIControlState.normal)
        }
        if let tc = titleColor {
            self.setTitleColor(tc, for: UIControlState.normal)
        }
        if let bgc = backgroundColor {
            self.backgroundColor = bgc
            self.tempBGColor = bgc
        }
    }
}
