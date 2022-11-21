//
//  Cell.swift
//  Test_task
//
//  Created by Артем Томило on 1.11.22.
//

import UIKit

class Cell: UICollectionViewCell {
    
    private let background: UIView
     let label: UILabel
    
    override init(frame: CGRect) {
        self.background = UIView()
        self.label = UILabel()
        
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        background.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(background)
        background.addSubview(label)
        
        NSLayoutConstraint.activate([
            background.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            background.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            label.heightAnchor.constraint(equalTo: background.heightAnchor),
            label.widthAnchor.constraint(equalTo: background.widthAnchor),
            ])
        
        label.backgroundColor = .systemGray5
        background.backgroundColor = .clear
    }
}
