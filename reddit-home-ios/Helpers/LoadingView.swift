//
//  LoadingView.swift
//  reddit-home-ios
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import UIKit

class LoadingView: UIView {

    private let spinner: UIActivityIndicatorView = {
        let sp = UIActivityIndicatorView(style: .large)
        sp.hidesWhenStopped = true
        return sp
    }()

    private let messageLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Loading..."
        lbl.textAlignment = .center
        lbl.textColor = .secondaryLabel
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupUI() {
        addSubview(spinner)
        addSubview(messageLabel)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),

            messageLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 12),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        spinner.startAnimating()
    }
}
