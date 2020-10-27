//
//  DiscoverViewController.swift
//  TMDB
//
//  Created by TMLI IT DEV on 26/10/20.
//

import UIKit

class DiscoverViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: DiscoverVM?
    var discovers:[DiscoverResult] = [] {
        didSet {
            if !self.discovers.isEmpty {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.setStateView(with: .loading)
        setupCollectionView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        title = viewModel?.genre?.name
        viewModel?.didUpdateState = { [weak self] (state, response) in
            guard let discoversResponse = response else { return }
            self?.discovers.append(contentsOf: discoversResponse)
            self?.collectionView.setStateView(with: .success)
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(cellType: DiscoverCVC.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discovers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: DiscoverCVC.self, for: indexPath)
        cell.bind(with: discovers[indexPath.row])
        cell.applyShadow(apply: true)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 24
        
        return CGSize(width: width, height: width * 0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 4, left: 16, bottom: 16, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         if (indexPath.row == discovers.count - 1 ) { //it's your last cell
           //Load more data & reload your collection view
            viewModel?.fetchDiscovers()
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.didTapToDetail?(discovers[indexPath.row])
    }
}

