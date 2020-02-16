//
//  BlurImageView.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//
//  A subclass of UIImageView, which lays down as a background
//  with a blur effect and a lower and upper gradient

import Foundation
import UIKit
import SnapKit

class BlurImageView: UIImageView {
    
    // MARK: - Variables
    
    private var topGradient = CAGradientLayer()
    private var bottomGradient = CAGradientLayer()
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBlur()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBlur()
    }
    
    // MARK: - Private Functions
    
    private func setupBlur() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTopGradient() {
        topGradient.removeFromSuperlayer()
        topGradient = CAGradientLayer()
        topGradient.colors = [UIColor.appColor.behance.cgColor, UIColor.clear.cgColor]
        topGradient.locations = [0.0 , 1.0]
        topGradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height / 4)
        self.layer.addSublayer(topGradient)
    }
    
    private func setupBottompGradient() {
        bottomGradient.removeFromSuperlayer()
        bottomGradient = CAGradientLayer()
        bottomGradient.colors = [UIColor.clear.cgColor, UIColor.appColor.behance.cgColor]
        bottomGradient.locations = [0.0 , 1.0]
        let yPosition = self.frame.size.height - self.frame.size.height / 4
        bottomGradient.frame = CGRect(x: 0.0, y: yPosition, width: self.frame.size.width, height: self.frame.size.height / 4)
        self.layer.addSublayer(bottomGradient)
    }
    
    // MARK: - Override Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTopGradient()
        setupBottompGradient()
    }
    
}
