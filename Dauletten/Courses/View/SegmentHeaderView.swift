//
//  SegmentHeaderView.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 04.09.2020.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class SegmentHeaderView: UITableViewHeaderFooterView {
    
    var segmentView = SegmentView(["Тегін", "Ақылы"])

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        tintColor = .backColor
        backgroundColor = .backColor
        
        addSubview(segmentView)
        segmentView.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(8)
            make.bottom.equalTo(-8)
        }
    }
    
}
