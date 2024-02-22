//
//  LogView.swift
//  openWB App
//
//  Created by Kiara on 17.03.22.
//

import SwiftUI


struct LadelogView: View {
    @State var selectedIndex = 0
    @State private var isOnAppear = true
    @State var entryArray: [Log] = []
    @State var showInfo = false
    @State var isLoading = false
    
    private let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .accentColor
    }
    
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    
                    if(entryArray.isEmpty){
                        Text("keine Daten gefunden")
                    }
                    if(isLoading){
                        ProgressView()
                    }
                    if(!isLoading)
                    {
                        ForEach(entryArray.sorted(by: {$0.start > $1.start}), id: \.self.start) { entry in
                            CarRectangleView(data: entry).frame(height: 100)
                        }
                    }
                }
            }
            .padding(.horizontal, 8)
            .onReceive(timer) { date in
                updateValues()
            }
            .onAppear {
                updateValues()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    IconButton(text: "", iconName: "arrow.clockwise", iconColor: .accentColor) {
                        updateValues()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Picker("", selection: $selectedIndex) {
                        Text("10").tag(0)
                        Text("25").tag(1)
                        Text("50").tag(2)
                        Text("100").tag(3)
                    }.pickerStyle(.segmented)
                        .disabled(isLoading)
                        .pickerStyle(.segmented).onChange(of: selectedIndex) { change in
                        selectedIndex = change
                        updateValues()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    IconButton(text: "", iconName: "info.circle", iconColor: .accentColor) {
                        showInfo.toggle()
                    }
                }
                
            } //MARK TODO: refreshable ios15
        }/*.refreshable {
          updateValues()
          }*/
        .sheet(isPresented: $showInfo) {
            ChargeModeInfoView()
        }
    }
    
    
    func updateValues() {
        isLoading = true
        let limit = [10,25,50,100][selectedIndex]
        
        Requests.getJSON("ladelog?limit=\(limit)", type: APIDataLadelog.self) {(result) in
            switch result {
            case .success(let data):
                entryArray = data.log
                isLoading = false
            case .failure(_):
                entryArray = []
                isLoading = false
            }
        }
      
    }
}

struct LadelogViewPreview: PreviewProvider {
    static var previews: some View {
        LadelogView()
    }
}
