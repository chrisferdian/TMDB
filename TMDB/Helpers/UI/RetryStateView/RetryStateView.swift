//
//  RetryStateView.swift
//  TMDB
//
//  Created by TMLI IT DEV on 25/10/20.
//

import UIKit

class RetryStateView: UIView {
    var onRetry: (() -> Void)?
    
    @IBAction func retryTapped() {
        self.onRetry?()
    }
}
