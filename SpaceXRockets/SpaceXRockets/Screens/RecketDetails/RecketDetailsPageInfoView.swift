//
//  RecketDetailsPageInfoView.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 25.01.2021.
//

import SwiftUI

struct RecketDetailsPageInfoView: View {
    let info: RecketDetailsPageInfo
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                image
                
                HStack {
                    rocketName
                        .layoutPriority(1)

                    rateBadge
                }

                Divider()
                
                InfoRow("First flight date", info.firstFlightDate)
                InfoRow("Cost per launch", info.costPerLaunch)
                InfoRow("Country", info.country)
                InfoRow("Status", info.activeStatus.stringRepresentation, valueColor: statusColor)
                InfoRow("Description", info.description)
                
                wikipediaButton
                    .padding(.top, 20)
                
            }
        }
        .padding(.horizontal)
    }
    
    var statusColor: Color {
        switch info.activeStatus {
            case .active: return .green
            case .notActive: return .gray
        }
    }
    
    // MARK: - Views
    
    var image: some View {
        Image("rocket")
            .resizable()
            .scaledToFit()
            .cornerRadius(5)
            .padding(.top)
            .padding(.bottom)
    }
    
    var rocketName: some View {
        Text(info.recketName)
            .font(.system(size: 30))
            .fontWeight(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var rateBadge: some View {
        Text(info.rateBadge)
            .font(.system(size: 28))
            .frame(minWidth: 36, maxWidth: .infinity, alignment: .trailing)
    }
    
    var wikipediaButton: some View {
        Button(action: {
            UIApplication.shared.open(info.wikipediaURL, options: [:])
        }, label: {
            Text("Open Wikipedia")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
        })
        .background(Color.blue)
        .cornerRadius(12)
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


struct RecketDetailsPageInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let description = "Falcon 9 is a two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit."
        let response = RocketResponse(
            rocketId: "falcon9",
            rocketName: "Falcon 9",
            images: [],
            successRate: 97,
            firstFlightDate: Date(),
            isActive: true,
            costPerLaunch: 50000000,
            wikipediaURL: URL(string: "https://en.wikipedia.org/wiki/Falcon_9")!,
            country: "United States",
            description: description)
        
        let info = RecketDetailsPageInfo(response)
        RecketDetailsPageInfoView(info: info)
    }
}
