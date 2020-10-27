//
//  DetailViewController.swift
//  TMDB
//
//  Created by TMLI IT DEV on 26/10/20.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    var viewModel: DetailVM?
    var reviews:[ResultReview] = []
    
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var imageViewCover: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var labelReleased: UILabel!
    @IBOutlet weak var labelRuntime: UILabel!
    @IBOutlet weak var collectionReviews: UICollectionView!
    @IBOutlet weak var indicatorReviews: UIActivityIndicatorView!
    @IBOutlet weak var buttonMoreReviews: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionReviews()
        bindViewModel()
    }
    private func setupCollectionReviews() {
        collectionReviews.register(cellType: ReviewCVC.self)
        collectionReviews.dataSource = self
        collectionReviews.delegate = self
        self.viewModel?.getReviews()
    }
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isOpaque = false
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func bindViewModel() {
        viewModel?.didGetDetailSuccess = { res in
            DispatchQueue.main.async {
                self.labelTitle.text = res.title
                self.labelInfo.text = self.generateInfo(detail: res)
                self.labelOverview.text = res.overview
                if let duration = res.runtime {
                    let seconds = duration * 60
                    let watch = StopWatch(totalSeconds: seconds)
                    if watch.hours > 0 {
                        self.labelRuntime.text = String(watch.hours) + " hrs " + String(watch.minutes) + " min"
                    } else {
                        self.labelRuntime.text = String(watch.minutes) + " min"
                    }
                }
                if let release = res.releaseDate {
                    let year = release.toDate(format: "yyyy-MM-dd").get(.year)
                    self.labelReleased.text = String(year)
                }
                guard let urlPoser = URL(string: "https://image.tmdb.org/t/p/original/\(res.backdropPath)") else {
                    return
                }
                self.imageViewPoster.kf.setImage(with: urlPoser)
                guard let urlCover = URL(string: "https://image.tmdb.org/t/p/original/\(res.posterPath)") else {
                    return
                }
                self.imageViewCover.kf.setImage(with: urlCover)
            }
        }
        
        viewModel?.didGetReviewsSuccess = { res in
            self.reviews = res.results
            if !self.reviews.isEmpty {
                DispatchQueue.main.async {
                    if res.totalPages > 1 {
                        self.buttonMoreReviews.isHidden = false
                    }
                    self.indicatorReviews.isHidden = true
                    self.collectionReviews.isHidden = false
                    self.collectionReviews.reloadData()
                }
            }
            
        }
    }
    
    @IBAction func didTapMoreReview() {
        
    }
    
    @IBAction func didTapTrailer() {
        viewModel?.getVideos()
    }
    private func generateInfo(detail: ResponseDetail) -> String {
        var temp = ""
        if let mainGenre = detail.genres.first?.name {
            temp.append(mainGenre)
            temp.append(" • ")
        }
        if let release = detail.releaseDate {
            let year = release.toDate(format: "yyyy-MM-dd").get(.year)
            temp.append(String(year))
            temp.append(" • ")
        }
        
        if let duration = detail.runtime {
            let seconds = duration * 60
            let watch = StopWatch(totalSeconds: seconds)
            if watch.hours > 0 {
                temp.append(String(watch.hours) + " hrs " + String(watch.minutes) + " min")
            }
        }
        return temp
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ReviewCVC.self, for: indexPath)
        cell.bind(with: reviews[indexPath.row])
        
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 4
        
        return CGSize(width: width, height: width * 0.85)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 4, left: 16, bottom: 4, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
