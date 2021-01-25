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
                return AnyView(ActivityIndicator(isAnimating: true))
            case .finished(let info):
                return AnyView(RecketDetailsPageInfoView(info: info))
            case .error(let description):
                return AnyView(Text("Error: ").fontWeight(.bold) + Text(description))
        }
    }
}
