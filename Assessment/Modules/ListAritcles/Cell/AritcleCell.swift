//
//  AritcleCell.swift
//  Assessment
//
//  Created by Heema Boss on 5/26/20.
//  Copyright © 2020 Ibraheem. All rights reserved.
//

import UIKit
import Kingfisher

class AritcleCell: UITableViewCell {
    //MARK:- Outlet
    @IBOutlet weak var imageAritcle: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLable: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func populate(aritcle: ResultAritclesEntity?){
        nameLabel.text = aritcle?.byline
        titleLabel.text = aritcle?.abstract
        detailsLable.text = aritcle?.title
        dateLabel.text = aritcle?.publishedDate
        if let url = aritcle?.media.first??.mediaMetadata.first??.url {
            imageAritcle.layer.cornerRadius = imageAritcle.layer.frame.height / 2
            imageAritcle.clipsToBounds = true
            imageAritcle.kf.setImage(with: URL(string: url))
        }
        
    }
}
