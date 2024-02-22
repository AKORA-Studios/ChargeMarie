//
//  ButtonStyle.swift
//  ChargeMarie
//
//  Created by Kiara on 11.05.23.
//

import SwiftUI

struct PrimaryStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 15)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .cornerRadius(8)
            .foregroundColor(.white)
    }
}
