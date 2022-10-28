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
            
            image.topAnchor.constraint(equalTo: background.topAnchor, constant: 5),
            image.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 5),
            image.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -5),
            image.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -5),
            
            button.topAnchor.constraint(equalTo: image.topAnchor, constant: 10),
            button.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 10),
            button.heightAnchor.constraint(equalToConstant: 20),
            button.widthAnchor.constraint(equalToConstant: 20)
        ])
        button.layer.cornerRadius = 10
        button.backgroundColor = .gray
        button.alpha = 0.5
        button.setTitle("!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        image.backgroundColor = .cyan
        background.backgroundColor = .blue
        
        background.layer.cornerRadius = 5
    }
}
