//
//  RocketsViewController.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

import SwiftUI
import Combine

struct RocketsViewControllerWrapper: UIViewControllerRepresentable {
    let viewModel: RocketsViewModel

    func makeUIViewController(context: Context) -> RocketsViewController {
        RocketsViewController(viewModel: viewModel)
    }

    func updateUIViewController(_ uiViewController: RocketsViewController, context: Context) {}
}

final class RocketsViewController: UIViewController {
    private let viewModel: RocketsViewModel
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: RocketsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()

        Task {
            await viewModel.fetchRockets()
        }
    }

    private func setupViews() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.register(RocketCell.self, forCellReuseIdentifier: "RocketCell")

        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }

    private func bindViewModel() {
        viewModel.$rocketsStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                guard let self else { return }
                switch status {
                case .loading:
                    activityIndicator.startAnimating()
                    tableView.isHidden = true
                case .fetched:
                    activityIndicator.stopAnimating()
                    tableView.isHidden = false
                    tableView.reloadData()
                case .error(let message):
                    activityIndicator.stopAnimating()
                    tableView.isHidden = true
                    showErrorAlert(message)
                }
            }
            .store(in: &cancellables)
    }

    private func showErrorAlert(_ message: String) {
        let alert = UIAlertController(
            title: NSLocalizedString("error", comment: ""),
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default))
        present(alert, animated: true)
    }
}

extension RocketsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if case let .fetched(rockets) = viewModel.rocketsStatus {
            return rockets.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard case let .fetched(rockets) = viewModel.rocketsStatus else {
            return UITableViewCell()
        }
        let rocket = rockets[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "RocketCell",
            for: indexPath
        ) as? RocketCell else {
            return UITableViewCell()
        }
        cell.configure(rocket)
        return cell
    }
}
