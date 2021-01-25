//
//  RecketDetailsView.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import SwiftUI

struct RecketDetailsView: View {
    @ObservedObject var viewModel: RecketDetailsViewModel
    
    var body: some View {
        pageContent.onAppear {
            viewModel.fetchRocketInfo()
        }
    }
    
    var pageContent: some View {
        switch viewModel.state {
            case .loading:
                return ActivityIndicator(isAnimating: true).eraseToAnyView()
            case .finished(let viewModel):
                return RecketDetailsContentView(viewModel: viewModel).eraseToAnyView()
            case .error(let description):
                return (Text("Error: ").fontWeight(.bold) + Text(description)).eraseToAnyView()
        }
    }
}
