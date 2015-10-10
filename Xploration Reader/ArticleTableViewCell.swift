//
//  ArticlesTableViewCell.swift
//  Xploration Reader
//
//  Created by Andrea Cerra on 29/09/15.
//  Copyright © 2015 Andrea Cerra. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleSubTitle: UILabel!
    @IBOutlet weak var tagView: ACTagView!
    @IBOutlet weak var articleText: UILabel!
    @IBOutlet weak var tagViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
