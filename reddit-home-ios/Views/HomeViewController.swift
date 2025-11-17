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

    private let loadingView = LoadingView()
    private let errorView = ErrorView()

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
        view.addSubview(loadingView)
        view.addSubview(errorView)
    }

    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        errorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
                self.loadingView.isHidden = false
                self.errorView.isHidden = true

            case .loaded:
                self.tableView.isHidden = false
                self.loadingView.isHidden = true
                self.errorView.isHidden = true
                self.refreshControl.endRefreshing()

            case .error(let msg):
                self.tableView.isHidden = true
                self.loadingView.isHidden = true
                self.errorView.isHidden = false
                self.errorView.setErrorMessage(msg)
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
