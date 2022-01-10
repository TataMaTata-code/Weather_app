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
}

final class SharedStorageImp: SharedStorage {
    let storage = UserDefaults.standard
    
    func setValue(key: String, value: Data?) {
        storage.set(value, forKey: key)
    }
    
    func getValue(key: String) -> Data {
        return storage.data(forKey: key) ?? Data()
    }
}
