//
//  DashboardViewController.swift
//  TMDB
//
//  Created by TMLI IT DEV on 25/10/20.
//

import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: DashboardVM?
    var genres:[Genre] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.bindViewModel()
        title = "TMDB"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.viewModel?.fetchGenres()
        }
    }
    
    private func bindViewModel() {
        viewModel?.didUpdateState = { [weak self] (state, response) in
            guard let list = response else {
                self?.tableView.setStateView(with: .retry)
                return
            }
            self?.genres = list
            self?.tableView.setStateView(with: state)
        }
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(cellType: DashboardTVC.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension DashboardViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: DashboardTVC.self, for: indexPath)
        cell.bind(genre: genres[indexPath.row])
        
        return cell
    }
}

extension DashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didTapToDiscover?(genres[indexPath.row])
    }
}
