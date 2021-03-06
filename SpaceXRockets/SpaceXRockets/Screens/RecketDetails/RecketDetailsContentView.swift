//
//  RecketDetailsContentView.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 25.01.2021.
//

import SwiftUI

struct RecketDetailsContentView: View {
    @ObservedObject var viewModel: RecketDetailsContentViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                image
                    .frame(height: 200)
                    .cornerRadius(5)
                    .padding(.top)
                    .padding(.bottom)
                
                HStack {
                    rocketName
                        .layoutPriority(1)

                    rateBadge
                }

                Divider()
                
                InfoRow("First flight date", viewModel.firstFlightDate)
                InfoRow("Cost per launch", viewModel.costPerLaunch)
                InfoRow("Country", viewModel.country)
                InfoRow("Status", viewModel.activeStatus.stringRepresentation, valueColor: statusColor)
                InfoRow("Description", viewModel.description)
                
                wikipediaButton
                    .padding(.top, 20)
                
            }
        }
        .padding(.horizontal)
    }
    
    var statusColor: Color {
        switch viewModel.activeStatus {
            case .active: return .green
            case .notActive: return .gray
        }
    }
    
    // MARK: - Views
    
    var image: some View {
        RemoteImage(url: viewModel.imageURL) {
            imagePlaceholder
        } image: {
            Image(uiImage: $0)
                .resizable()
                .scaledToFill()
                .eraseToAnyView()
        }
    }
    
    var imagePlaceholder: some View {
        Rectangle()
            .fill(Color.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var rocketName: some View {
        Text(viewModel.recketName)
            .font(.system(size: 30))
            .fontWeight(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var rateBadge: some View {
        Text(viewModel.rateBadge)
            .font(.system(size: 28))
            .frame(minWidth: 36, maxWidth: .infinity, alignment: .trailing)
    }
    
    var wikipediaButton: some View {
        Button("Open Wikipedia", action: openWikipedia)
            .buttonStyle(PrimaryButtonStyle())
    }
    
    // MARK: - Actions
    
    private func openWikipedia() {
        UIApplication.shared.open(viewModel.wikipediaURL, options: [:])
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    let fontSize: CGFloat
    let valueColor: Color
    
    init(_ title: String, _ value: String, fontSize: CGFloat = 18, valueColor: Color = .black) {
        self.title = title
        self.value = value
        self.fontSize = fontSize
        self.valueColor = valueColor
    }
    
    var body: some View {
        (titleText + valueText)
            .font(.system(size: fontSize))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 5)
    }
    
    var titleText: Text {
        Text(title + ": ")
            .fontWeight(.bold)
    }
    
    var valueText: Text {
        Text(value)
            .foregroundColor(valueColor)
    }
}


struct RecketDetailsContentView_Previews: PreviewProvider {
    static var previews: some View {
        let description = "Falcon 9 is a two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit."
        let response = RocketResponse(
            rocketId: "falcon9",
            rocketName: "Falcon 9",
            coverImageURL: URL(string: "https://farm1.staticflickr.com/929/28787338307_3453a11a77_b.jpg")!,
            successRate: 97,
            firstFlightDate: Date(),
            isActive: true,
            costPerLaunch: 50000000,
            wikipediaURL: URL(string: "https://en.wikipedia.org/wiki/Falcon_9")!,
            country: "United States",
            description: description)
        
        let viewModel = RecketDetailsContentViewModel(response)
        RecketDetailsContentView(viewModel: viewModel)
    }
}
