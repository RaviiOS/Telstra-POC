//
//  CountryDetailCell.swift
//  Telstra POC
//
//  Created by Ravi Kumar Yaganti on 18/07/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit
import SDWebImage

class CountryDetailCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    private func setupView() {
        self.selectionStyle = .none
        let marginGuide = contentView.layoutMarginsGuide
        
        //imageView
        contentView.addSubview(symbolicImageView)
        symbolicImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolicImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        symbolicImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        symbolicImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        symbolicImageView.centerYAnchor.constraint(equalTo: marginGuide.centerYAnchor).isActive = true
        
        // configure titleLabel
        contentView.addSubview(titleLable)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 70).isActive = true
        titleLable.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLable.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLable.numberOfLines = 0
        
        // configure detailLable
        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 70).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        detailLabel.topAnchor.constraint(equalTo: titleLable.bottomAnchor).isActive = true
        detailLabel.numberOfLines = 0
        detailLabel.textColor = UIColor.lightGray
    }
    
    lazy var symbolicImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 30
        img.clipsToBounds = true
        return img
    }()
    
    lazy var titleLable:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.textColor = .systemGray
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var detailLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Book", size: 14)
        label.textColor =  .lightGray
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    var countryDetails: CountryDetails? {
        didSet {
            guard let countryItem = countryDetails else {return}
            titleLable.text = countryItem.title ?? "- -"
            detailLabel.text = countryItem.description ?? "- - -"
            symbolicImageView.sd_setImage(with: URL(string: countryItem.imageHref ?? ""), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        }
    }
        
}
