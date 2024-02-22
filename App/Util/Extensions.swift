//
//  Extensions.swift
//  openWB App
//
//  Created by AKORA on 27.04.22.
//

import Foundation
import UIKit

// MARK: - Date
extension Date {
    init(fromMillis: Int) {
        self = Date.fromMillis(fromMillis)
    }
    
    static func fromMillis(_ date: Int) -> Date {
        return Date(timeIntervalSince1970: Double(date)/1000.0)
    }
    
    func format() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E dd.MM.yyyy, HH:mm"
        return dateFormatter.string(from: self)
    }
}

// MARK: - UIViewController
extension UIViewController {
    func dismissAllAlerts() {
        if(self.navigationController?.visibleViewController is UIAlertController) {
            self.navigationController?.visibleViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
