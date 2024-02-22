//
//  ColorExtension.swift
//  ChargeMarie
//
//  Created by Kiara on 12.01.23.
//

import UIKit

extension UIColor {
    //base colors
    static var colorNow: UIColor {return UIColor.red}
    static var colorPVMin: UIColor {return UIColor.blue}
    static var colorPV: UIColor {return UIColor.green}
    
    static var accentColor: UIColor {return UIColor(named: "AccentColor") ??  UIColor.init(hexString: "428FE3")}
    static var inactiveColor: UIColor {return UIColor.systemGray5}

    //support HexCodes
    convenience init(hexString:String) {
        let hexString:String = hexString.trimmingCharacters(
            in: CharacterSet.whitespacesAndNewlines
        )
        var scanner            = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner = Scanner(string: String(hexString.split(separator: "#")[0]))
        }
        
        var color:UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
}
