//
//  HomeViewController+UITableExtension.swift
//  reddit-home-ios
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//


import UIKit
import SwiftUI

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "PostCell",
            for: indexPath
        ) as! PostTableViewCell

        let post = viewModel.posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        let post = viewModel.posts[indexPath.row]
        let details = PostDetailsView(post: post)
        let hosting = UIHostingController(rootView: details)
        navigationController?.pushViewController(hosting, animated: true)
    }
}
