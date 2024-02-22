//
//  ApiData.swift
//  openWB App
//
//  Created by Akora on 13.03.22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
//
//
//

import Foundation

// MARK: - APIDataLademodus  | /api/lademodus
struct APIDataLademodus: Codable {
    let modusName: String
    let modus: Int
}

struct APIDataREST: Codable {
    let date: String
    let lademodus, minimalstromstaerke, maximalstromstaerke, llsoll: Int
    let restzeitlp1: String
    let restzeitlp2, restzeitlp3: Int
    let gelkwhlp1: Double
    let gelkwhlp2, gelkwhlp3, gelrlp1, gelrlp2: Int
    let gelrlp3, llgesamt: Int
    let evua1, evua2, evua3: Double
    let lllp1, lllp2, lllp3, evuw: Int
    let pvw: Int
    let evuv1, evuv2, evuv3: Double
    let ladestatusLP1, ladestatusLP2, ladestatusLP3, ladestartzeitLP1: Int
    let ladestartzeitLP2, ladestartzeitLP3, zielladungaktiv, lla1LP1: Int
    let lla2LP1, lla3LP1, lla1LP2, lla2LP2: Int
    let lla3LP2: Int
    let llkwhLP1: Double
    let llkwhLP2, llkwhLP3: Int
    let evubezugWh, evueinspeisungWh: Double
    let pvWh, speichersoc, socLP1, socLP2: Int
    let speicherleistung, ladungaktivLP1, ladungaktivLP2, ladungaktivLP3: Int
    let chargestatLP1, chargestatLP2, plugstatLP1, plugstatLP2: Int
    let restzeitlp1M, restzeitlp2M, restzeitlp3M, lla1LP3: Int
    let lla2LP3, lla3LP3: Int

    enum CodingKeys: String, CodingKey {
        case date, lademodus, minimalstromstaerke, maximalstromstaerke, llsoll, restzeitlp1, restzeitlp2, restzeitlp3, gelkwhlp1, gelkwhlp2, gelkwhlp3, gelrlp1, gelrlp2, gelrlp3, llgesamt, evua1, evua2, evua3, lllp1, lllp2, lllp3, evuw, pvw, evuv1, evuv2, evuv3, ladestatusLP1, ladestatusLP2, ladestatusLP3, ladestartzeitLP1, ladestartzeitLP2, ladestartzeitLP3, zielladungaktiv, lla1LP1, lla2LP1, lla3LP1, lla1LP2, lla2LP2, lla3LP2, llkwhLP1, llkwhLP2, llkwhLP3, evubezugWh, evueinspeisungWh, pvWh, speichersoc, socLP1, socLP2, speicherleistung, ladungaktivLP1, ladungaktivLP2, ladungaktivLP3, chargestatLP1, chargestatLP2, plugstatLP1, plugstatLP2
        case restzeitlp1M = "restzeitlp1m"
        case restzeitlp2M = "restzeitlp2m"
        case restzeitlp3M = "restzeitlp3m"
        case lla1LP3, lla2LP3, lla3LP3
    }
}

// MARK: - APIDataGlobals | /api/globals
struct APIDataGlobals: Codable {
    let wHouseConsumption, wAllChargePoints, chargeMode, boolChargeAtNightDirect: Int
    let boolChargeAtNightNurpv, boolChargeAtNightMinpv, boolDisplayHouseConsumption, boolDisplayDailyCharged: Int
    let boolEvuSmoothedActive, boolDisplayHouseBatteryPriority, strLastmanagementActive: Int

    enum CodingKeys: String, CodingKey {
        case wHouseConsumption = "WHouseConsumption"
        case wAllChargePoints = "WAllChargePoints"
        case chargeMode = "ChargeMode"
        case boolChargeAtNightDirect = "boolChargeAtNight_direct"
        case boolChargeAtNightNurpv = "boolChargeAtNight_nurpv"
        case boolChargeAtNightMinpv = "boolChargeAtNight_minpv"
        case boolDisplayHouseConsumption, boolDisplayDailyCharged, boolEvuSmoothedActive, boolDisplayHouseBatteryPriority, strLastmanagementActive
    }
}



// MARK: - APIDataLadepunkt | /api/ladepunkt
struct APIDataLadepunkt: Codable {
    let name: String
    let soc: Int
    //let timeRemaining: String
    let phase: Phase
    let kWhDaily: Int
    let kWhCounter: Double
    let w, enabled: Int

    enum CodingKeys: String, CodingKey {
        case name, soc, phase, kWhDaily, kWhCounter
        case w = "W"
        case enabled
    }
}

// MARK: - Phase
struct Phase: Codable {
    let pf: [Int]
    let v: [Double]
    let a: [Int]

    enum CodingKeys: String, CodingKey {
        case pf = "Pf"
        case v = "V"
        case a = "A"
    }
}



// MARK: - APIDataLadestrom | /api/ladestrom
struct APIDataLadestrom: Codable {
    let min, max: Int
}





enum Lademodus: String, Codable {//0: Sofort 1: Min + PV 2: PV
    case jetzt = "Sofortladen"
    case minundpv =  "Min + PV"
    case pvuberschuss = "PV Überschuss"
    case stop = "Stop"
    case standby = "Standby"
}



// MARK: - APIDataLivevalues | /api/values
struct APIDataLivevalues: Codable {
    let evu, ladeleistung, photovoltaik: Int
    let hausverbrauch: Int
    let time: Double
}



// MARK: - APIDataRFID | /api/rfid
struct APIDataRFID: Codable {
    //let enabled: Bool
    let tagName: String?
    let timestamp: Int
}



// MARK: - APIDataVerbrauch  | /api/verbrauch
struct APIDataVerbrauch: Codable {
    let evu: Evu
    let verbraucher: Verbraucher
    let pv: PV
    let housebattery: Housebattery
}

// MARK: - Evu
struct Evu: Codable {
    let w: Int
    let phase: Phase
    let whImported, whExported: Double
    let aSchieflast: Int

    enum CodingKeys: String, CodingKey {
        case w = "W"
        case phase
        case whImported = "WhImported"
        case whExported = "WhExported"
        case aSchieflast = "ASchieflast"
    }
}

// MARK: - Housebattery
struct Housebattery: Codable {
    let w, soc, whImported, whExported: Int

    enum CodingKeys: String, CodingKey {
        case w = "W"
        case soc = "Soc"
        case whImported = "WhImported"
        case whExported = "WhExported"
    }
}

// MARK: - PV
struct PV: Codable {
    let w, whCounter, counterTillStartPVCharging: Int

    enum CodingKeys: String, CodingKey {
        case w = "W"
        case whCounter = "WhCounter"
        case counterTillStartPVCharging = "CounterTillStartPvCharging"
    }
}

// MARK: - Verbraucher
struct Verbraucher: Codable {
    let wNr1, whImportedNr1, whExportedNr1, wNr2: Int
    let whImportedNr2, whExportedNr2: Int

    enum CodingKeys: String, CodingKey {
        case wNr1 = "WNr1"
        case whImportedNr1 = "WhImportedNr1"
        case whExportedNr1 = "WhExportedNr1"
        case wNr2 = "WNr2"
        case whImportedNr2 = "WhImportedNr2"
        case whExportedNr2 = "WhExportedNr2"
    }
}











// MARK: - APIDataKeys | /api/rest
enum APIDataKey: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(APIDataKey.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for APIDataKey"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

typealias APIDataKeys = [String: APIDataKey]


// MARK: - APIDataLadelog
struct APIDataLadelog: Codable {
    let log: [Log]
}

// MARK: - Log
struct Log: Codable {
    let start, ende, km: Int
    let kWh, kW: Double
    let ladepunkt: String
    let modus: Int //0: Sofort 1: Min + PV 2: PV
  //  let tagName: String
}

// MARK: - LogIn Stuff
struct UserData: Codable {
    let username, tagName: String
 //   let tagCode: Int
    let admin: Bool
   // "iat": 1647820119,
    //"exp": 1647827319
}

// MARK: - APIAllUser
struct APIAllUser: Codable {
    let username, tagName: String
    let admin: Bool
}

typealias APIAllUsers = [APIAllUser]

struct LogInStruct {
    let username, password: String
}
