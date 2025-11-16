//
//  HomeViewController.swift
//  reddit-home-ios
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .plain)
    private let refreshControl = UIRefreshControl()

    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.isHidden = true
        return label
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemRed
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Reddit Home"

        setupTableView()
        setupLayout()
        bindViewModel()

        viewModel.fetchPosts()
    }

    // MARK: - Setup UI
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")

        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(onPullToRefresh), for: .valueChanged)

        tableView.isHidden = true

        view.addSubview(tableView)
        view.addSubview(loadingLabel)
        view.addSubview(errorLabel)
    }

    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    // MARK: - ViewModel binding
    private func bindViewModel() {
        viewModel.onStateChange = { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .idle:
                break

            case .loading:
                self.tableView.isHidden = true
                self.loadingLabel.isHidden = false
                self.errorLabel.isHidden = true

            case .loaded:
                self.tableView.isHidden = false
                self.loadingLabel.isHidden = true
                self.errorLabel.isHidden = true
                self.refreshControl.endRefreshing()

            case .error(let msg):
                self.tableView.isHidden = true
                self.loadingLabel.isHidden = true
                self.errorLabel.isHidden = false
                self.errorLabel.text = msg
                self.refreshControl.endRefreshing()
            }
        }

        viewModel.onPostsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }


    // MARK: - Actions
    @objc private func onPullToRefresh() {
        viewModel.fetchPosts()
    }
}
