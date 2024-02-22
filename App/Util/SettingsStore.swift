//
//  SettingsStore.swift
//  openWB App
//
//  Created by AKORA on 22.04.22.
//

import SwiftUI
import Combine


final class SettingsStore: ObservableObject {
    private enum Keys {
        static let pro = "pro"
        static let chargeMode = "charge_mode"
    }
    
    private let cancellable: Cancellable
    private let defaults: UserDefaults
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        
        defaults.register(defaults: [
            Keys.pro: false,
            Keys.chargeMode: 0
        ])
        
        cancellable = NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification)
            .map { _ in () }
            .subscribe(objectWillChange)
    }
    
    var isPro: Bool {
        set { defaults.set(newValue, forKey: Keys.pro) }
        get { defaults.bool(forKey: Keys.pro) }
    }
    
    var chargeMode: Int {
        set { defaults.set(newValue, forKey: Keys.chargeMode) }
        get { defaults.integer(forKey: Keys.chargeMode) }
    }
    
    /*
     enum SleepTrackingMode: String, CaseIterable {
     case low
     case moderate
     case aggressive
     }
     
     var sleepTrackingMode: SleepTrackingMode {
     get {
     return defaults.string(forKey: Keys.chargeMode)
     .flatMap { SleepTrackingMode(rawValue: $0) } ?? .moderate
     }
     
     set {
     defaults.set(newValue.rawValue, forKey: Keys.chargeMode)
     }
     }
     */
}

/*
extension SettingsStore {
    func unlockPro() {
        // You can do your in-app transactions here
        isPro = true
    }
    
    func restorePurchase() {
        // You can do you in-app purchase restore here
        isPro = true
    }
}
*/

var Settings: SettingsStore = .init()


