//
//  PrimaryButtonStyle.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 07.02.2021.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color.blue.opacity(0.7) : Color.blue)
            .cornerRadius(12)
    }
}
