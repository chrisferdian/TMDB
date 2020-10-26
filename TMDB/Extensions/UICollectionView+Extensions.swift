//
//  UICollectionView+Extensions.swift
//  TMDB
//
//  Created by TMLI IT DEV on 25/10/20.
//

import UIKit

public extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func register<T: UICollectionViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func register<T: UICollectionReusableView>(reusableViewType: T.Type,
                                                      ofKind kind: String = UICollectionView.elementKindSectionHeader,
                                                      bundle: Bundle? = nil) {
        let className = reusableViewType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }

    func register<T: UICollectionReusableView>(reusableViewTypes: [T.Type],
                                                      ofKind kind: String = UICollectionView.elementKindSectionHeader,
                                                      bundle: Bundle? = nil) {
        reusableViewTypes.forEach { register(reusableViewType: $0, ofKind: kind, bundle: bundle) }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type,
                                                             for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }

    func dequeueReusableView<T: UICollectionReusableView>(with type: T.Type,
                                                                 for indexPath: IndexPath,
                                                                 ofKind kind: String = UICollectionView.elementKindSectionHeader) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.className, for: indexPath) as! T
    }
    internal func setStateView(with state: ListProcessingState, _ completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            switch state {
            case .success:
                self.backgroundView = nil
                return
            case .empty:
                guard let stateView = Bundle.main.loadNibNamed("EmptyStateView", owner: self, options: nil)?.first as? EmptyStateView else { return }
                self.backgroundView = stateView
            case .retry:
                guard let stateView = Bundle.main.loadNibNamed("RetryStateView", owner: self, options: nil)?.first as? RetryStateView else { return }
                self.backgroundView = stateView
                stateView.onRetry = completion
                return
            default:
                guard let stateView = Bundle.main.loadNibNamed("LoadingStateView", owner: self, options: nil)?.first as? LoadingStateView else { return }
                self.backgroundView = stateView
            }
        }
    }
}
