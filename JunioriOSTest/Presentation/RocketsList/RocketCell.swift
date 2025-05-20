//
//  RocketCell.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

import UIKit

final class RocketCell: UITableViewCell {
    private let nameLabel = UILabel()
    private let infoLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }

    private func setupUI() {
        nameLabel.font = .boldSystemFont(ofSize: 18)
        infoLabel.font = .systemFont(ofSize: 14)
        infoLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [nameLabel, infoLabel])
        stack.axis = .vertical
        stack.spacing = 4

        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(_ rocket: Rocket) {
        let viewItem = RocketViewItem(rocket: rocket)

        nameLabel.text = viewItem.name
        infoLabel.text = """
        First flight: \(viewItem.firstFlight)
        Success rate: \(viewItem.successRate)
        Height: \(viewItem.height)
        Diameter: \(viewItem.diameter)
        Mass: \(viewItem.mass)
        """
    }
}
