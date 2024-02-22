//
//  Requests.swift
//  openWB App
//
//  Created by Kiara on 08.02.22.
//

import Foundation
import UIKit

enum RequestError: Error {
    case NoWifiConnection
    case DecodeError
    case FailedApiRequest
    case StatusError
    case NotLoggedIn
    case InvalidCredentials
    case NotFound
    case InternalServerError
    case NoDataError
    case InvalidBody
    case JWTParseError
    case custom(detailedDescription: String)
}

func getErrorAlert(_ error: RequestError) -> UIAlertController {
    let text: String
    switch (error) {
    case .InvalidCredentials:
        text = "Ungültige Anmeldedaten"; break;
    case .InternalServerError:
        text = "Interner Serverfehler, bitte Entwicklern melden"; break;
    case .FailedApiRequest:
        text = "Es besteht keine Verbindung zum Internet"; break;
    case .NotLoggedIn:
        text = "Nicht angemeldet"; break;
    case .NoWifiConnection:
        text = "Es besteht keine Verbindung zum Internet"; break;
    case .DecodeError:
        text = "Fehler bei dekodieren der Antwort, bitte an Entwickler wenden."; break;
    case .JWTParseError:
        text = "Fehler beim auslesen des Token, bitte an Entwickler wenden."; break;
    default:
        text = error.localizedDescription; break;
    }
    
    let errorlert = UIAlertController(title: "Fehler aufgetreten", message: text, preferredStyle: .alert)
    errorlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
        errorlert.dismiss(animated: true, completion: nil)}))
    return errorlert
}


var ErrorAlerts =  ["NoWifiConnection": "Keine Internetverbidnung vorhanden", "DecodeError": "Rückgabewerte konnten nicht verarbeitet werden", "FailedApiRequest": "Apianfrage fehlgeschlagen", "StatusError": "Unbekannter oder fehlerhafter Statuscode", "NotFound": "APi Endpunkt nicht erreichbar", "InternalServerError": "Internener Serverfehler aufgetreten", "NoDataError": "Keine Rückgabewerte erhalten"]

struct Requests {
    //
    // - QwQ
    static var jwt: String?
    static var user: UserData?
    static let localRoot = "http://192.168.1.28:3000/api/"

    static var rootAddress: String {
        let a = DataStorage.getData().adress ?? localRoot
        DataStorage.saveAdress(a)
        return a
    }
    
    static func getAdress() -> String{
        return DataStorage.getData().adress ?? localRoot
    }
    
    private static func loadData(_ url: String, completion: @escaping (Result<Data, RequestError>) -> Void){
        var request = URLRequest(url: URL(string: rootAddress + url)!)
        request.setValue(Requests.jwt, forHTTPHeaderField: "authorization");
        
        let session = URLSession(configuration: .default).dataTask(with: request){
            (data, response, error) in
            if let error = error {
                print(error)
                return completion(.failure(RequestError.FailedApiRequest))
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    break;
                case 403:
                    return completion(.failure(.NotLoggedIn))
                case 404:
                    return completion(.failure(.NotFound))
                case 500:
                    return completion(.failure(.InternalServerError))
                default:
                    return completion(.failure(.StatusError))
                }
            } else {
                print("No response")
                return completion(.failure(RequestError.FailedApiRequest))
            }
            
            if let data = data {
                return completion(.success(data))
            } else {
                return completion(.failure(RequestError.NoDataError))
            }
        }
        session.resume()
        
    }
    
    /// Receive the JSON Object from the given URL
    static func getJSON<T: Decodable>(_ url: String, type: T.Type, completion: @escaping (Result<T, RequestError>) -> Void) {
        var returnData: T? = nil
        
        loadData(url) {
            (result) in
            switch result {
            case .success(let data):
                do {
                    returnData = try JSONDecoder().decode(type.self, from: data)
                    return completion(.success(returnData!))
                } catch let err {
                    print(err)
                    return completion(.failure(.DecodeError))
                }
            case .failure(let err):
                return completion(.failure(err))
            }
        }
    }
    
    
    /// Post a JSON Body to any given URL and Receive the Response as String
    /// - Parameters:
    ///   - url: The url to post the data to
    ///   - body: JSON Body as Dictionary
    ///   - completion: Callback for the results
    // Post a JSON Body to any given URL and Receive the Response as String
    /// - Parameters:
    ///   - url: The url to post the data to
    ///   - body: JSON Body as Dictionary
    ///   - completion: Callback for the results
    static func postJSON(_ url: String, body: Any,completion: @escaping (Result<String, RequestError>) -> Void) {
        return postJSON(url, body: body, method: "POST", completion: completion)
    }
    
    static func postJSON(_ url: String, body: Any, method: String?,completion: @escaping (Result<String, RequestError>) -> Void) {
        guard let bodyData =  try? JSONSerialization.data(withJSONObject: body) else {
            return completion(.failure(.InvalidBody));
        }
        
        var request = URLRequest(url: URL(string: getAdress() + url)!)
        request.httpMethod = method ?? "POST"
        request.setValue(Requests.jwt, forHTTPHeaderField: "authorization");
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyData
        
        let session = URLSession(configuration: .default).dataTask(with: request) {(data,response, error) in
            
            if let error = error {
                print(error)
                return completion(.failure(.FailedApiRequest))
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    break;
                case 403:
                    return completion(.failure(.InvalidCredentials))
                case 404:
                    return completion(.failure(.NotFound))
                case 500:
                    return completion(.failure(.InternalServerError))
                default:
                    print(String(data: data!, encoding: .utf8)!)
                    return completion(.failure(.StatusError))
                }
            } else {
                //print("No response")
                return completion(.failure(RequestError.FailedApiRequest))
            }
            
            guard let data = data else {
                return completion(.failure(.NoDataError))
            }
            
            guard let dataString = String(data: data, encoding: .utf8)  else {
                return completion(.failure(.DecodeError))
            }
            
            return completion(.success(dataString))
        }
        session.resume()
    }
    
    
    
    /// Parses a given JWT and returns its payload
    /// - Parameter jwt: The entire JWT as a String
    /// - Returns: The payload stored in the JWT
    static func parseJWT<T: Decodable>(_ jwt: String, type: T.Type) throws -> T {
        let payloadString = jwt.components(separatedBy: ".")[1]
        //Pad payload to length divideable by 4 with "=" character
        let paddedPayload = payloadString.padding(toLength: payloadString.count + payloadString.count%4, withPad: "=", startingAt: 0);
        //print("JWT: \"\(jwt)\"");
        print("payload: \"\(paddedPayload)\"");
        
        guard let decodedData = Data(base64Encoded: paddedPayload) else {
            throw RequestError.JWTParseError
        }
        let decodedString = String(data: decodedData, encoding: .utf8)!
        
        return try JSONDecoder().decode(type.self, from: Data(decodedString.utf8))
    }
    
    
    static func parseJWT( _ jwt: String) throws -> UserData {
        return try parseJWT(jwt, type: UserData.self)
    }
    
    /// This fuction is a wrapper for the normal .login function which takes the login credentials as additional arguments, this function gets the credentials from the DataStorage instead.
    /// @deprecated
    @available(*, deprecated, message: "Provide explicit credentials instead")
    static func login(force: Bool, completion: @escaping (Result<Void?, RequestError>) -> Void) {
        let data = DataStorage.getData()
        return Requests.login(force: force, username: data.username!, password: data.password!, completion: completion);
    }
    
    static func login(force: Bool, username: String, password: String, completion: @escaping (Result<Void?, RequestError>) -> Void) {
        if (Requests.jwt != nil && !force) {
            return completion(.success(nil));
        }
        
        //let data = DataStorage.getData()
        let body = ["username": "\(username)", "password": "\(password)"]
        
        Requests.postJSON("login", body: body) {(result) in
            
            switch result {
            case .success(let data):
                do {
                    let user = try Requests.parseJWT(data)
                    Requests.user = user
                    Requests.jwt = data
                    return completion(.success(nil))
                } catch(let err) {
                    print("Invalid JWT at login, Error: ", err);
                    return completion(.failure(RequestError.custom(detailedDescription: err.localizedDescription)))
                }
            case .failure(let err):
                print("Error", err)
                return completion(.failure(err))
            }
        }
    }
}
