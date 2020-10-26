//
//  DashboardTVC.swift
//  TMDB
//
//  Created by TMLI IT DEV on 25/10/20.
//

import UIKit

class DashboardTVC: UITableViewCell {

    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var genre: Genre?
    var discovers:[DiscoverResult] = [] {
        didSet {
            if !self.discovers.isEmpty {
                DispatchQueue.main.async {
                    print(self.discovers.count)
                    self.collectionView.isHidden = false
                    self.indicator.isHidden = true
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    @Request<DiscoverGenres>(url: "/discover/movie")
    var discoverRequest
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bind(genre: Genre) {
        setupCollectionView()

        labelGenre.text = genre.name
        self._discoverRequest.setParameters(body: ["with_genres": String(genre.id)])
        
        self.discoverRequest { response in
            switch response {
            case .success(let movies):
                self.discovers = movies.results
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(cellType: DiscoverCVC.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension DashboardTVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discovers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: DiscoverCVC.self, for: indexPath)
        cell.backgroundColor = .orange
        return cell
    }
}

extension DashboardTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: collectionView.frame.height)
    }
}
