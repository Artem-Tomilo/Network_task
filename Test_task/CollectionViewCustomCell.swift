//
//  CollectionViewCustomCell.swift
//  Test_task
//
//  Created by Артем Томило on 27.10.22.
//

import UIKit

class CollectionViewCustomCell: UICollectionViewCell {
    
    private let background: UIView
    private let image: UIImageView
    private let button: UIButton
    private var blurEffectView = UIVisualEffectView()
    
    override init(frame: CGRect) {
        self.background = UIView()
        self.image = UIImageView()
        self.button = UIButton()
        
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        background.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(background)
        background.addSubview(image)
        image.addSubview(button)
        
        NSLayoutConstraint.activate([
            background.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            background.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            image.heightAnchor.constraint(equalTo: background.heightAnchor),
            image.widthAnchor.constraint(equalTo: background.widthAnchor),
            
            button.topAnchor.constraint(equalTo: image.topAnchor, constant: 10),
            button.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 10),
            button.heightAnchor.constraint(equalToConstant: 20),
            button.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray5
        button.alpha = 0.5
        button.setTitle("!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        image.backgroundColor = .systemGray5
        background.backgroundColor = .clear
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        
        addBlurEffect()
    }
    
     func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = image.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        image.addSubview(blurEffectView)
    }
    
    func showImage() {
        blurEffectView.effect = .none
    }
    
    func bind(data: Data) {
        image.image = UIImage(data: data)
    }
}
