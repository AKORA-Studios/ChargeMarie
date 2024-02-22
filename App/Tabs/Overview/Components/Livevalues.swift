//
//  LivevalueView.swift
//  openWB App
//
//  Created by Akora on 03.04.22.
//

import SwiftUI

struct Livevalues: View {
    let textWidth = 80.0
    let fieldHeight = 20.0
    let horzSpacing = 10.0
    let maxValue = 11000.0
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    @State var values: APIDataLivevalues = APIDataLivevalues(evu: 0, ladeleistung: 0, photovoltaik: 0, hausverbrauch: 0, time: 0)
    
    var body: some View {
        VStack(spacing: 10.0) {
            HStack(spacing: horzSpacing) {
                Text("Netz").frame(width: textWidth, height: fieldHeight, alignment: .trailing)
                ProgressView(value: Double(abs(values.evu)), total: maxValue)
                Text(String(format: "%.1d kW", values.evu))
                    .font(Font.footnote)
                    .fontWeight(.thin)
                    .frame(width: textWidth*0.8, height: fieldHeight, alignment: .leading)
            }
            HStack(spacing: horzSpacing) {
                Text("HausVB").frame(width: textWidth, height: fieldHeight, alignment: .trailing)
                ProgressView(value: Double(values.hausverbrauch), total: maxValue)
                Text(String(format: "%.1d kW", values.hausverbrauch))
                    .font(Font.footnote)
                    .fontWeight(.thin)
                    .frame(width: textWidth*0.8, height: fieldHeight, alignment: .leading)
            }
            HStack(spacing: horzSpacing) {
                Text("PV").frame(width: textWidth, height: fieldHeight, alignment: .trailing)
                ProgressView(value: Double(values.photovoltaik), total: maxValue)
                Text(String(format: "%.1d kW", values.photovoltaik))
                    .font(Font.footnote)
                    .fontWeight(.thin)
                    .frame(width: textWidth*0.8, height: fieldHeight, alignment: .leading)
            }
            HStack(spacing: horzSpacing) {
                Text("LadeVB").frame(width: textWidth, height: fieldHeight, alignment: .trailing)
                ProgressView(value: Double(values.ladeleistung), total: maxValue)
                Text(String(format: "%.1d kW", values.ladeleistung))
                    .font(Font.footnote)
                    .fontWeight(.thin)
                    .frame(width: textWidth*0.8, height: fieldHeight, alignment: .leading)
            }
        }.onReceive(timer) { date in
            updateValues()
        }
        .onAppear() {
            updateValues()
        }
    }
    
    func updateValues() {
        Requests.getJSON("values", type: APIDataLivevalues.self) { result in
            switch (result) {
            case .success(let data):
                self.values = data
            case .failure(let err):
                print(err)
            }
        }
    }
}

struct ValueField: View {
    let textWidth = 80.0
    let fieldHeight = 20.0
    let spacing = 30.0
    
    let name: String
    let min: Double = 0
    let max: Double = 13000
    
    @State var value: Double
    
    init(name: String, value: Double) {
        self.name = name
        self.value = value
    }
    
    var body: some View {
        HStack(spacing: spacing) {
            Text(name).frame(width: textWidth, height: fieldHeight, alignment: .trailing)
            ProgressView(value: value, total: max)
        }
    }
}
