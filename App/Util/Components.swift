//
//  Components.swift
//  openWB App
//
//  Created by AKORA on 24.04.22.
//

import SwiftUI
import UIKit

// MARK: Buttons

// MARK: - ButtonClass
class ButtonClass: UIButton {
    override func layoutSubviews() {
        self.layer.cornerRadius = 5.0
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        self.backgroundColor = .systemGray6
    }
}

// MARK: - IconButton
struct IconButton: View {
    let text: String
    let iconName: String
    let iconColor: Color?
    let action: () -> Void
    
    init(text: String, iconName: String) {
        self.text = text
        self.iconName = iconName
        self.iconColor = nil
        self.action = {}
    }
    
    init(text: String, iconName: String, iconColor: Color?) {
        self.text = text
        self.iconName = iconName
        self.iconColor = iconColor
        self.action = {}
    }
    
    init(text: String, iconName: String, iconColor: Color?, action: (() -> Void)?) {
        self.text = text
        self.iconName = iconName
        self.iconColor = iconColor
        self.action = action ?? {}
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                if iconColor != nil {
                    Image(systemName: iconName)
                        .foregroundColor(iconColor)
                } else {
                    Image(systemName: iconName)
                }
                
                Text(text).foregroundColor(.primary)
            }
        }
    }
}

// MARK: - IconButton
struct SheetButton<Sheet: View>: View {
    let text: String
    let iconName: String?
    let iconColor: Color?
    let sheet: Sheet
    
    @State var presentingSheet = false
    
    init(text: String, @ViewBuilder sheetContent: () -> Sheet) {
        self.text = text
        self.iconName = nil
        self.iconColor = nil
        self.sheet = sheetContent()
    }
    
    init(text: String, iconName: String?,  @ViewBuilder sheetContent: () -> Sheet) {
        self.text = text
        self.iconName = iconName
        self.iconColor = nil
        self.sheet = sheetContent()
    }
    
    init(text: String, iconName: String?, iconColor: Color?,  @ViewBuilder sheetContent: () -> Sheet) {
        self.text = text
        self.iconName = iconName
        self.iconColor = iconColor
        self.sheet = sheetContent()
    }
    
    var body: some View {
        Button(action: {
            presentingSheet = true
        }) {
            HStack {
                if iconName != nil {
                    if iconColor != nil {
                        Image(systemName: iconName!)
                            .foregroundColor(iconColor)
                    } else {
                        Image(systemName: iconName!)
                    }
                }
                Text(text).foregroundColor(.primary)
            }
        }.sheet(isPresented: $presentingSheet, content: { sheet })
    }
}
