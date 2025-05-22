//
//  LaunchesListViewModel.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

import SwiftUI

enum LaunchesStatus: Equatable {
    case loading, fetched([Launch]), error(String)
}

enum ImageStatus: Equatable {
    case loading, fetched, error, none
}

@Observable final class LaunchesListViewModel {
    let rocket: Rocket
    private let launchUseCase: LaunchUseCase
    private let imageUseCase: ImageUseCase

    var launchesStatus: LaunchesStatus?
    var launchesImages: [String: ImageStatus?] = [:]
    let imageCache = NSCache<NSString, UIImage>()
    var isNextBatchLoading = false

    init(
        rocket: Rocket,
        launchUseCase: LaunchUseCase,
        imageUseCase: ImageUseCase
    ) {
        self.rocket = rocket
        self.launchUseCase = launchUseCase
        self.imageUseCase = imageUseCase
        self.imageCache.countLimit = 10
    }

    @MainActor
    func fetchLaunches() async {
        guard launchesStatus != .loading && !isNextBatchLoading else { return }

        do {
            var page = 1
            var launchesCount = 0

            if case let .fetched(launches) = launchesStatus {
                isNextBatchLoading = true
                page = Int(ceil(Double(launches.count / 5))) + 1
                launchesCount = launches.count
            } else {
                launchesStatus = .loading
            }

            let launches = try await launchUseCase.execute(
                for: rocket.id,
                page: page,
                fetchOffset: launchesCount
            )

            if case let .fetched(existingLaunches) = launchesStatus {
                launchesStatus = .fetched(existingLaunches + launches)
                isNextBatchLoading = false
            } else {
                launchesStatus = .fetched(launches)
            }

            for launch in launches {
                await fetchImage(for: launch)
            }
        } catch {
            launchesStatus = .error(error.localizedDescription)
        }
    }

    @MainActor
    func fetchImage(for launch: Launch) async {
        if launch.imageURL == nil {
            launchesImages[launch.id] = ImageStatus.none
            return
        }

        if imageCache.object(forKey: launch.id as NSString) != nil {
            launchesImages[launch.id] = .fetched
            return
        }

        guard launchesImages[launch.id] != .loading else { return }
        launchesImages[launch.id] = .loading

        do {
            guard let image = try await imageUseCase.execute(launch) else {
                throw URLError(.badServerResponse)
            }
            imageCache.setObject(image, forKey: launch.id as NSString)
            launchesImages[launch.id] = .fetched
        } catch {
            launchesImages[launch.id] = .error
        }
    }

    func formateDate(string: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = isoFormatter.date(from: string) else { return "" }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        outputFormatter.timeZone = TimeZone.current
        outputFormatter.locale = Locale.current

        return outputFormatter.string(from: date)
    }
}
