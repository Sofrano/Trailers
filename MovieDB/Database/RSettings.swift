//
//  RLanguage.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 31/03/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import RealmSwift

// Application settings

class RSettings: Object {
    @objc dynamic var key: String?
}

extension RSettings {
    
    static var language: String? {
        get {
            let realm = try! Realm()
            return realm.objects(RSettings.self).first?.key
        }
        set {
            let realm = try! Realm()
            let language = RSettings()
            language.key = newValue
            try? realm.write {
                realm.delete(realm.objects(RSettings.self))
                realm.add(language)
            }
            if let value = newValue {
                Locale.updateLanguage(code: value)
            }
            NotificationManager.postNotification(.changeLanguage)
        }
    }

}
