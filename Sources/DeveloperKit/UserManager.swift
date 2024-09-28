//
//  UserManager.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 28/9/24.
//

import Foundation
//import InfoEnergy

@propertyWrapper struct UserDefault<T, Key: RawRepresentable<String>> {
    let key: Key
    let defaultValue: T? = nil
    let storage = UserDefaults.standard
    
    var wrappedValue: T? {
        get { storage.value(forKey: key.rawValue) as? T }
        set { storage.setValue(newValue, forKey: key.rawValue) }
    }
}

@propertyWrapper public struct UserDefaultData<T: Codable, Key: RawRepresentable<String>> {
    public init(key: Key) {
        self.key = key
    }
    
    let key: Key
    let defaultValue: T? = nil
    let storage = UserDefaults.standard
    
    var wrappedData: Data? {
        get { storage.value(forKey: key.rawValue) as? Data }
        set { storage.setValue(newValue, forKey: key.rawValue) }
    }
    
    public var wrappedValue: T? {
        get {
            guard let data = wrappedData else { return nil }
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print("Error decoding \(T.self): \(error)")
                return nil
            }
        }
        set {
            if let newValue {
                do {
                    wrappedData = try JSONEncoder().encode(newValue)
                } catch {
                    print("Error encoding InfoEnergyCSVModel: \(error)")
                    wrappedData = nil
                }
            } else {
                wrappedData = nil
            }
        }
    }
}
