//
//  Overview.swift
//  openWB App
//
//  Created by Akora on 06.04.22.
//

import SwiftUI

struct Overview: View {
    @State var isLoading = false
    var body: some View {
        VStack(spacing: 50.0) {
            ChargeModeView()
            Livevalues()
        }
        .padding(35.0)
    }
}
