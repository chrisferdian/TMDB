//
//  DashboardTVC.swift
//  TMDB
//
//  Created by TMLI IT DEV on 25/10/20.
//

import UIKit

class DashboardTVC: UITableViewCell {

    @IBOutlet weak var labelGenre: UILabel!
    var genre: Genre?
    
    @Request<DiscoverGenres>(url: "/discover/movie")
    var discoverRequest
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bind(genre: Genre) {
        labelGenre.text = genre.name        
    }
}
