//
//  SoundSliderView.swift
//  Santo
//
//  Created by Eldor Makkambayev on 11/11/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit

class SoundSliderView: UIView {

    //    MARK: - Properties
//    lazy var mixButton: UIButton = {
//        let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "Fill 117"), for: .normal)
//
//        return button
//    }()
//    lazy var repeatButton: UIButton = {
//        let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "Fill 116"), for: .normal)
//
//        return button
//    }()
    lazy var sliderView: UISlider = {
        let slider = UISlider()// UIProgressView(progressViewStyle: .default)
        let circleImage = ViewMaker.shared.makeCircleWith(size: CGSize(width: 16, height: 16),
                                         backgroundColor: .white)
        
        
        slider.maximumTrackTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
        slider.maximumValue = 100
        slider.value = 0
        slider.thumbTintColor = .white
        slider.setThumbImage(circleImage, for: .normal)
        slider.setThumbImage(circleImage, for: .highlighted)
        slider.layer.cornerRadius = 3
        slider.layer.masksToBounds = true
        slider.minimumTrackTintColor = .white
        
        return slider
    }()

    lazy var currentTime: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.getSFProRegularFont(on: 12)
        label.text = "00:00"
        
        return label
    }()

    lazy var fullTime: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.getSFProRegularFont(on: 12)
        label.text = "00:00"
        
        return label
    }()
    //    MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupActions()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    MARK: - Lifecycle
    
    //    MARK: - Setup functions
    
    private func setupView() -> Void {
        addSubview(sliderView)
        sliderView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(30)
        }
        addSubview(currentTime)
        currentTime.snp.makeConstraints { (make) in
            make.bottom.left.equalToSuperview()
            make.top.equalTo(sliderView.snp.bottom)
        }
        addSubview(fullTime)
        fullTime.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview()
            make.top.equalTo(sliderView.snp.bottom)
        }
    }
    
    private func setupActions() -> Void {
    }
    
    //    MARK: - Simple functions
    
    
    
    //    MARK: - Objc functions
    
    @objc func buttonAction(sender: UIButton) -> Void {
    }
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */

}
