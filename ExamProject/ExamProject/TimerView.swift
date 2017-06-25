//
//  TimerView.swift
//  ExamProject
//
//  Created by M_Sugawara on 2017/06/24.
//  Copyright © 2017年 Sugawar. All rights reserved.
//

import Foundation
import SnapKit

class ClockView: UIView {
    
    let timeLabel: UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }
    
    private func setupViews() {
        timeLabel.textColor = UIColor.white
        timeLabel.font = UIFont.appleSDGothicNeo(type: .bold, size: 28.0)
        timeLabel.textAlignment = .center
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}
