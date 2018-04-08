//
//  P1TimerViewController.swift
//  SwiftDemo
//
//  Created by 朱超鹏 on 2018/1/19.
//  Copyright © 2018年 zcp. All rights reserved.
//

import UIKit

fileprivate let CellIdentify: String = "lapCell"
fileprivate let ButtonSide: CGFloat = 70.0

fileprivate let StartTitle: String = "启动"
fileprivate let StartTitleColor: UIColor = UIColor(0x53DC6A)
fileprivate let StartBGColor: UIColor = UIColor(0x18341F)
fileprivate let StopTitle: String = "停止"
fileprivate let StopTitleColor: UIColor = UIColor(0xE64E42)
fileprivate let StopBGColor: UIColor = UIColor(0x3F1614)

fileprivate let LapTitle: String = "计次"
fileprivate let LapUnableTitleColor: UIColor = UIColor(0x919193)
fileprivate let LapUnableBGColor: UIColor = UIColor(0x141414, 0.4)
fileprivate let LapEnableTitleColor: UIColor = UIColor(0xffffff)
fileprivate let LapEnableBGColor: UIColor = UIColor(0x3d3d3d)
fileprivate let ResetTitle: String = "复位"
fileprivate let ResetTitleColor: UIColor = UIColor(0xffffff)
fileprivate let ResetBGColor: UIColor = UIColor(0x3d3d3d)

/// 计时器状态
///
/// - initial: 初始状态
/// - timing: 计时状态
/// - suspend: 等待状态
enum TimerStatus {
    case initial
    case timing
    case suspend
}

/// Project 1
class P1TimerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, P1CircleButtonDelegate {
    
    // MARK: - Property
    var list: [String] = []
    var timerStatus: TimerStatus = TimerStatus.initial
    var timer: Timer?
    var minute: Int = 0
    var second: Int = 0
    var millisecond: Int = 0
    weak var firstCell: P1LapCell?
    
    /// UI
    lazy var timerLabel: UILabel! = {
        var label           = UILabel()
        label.font          = UIFont.systemFont(ofSize: 70)
        label.textColor     = UIColor.white
        label.text          = "00:00.00"
        return label
    }()
    lazy var startPauseButton: P1CircleButton! = {
        var button                  = P1CircleButton(type: UIButtonType.custom)
        button.titleLabel?.font     = UIFont.systemFont(ofSize: 14.0)
        button.layer.cornerRadius   = ButtonSide / 2
        button.layer.masksToBounds  = true
        button.delegate             = self
        return button
    }()
    lazy var lapResetButton: P1CircleButton! = {
        var button                  = P1CircleButton(type: UIButtonType.custom)
        button.titleLabel?.font     = UIFont.systemFont(ofSize: 14.0)
        button.layer.cornerRadius   = ButtonSide / 2
        button.layer.masksToBounds  = true
        button.delegate             = self
        return button
    }()
    
    lazy var lapsTableView: UITableView! = {
        var tableview               = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableview.backgroundColor   = UIColor.black
        tableview.separatorColor    = UIColor.gray
        tableview.dataSource        = self
        tableview.delegate          = self
        return tableview
    }()
    
    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.edgesForExtendedLayout = UIRectEdge.bottom
        
        self.view.addSubview(self.timerLabel)
        self.view.addSubview(self.lapResetButton)
        self.view.addSubview(self.startPauseButton)
        self.view.addSubview(self.lapsTableView)
        
        self.lapResetButton.isEnabled = false
        self.startPauseButton.update(title: StartTitle, titleColor: StartTitleColor, backgroundColor: StartBGColor)
        self.lapResetButton.update(title: LapTitle, titleColor: LapUnableTitleColor, backgroundColor: LapUnableBGColor)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.timerLabel.frame       = CGRect(x: (self.view.frame.size.width - 290) / 2, y: 0, width: 290, height: self.view.frame.size.height / 2)
        self.lapResetButton.frame   = CGRect(x: 16, y: self.timerLabel.bottom, width: ButtonSide, height: ButtonSide)
        self.startPauseButton.frame = CGRect(x: self.view.width - 16 - ButtonSide, y: self.timerLabel.bottom, width: ButtonSide, height: ButtonSide)
        self.lapsTableView.frame    = CGRect(x: 0, y: self.lapResetButton.bottom + 16, width: self.view.width, height: self.view.height - self.lapResetButton.bottom)
    }
    
    // MARK: - private
    
    func startTiming() {
        self.timer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(timefire), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer!, forMode: RunLoopMode.commonModes)
        
        if self.timerStatus == TimerStatus.initial {
            self.list.append("00:00.00")
            self.lapsTableView.reloadData()
        }
        
        self.startPauseButton.update(title: StopTitle, titleColor: StopTitleColor, backgroundColor: StopBGColor)
        self.lapResetButton.update(title: LapTitle, titleColor: LapEnableTitleColor, backgroundColor: LapEnableBGColor)
        self.timerStatus = TimerStatus.timing
        self.lapResetButton.isEnabled = true
    }
    
    func suspendTiming() {
        self.startPauseButton.update(title: StartTitle, titleColor: StartTitleColor, backgroundColor: StartBGColor)
        self.lapResetButton.update(title: ResetTitle, titleColor: ResetTitleColor, backgroundColor: ResetBGColor)
        self.timerStatus = TimerStatus.suspend
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func resetTiming() {
        self.lapResetButton.update(title: LapTitle, titleColor: LapUnableTitleColor, backgroundColor: LapUnableBGColor)
        self.startPauseButton.update(title: StartTitle, titleColor: StartTitleColor, backgroundColor: StartBGColor)
        self.lapResetButton.isEnabled = false
        self.timer?.invalidate()
        self.timer              = nil
        self.minute             = 0
        self.second             = 0
        self.millisecond        = 0
        self.timerLabel.text    = "00:00.00"
        self.list.removeAll()
        self.lapsTableView.reloadData()
    }
    
    func lapTime() {
        self.list.insert(self.timerLabel.text!, at: 1)
        self.lapsTableView.reloadData()
    }
    
    func timefire() {
        self.millisecond += 3
        if self.millisecond >= 100 {
            self.millisecond -= 100
            self.second += 1
        }
        if self.second >= 60 {
            self.second -= 60
            self.minute += 1
        }
        let time = String(format: "%02d:%02d.%02d", self.minute, self.second, self.millisecond)
        self.timerLabel.text = time
        self.firstCell?.update(desc: time)
    }
    
    // MARK: - P1CircleButtonDelegate
    
    func clickCircleButton(_ button: P1CircleButton) {
        if button === self.startPauseButton {
            if self.timerStatus == .initial {
                self.startTiming()
            } else if self.timerStatus == .timing {
                self.suspendTiming()
            } else if self.timerStatus == .suspend {
                self.startTiming()
            }
        } else if (button === self.lapResetButton) {
            if ((button.titleLabel?.text?.isEqual(to: LapTitle))! && button.isEnabled) {
                self.lapTime()
            } else if (button.titleLabel?.text?.isEqual(to: ResetTitle))! {
                self.resetTiming()
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: CellIdentify)
        if cell == nil {
            cell = P1LapCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: CellIdentify)
        }
        if cell!.isKind(of: P1LapCell.self) {
            let tempCell: P1LapCell = cell as! P1LapCell
            tempCell.titleLabel.text = "计次 \(self.list.count - indexPath.row)"
            tempCell.descLabel.text = self.list[indexPath.row]
            
            if indexPath.row == 0 {
                self.firstCell = tempCell
            }
        }
        return cell!
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.lapsTableView.contentOffset.y > 50 {
            self.firstCell = nil
        }
    }
}
