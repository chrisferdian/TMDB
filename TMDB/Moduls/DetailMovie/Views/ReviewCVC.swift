//
//  ReviewCVC.swift
//  TMDB
//
//  Created by TMLI IT DEV on 27/10/20.
//

import UIKit

class ReviewCVC: UICollectionViewCell {

    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(with review: ResultReview) {
        self.labelAuthor.text = review.author
        self.labelContent.text = review.content
    }
}
