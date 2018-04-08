//
//  UIView+MGEasyFrame.swift
//  SwiftDemo
//
//  Created by 朱超鹏 on 2018/1/19.
//  Copyright © 2018年 zcp. All rights reserved.
//

import UIKit

private var sizeKey: Void?
private var widthKey: Void?
private var heightKey: Void?
private var originKey: Void?

extension UIView {
    
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    var width: CGFloat {
        get {
            return self.size.width
        }
        set {
            var size = self.size
            size.width = newValue
            self.size = size
        }
    }
    var height: CGFloat {
        get {
            return self.size.height
        }
        set {
            var size = self.size;
            size.height = newValue
            self.size = size
        }
    }
    var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    var x: CGFloat {
        get {
            return self.origin.x
        }
        set {
            var origin = self.origin
            origin.x = newValue
            self.origin = origin
        }
    }
    var y: CGFloat {
        get {
            return self.origin.y
        }
        set {
            var origin = self.origin
            origin.y = newValue
            self.origin = origin
        }
    }
    var left: CGFloat {
        get {
            return self.origin.x
        }
        set {
            var origin = self.origin
            origin.x = newValue
            self.origin = origin
        }
    }
    var top: CGFloat {
        get {
            return self.origin.y
        }
        set {
            var origin = self.origin
            origin.y = newValue
            self.origin = origin
        }
    }
    var bottom: CGFloat {
        get {
            return self.origin.y + self.size.height
        }
        set {
            var origin = self.origin
            origin.y = newValue - self.height
            self.origin = origin
        }
    }
    var right: CGFloat {
        get {
            return self.origin.x + self.size.width
        }
        set {
            var origin = self.origin
            origin.x = newValue - self.width
            self.origin = origin
        }
    }
    var topLeft: CGPoint {
        get {
            return CGPoint(x: self.frame.minX, y: self.frame.minY)
        }
        set {
            self.origin = topLeft
        }
    }
    var topRight: CGPoint {
        get {
            return CGPoint(x: self.frame.maxX, y: self.frame.minY)
        }
        set {
            var origin = self.origin
            origin.x = newValue.x - self.width
            origin.y = newValue.y
            self.origin = origin
        }
    }
    var bottomLeft: CGPoint {
        get {
            return CGPoint(x: self.frame.minX, y: self.frame.maxY)
        }
        set {
            var origin = self.origin
            origin.x = newValue.x
            origin.y = newValue.y - self.height
            self.origin = origin
        }
    }
    var bottomRight: CGPoint {
        get {
            return CGPoint(x: self.frame.maxX, y: self.frame.maxY)
        }
        set {
            var origin = self.origin
            origin.x = newValue.x - self.width
            origin.y = newValue.y - self.height
            self.origin = origin
        }
    }
}
