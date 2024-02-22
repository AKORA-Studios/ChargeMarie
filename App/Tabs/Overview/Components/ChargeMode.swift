//
//  ChargeMode.swift
//  openWB App
//
//  Created by Akora on 06.04.22.
//

import SwiftUI


struct ChargeModeView: View {
    @State private var selectedModeIndex = 0
    @State private var serverChargeModeIndex = 3
    @State private var isOnAppear = true
    @State private var isLoading = false
    
    @State private var lastData: APIDataLademodus = APIDataLademodus(modusName: "jetz", modus: 0)
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .accentColor
    }
    
    var body: some View {
        
        VStack (spacing: 10){
            if(isLoading){ProgressView()}
            
            ZStack {
                //Show state on server
                Picker("Server", selection: $serverChargeModeIndex, content: {
                    Text("").tag(0)
                    Text("").tag(1)
                    Text("").tag(2)
                    Text("").tag(4)
                    Text("").tag(3)
                }).disabled(true).colorMultiply(Color.orange).foregroundColor(Color.orange)
                
                //Show user state
                Picker("Ausgewählt", selection: $selectedModeIndex, content: {
                    Text("Sofort").tag(0)
                    Text("Min + PV").tag(1)
                    Text("PV").tag(2)
                    Text("Standby").tag(3)
                    Text("Stop").tag(4)
                }).disabled(isLoading)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .onReceive(timer) { date in
            updateValues()
        }
        .onChange(of: selectedModeIndex) { tag in
            if (isOnAppear) {
                isOnAppear = false
                return
            }
            setLademodus()
        }
        .onAppear {
            isOnAppear = true
            updateValues()
            selectedModeIndex = lastData.modus
        }
    }
    
    func setLademodus() {
    //    Requests.postJSON("lademodus/\(selectedModeIndex)", body: []) {_ in }
    //    self.updateValues()
    }
    
    func updateValues() {
        isLoading = serverChargeModeIndex != selectedModeIndex
        
        Requests.getJSON("lademodus", type: APIDataLademodus.self) { result in
            switch (result) {
            case .success(let data):
                self.lastData = data
                self.serverChargeModeIndex = data.modus
                isLoading = serverChargeModeIndex != selectedModeIndex
                break;
            case .failure(let err):
                print("ChargeMode: GET /lademodus", err)
                break;
            }
        }
     
    }
}
