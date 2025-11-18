//
//  PostTableViewCell.swift
//  reddit-home-ios
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import UIKit

final class PostTableViewCell: UITableViewCell {

    // MARK: - UI
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = UIColor.systemGray6
        iv.isHidden = true
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()

    private let upvotesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()

    private let commentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()

   
    private var imageHeightConstraint: NSLayoutConstraint?
    private var loadUUID: UUID?


    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func prepareForReuse() {
        super.prepareForReuse()

        // Cancel the pending load
        if let uuid = loadUUID {
            ImageLoader.shared.cancelLoad(uuid)
        }
        loadUUID = nil

        // Reset image
        postImageView.image = nil
        postImageView.isHidden = true
        imageHeightConstraint?.constant = 0
    }


    // MARK: - Setup UI
    private func setupUI() {

        contentView.addSubview(postImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(upvotesLabel)
        contentView.addSubview(commentsLabel)

        postImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        upvotesLabel.translatesAutoresizingMaskIntoConstraints = false
        commentsLabel.translatesAutoresizingMaskIntoConstraints = false

        imageHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 0)
        imageHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            titleLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            upvotesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            upvotesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            commentsLabel.centerYAnchor.constraint(equalTo: upvotesLabel.centerYAnchor),
            commentsLabel.leadingAnchor.constraint(equalTo: upvotesLabel.trailingAnchor, constant: 16),

            contentView.bottomAnchor.constraint(equalTo: upvotesLabel.bottomAnchor, constant: 12)
        ])
    }


    // MARK: - Configure
    func configure(with post: PostModel) {
        titleLabel.text = post.title
        upvotesLabel.text = "⬆️ \(post.upvotes)"
        commentsLabel.text = "💬 \(post.comments)"

        guard let url = post.imageURL else {
            postImageView.isHidden = true
            imageHeightConstraint?.constant = 0
            return
        }

        postImageView.isHidden = false
        postImageView.contentMode = .scaleAspectFit
        postImageView.clipsToBounds = false

        // Calculate image height based on the aspect ratio
        if let width = post.imageWidth, let height = post.imageHeight, width > 0 {
            let aspectRatio = CGFloat(height) / CGFloat(width)
            let cellWidth = UIScreen.main.bounds.width - 24
            imageHeightConstraint?.constant = cellWidth * aspectRatio
        } else {
            // fallback if there is no width/height
            imageHeightConstraint?.constant = 180
        }

        // load the image
        loadUUID = ImageLoader.shared.load(url: url) { [weak self] image in
            guard let self = self else { return }
            self.postImageView.image = image
        }
    }

}
