
// Implement mobile phone storage protocol
// Requirements:
// - Mobiles must be unique (IMEI is an unique number)
// - Mobiles must be stored in memory

import UIKit

protocol MobileStorage {
    func getAll() -> Set<Mobile>
    func findByImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}

struct Mobile: Hashable {
    let imei: String
    let model: String
}

enum MobileDataBaseError: Error {
    
    case databaseHasThisMobile
    case databaseDoesntHaveThisMobile
}

class MobilePhoneDataBase: MobileStorage {
    
    var mobilePhones = [String : Mobile]()
    
    func getAll() -> Set<Mobile> {
        var set: Set<Mobile> = []
        
        mobilePhones.forEach { key, value in
            set.insert(value)
        }
        return set
    }
    
    func findByImei(_ imei: String) -> Mobile? {
        if mobilePhones[imei] != nil {
            return mobilePhones[imei]
        } else {
            return nil
        }
    }
    
    func save(_ mobile: Mobile) throws -> Mobile {
        if !exists(mobile) {
            mobilePhones.updateValue(mobile, forKey: mobile.imei)
        } else {
            throw MobileDataBaseError.databaseHasThisMobile
        }
        return mobile
    }
    
    func delete(_ product: Mobile) throws {
        if exists(product) {
            mobilePhones[product.imei] = nil
        } else {
            throw MobileDataBaseError.databaseDoesntHaveThisMobile
        }
    }
    
    func exists(_ product: Mobile) -> Bool {
        if mobilePhones[product.imei] != nil && mobilePhones[product.imei]?.model == product.model {
            return true
        } else {
            return false
        }
    }
}

