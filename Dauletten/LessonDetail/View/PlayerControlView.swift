//
//  PlayerControlView.swift
//  VideoLessons
//
//  Created by Eldor Makkambayev on 3/26/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class PlayerControlView: UIView {
    
    //    MARK: - Properties
    lazy var playBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        
        return view
    }()
    
    lazy var playView: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "Vector-1"))
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    lazy var previousButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Vector-7"), for: .normal)
        
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Vector-10"), for: .normal)
        
        return button
    }()
    
    //    MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Setup function
    
    private func setupView() -> Void {
        
        addSubview(playBackView)
        playBackView.snp.makeConstraints { (make) in
            make.height.width.equalTo(50)
            make.top.centerX.bottom.equalToSuperview()
            
        }
        
        playBackView.addSubview(playView)
        playView.snp.makeConstraints { (make) in
            make.height.equalTo(18)
            make.width.equalTo(15)
            make.center.equalToSuperview()
        }

        playBackView.addSubview(playButton)
        playButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        addSubview(previousButton)
        previousButton.snp.makeConstraints { (make) in
            make.right.equalTo(playBackView.snp.left).offset(-34)
            make.centerY.equalTo(playBackView)
            make.height.width.equalTo(25)
        }
        
        addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.left.equalTo(playBackView.snp.right).offset(34)
            make.centerY.equalTo(playBackView)
            make.height.width.equalTo(25)
        }

    }
    
//    MARK: - Simple functions
    
    func previousButton(isActive: Bool) -> Void {
        self.previousButton.alpha = isActive ? 1 : 0.5
        self.previousButton.isUserInteractionEnabled = isActive
    }
    
    func nextButton(isActive: Bool) -> Void {
        self.nextButton.alpha = isActive ? 1 : 0.5
        self.nextButton.isUserInteractionEnabled = isActive
    }

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
