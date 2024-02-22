//
//  ToastView.swift
//  ChargeMarie
//
//  Created by Kiara on 11.05.23.
//

import SwiftUI

struct Toast: View {
    var title = "title"
    var message = "message"
    var color: Color = .gray
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color)
                
                VStack{
                    Text(title)
                        .font(.title).bold()
                    Text(message)
                }
                
            }.allowsHitTesting(true)
                .padding(20)
                .frame(height: geo.size.height / 5)
        }
    }
    
    mutating func setToast(){
        title = "title"
        message = "message"
    }
}


struct Toast_Previews: PreviewProvider {
    static var previews: some View {
        Toast()
            .previewLayout(.sizeThatFits)
    }
}
