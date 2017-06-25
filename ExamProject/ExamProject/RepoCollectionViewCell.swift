//
//  RepoCollectionViewCell.swift
//  ExamProject
//
//  Created by M_Sugawara on 2017/06/25.
//  Copyright © 2017年 Sugawar. All rights reserved.
//

import UIKit

class RepoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
