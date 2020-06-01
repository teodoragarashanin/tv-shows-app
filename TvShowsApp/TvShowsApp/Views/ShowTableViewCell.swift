//
//  ShowTableViewCell.swift
//  TvShowsApp
//
//  Created by MacBook on 01/06/2020.
//  Copyright © 2020 Teodora Garasanin. All rights reserved.
//

import UIKit
import SDWebImage

class ShowTableViewCell: UITableViewCell {

    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    let imagePlaceholder = "img-placeholder-user2.png"
    
    var show: Show? {
        didSet {
            let imageURL = show?.imageUrl ?? imagePlaceholder
            showImageView.sd_setImage(with: URL(string: "\(Constants.BASE_URL)\(imageURL)"), placeholderImage: UIImage(named: imagePlaceholder))
            titleLabel.text = show?.title ?? "TV SHOW"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
