//
//  NewsCollectionViewCell.swift
//  AprolamAlejandroBarreto
//
//  Created by Alejandro Barreto on 11/08/22.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var published_At: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var descriptionNews: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
