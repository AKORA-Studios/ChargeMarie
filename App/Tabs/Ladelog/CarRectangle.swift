//
//  CarRectangle.swift
//  openWB App
//
//  Created by Kiara on 14.03.22.
//

import SwiftUI


struct CarRectangleView: View {
    var data: Log
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill((colorScheme == .dark ? Color(UIColor.darkGray) : Color(UIColor.lightGray)).opacity(0.2 ))
                    .background(RoundedRectangle(cornerRadius: 25)
                        .stroke(getColor(data.modus), lineWidth: 3))
                    .frame(width: geo.size.width - 10)
                    .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 2)
                
                HStack {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill((colorScheme == .dark ? Color(UIColor.darkGray) : Color(UIColor.lightGray)).opacity(0.5 ))
                            .frame(width: geo.size.height - 10, height: geo.size.height - 10)
                          //  .shadow(color: .black.opacity(0.7),radius: 5.0, x: 5, y: 5)
                        VStack {
                            Text(getDate(data.start)).foregroundColor(colorScheme == .dark ? .gray : .black.opacity(0.7))
                   //         Text(data.tagName).font(.title)
                            Spacer()
                        }.padding(10).frame(width: geo.size.height - 10)
                        
                        
                    }.frame(alignment: .leading).padding(.leading, 5)
                    VStack{
                        HStack {
                            Text(getTime(data.start))
                            RoundedRectangle(cornerRadius: 8).fill(getColor(data.modus)).frame(height: geo.size.height/3/6)
                            Text(getTime(data.ende))
                        }.padding(.horizontal, 5)
                        HStack{
                            Spacer()
                            HStack{
                                VStack {
                                    Image(systemName: "point.topleft.down.curvedto.point.bottomright.up.fill")
                                    Image(systemName: "eurosign.circle.fill")
                                }
                                VStack {
                                    Text("\(data.km) km")
                                    Text("\(String(format: "%.1f", data.kWh * 0.35)) €")
                                }
                            }
                            Spacer()
                            HStack{
                                VStack {
                                    Image(systemName: "bolt.batteryblock.fill")
                                    Image(systemName: "speedometer")
                                }
                                VStack {
                                    Text("\(String(format: "%.1f", data.kWh)) KWh")
                                    Text("\(String(format: "%.1f", data.kW)) KW")
                                }
                            }
                            Spacer()
                        }
                    }
                }.padding(10)
            }
        }
        
    }
    
    func getDate(_ date: Int)-> String{
        let newDate = Date(fromMillis: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return  dateFormatter.string(from: newDate)
    }
    
    func getTime(_ date: Int)-> String{
        let newDate = Date(fromMillis: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return  dateFormatter.string(from: newDate)
    }
    
    // 0: Sofort 1: Min + PV 2: PV
    func getColor(_ mode: Int)-> Color {
        switch mode {
        case 0: return Color(UIColor.colorNow)
        case 1: return Color(UIColor.colorPVMin)
        case 2: return Color(UIColor.colorPV)
            //invalid cased
        default:return Color(UIColor.red)
        }
    }
}


struct CarRectangleView_Preview: PreviewProvider {
    
    static var previews: some View {
        CarRectangleView(data: Log(start: 1674139244, ende: 1674153644, km: 1, kWh: 1, kW: 1.0, ladepunkt: "E", modus: 0))
    }
}
