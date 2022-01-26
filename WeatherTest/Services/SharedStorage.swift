//
//  SharedStorage.swift
//  WeatherTest
//
//  Created by Tata on 09/01/22.
//

import Foundation

protocol SharedStorage {
    func setValue(key: String, value: Data?)
    func getValue(key: String) -> Data
    
    func setValueInt(key: String, value: Int?)
    func getValueInt(key: String) -> Int
}

final class SharedStorageImp: SharedStorage {
    let storage = UserDefaults.standard
    
    func setValue(key: String, value: Data?) {
        storage.set(value, forKey: key)
    }
    
    func getValue(key: String) -> Data {
        return storage.data(forKey: key) ?? Data()
    }
    
    func setValueInt(key: String, value: Int?) {
        storage.set(value, forKey: key)
    }
    func getValueInt(key: String) -> Int {
        return storage.integer(forKey: key)
    }
}
