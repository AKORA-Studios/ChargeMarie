//
//  ChargeModeInfo.swift
//  openWB App
//
//  Created by Kiara on 27.04.22.
//

import SwiftUI


struct ChargeModeInfoView:  View {
    var body: some View {
        ScrollView{
            VStack {
                Text("Sofort Laden")
                RoundedRectangle(cornerRadius: 5, style: .continuous).fill(Color(UIColor.colorNow)).frame(height: 60)
                Spacer()
                Text("PhotoVoltarik + Min")
                RoundedRectangle(cornerRadius: 5, style: .circular).fill(Color(UIColor.colorPVMin)).frame(height: 60)
                Spacer()
                Text("PhotoVoltarik")
                RoundedRectangle(cornerRadius: 5, style: .continuous).fill(Color(UIColor.colorPV.cgColor)).frame(height: 60)
                Spacer()
            }.padding()
        }
        
    }
        
}


