//
//  LaunchesListView.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

import SwiftUI

struct LaunchesListView: View {
    @State var viewModel: LaunchesListViewModel

    private struct LinkUrl: Identifiable { // Напрямую передать url в safariView не работает корректно
        let id = UUID()
        let url: URL
    }
    @State private var selectedLink: LinkUrl?

    var body: some View {
        VStack {
            switch viewModel.launchesStatus {
            case .loading:
                ProgressView()
            case .fetched(let launches):
                if launches.isEmpty {
                    Text(LocalizedStringKey("noLaunches"))
                        .padding(.horizontal)
                        .foregroundStyle(.secondary)
                } else {
                    List(launches, id: \.self) { launch in
                        VStack(alignment: .leading, spacing: 8) {
                            ImageBlock(viewModel: viewModel, launch: launch)

                            Text(launch.name)
                                .bold()
                                .font(.title3)

                            if let description = launch.details {
                                Text(description)
                            }

                            if !viewModel.formateDate(string: launch.date).isEmpty {
                                HStack {
                                    Text(LocalizedStringKey("launchDate"))

                                    Text(viewModel.formateDate(string: launch.date))
                                }
                                .bold()
                            }

                            if let success = launch.success {
                                HStack {
                                    Text(LocalizedStringKey("launchSuccess"))

                                    Text(String(success))
                                        .foregroundStyle(success ? .green : .red)
                                }
                                .bold()
                            }

                            if let url = launch.articleURL {
                                Button {
                                    selectedLink = LinkUrl(url: url)
                                } label: {
                                    Text(LocalizedStringKey("articleLink"))
                                }
                                .buttonStyle(.borderedProminent)
                            }

                            if let url = launch.wikiURL {
                                Button {
                                    selectedLink = LinkUrl(url: url)
                                } label: {
                                    Text(LocalizedStringKey("wikiLink"))
                                }
                                .buttonStyle(.borderedProminent)
                            }
                        }
                        .onAppear {
                            if launch == launches.last {
                                Task {
                                    await viewModel.fetchLaunches()
                                }
                            }
                        }
                    }
                    .sheet(item: $selectedLink) { linkUrl in
                        SafariView(url: linkUrl.url)
                    }
                }
            case .error(let string):
                Text(string)
                    .padding(.horizontal)
                    .foregroundStyle(.secondary)
            default:
                EmptyView()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchLaunches()
            }
        }
    }
}

struct ImageBlock: View {
    @Bindable var viewModel: LaunchesListViewModel
    let launch: Launch

    var body: some View {
        HStack {
            Spacer()

            if let image = viewModel.imageCache.object(forKey: launch.id as NSString) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Image(systemName: "photo.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        if viewModel.launchesImages[launch.id] == .loading {
                            ProgressView()
                        }
                    }
                    .onAppear {
                        guard viewModel.launchesImages[launch.id] == .fetched else { return }
                        Task {
                            await viewModel.fetchImage(for: launch)
                        }
                    }
            }
            Spacer()
        }
    }
}
