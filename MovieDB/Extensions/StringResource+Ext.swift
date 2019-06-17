//
//  StringResource.swift
//  MovieDB
//
//  Created by Dmitriy Safarov on 22/04/2019.
//  Copyright © 2019 SimpleCode. All rights reserved.
//

import Foundation
import Rswift

extension StringResource {
    public func localized() -> String {
        guard
            let basePath = bundle.path(forResource: "Base", ofType: "lproj"),
            let baseBundle = Bundle(path: basePath)
            else {
                return self.key
        }
        
        let fallback = baseBundle.localizedString(forKey: key, value: key, table: tableName)
        
        guard
            let localizedPath = bundle.path(forResource: RSettings.language ?? "", ofType: "lproj"),
            let localizedBundle = Bundle(path: localizedPath)
            else {
                return fallback
        }
        
        return localizedBundle.localizedString(forKey: key, value: fallback, table: tableName)
    }
}

final class AppLocale {
    fileprivate(set) var original: Locale
    fileprivate(set) var originalPreferredLanguages: [String]
    private init() {
        original = Locale.current
        originalPreferredLanguages = Locale.preferredLanguages
    }
    static var shared = AppLocale()
    
    
    ///    Builds as specific LocaleIdentifier as your app needs
    private var localeIdentifier: String {
        //    start with whatever was the iOS original
        var comps = NSLocale.components(fromLocaleIdentifier: original.identifier)
        
        //    Note: if customer has not yet chosen anything custom,
        //    then it may make sense to default to primary language on his device
        //    then load your app-level overrides
        //        for (key, value) in AppConfig.localeOverrides {
        //            comps[key] = value
        //        }
        //    then potentially load customer-account-level overrides (from say back-end API)
        //        for (key, value) in Customer.localeOverrides {
        //            comps[key] = value
        //        }
        //    then override the language with current in-app choice
        if let languageCode = UserDefaults.languageCode {
            comps[NSLocale.Key.languageCode.rawValue] = languageCode
        }
        
        if let regionCode = UserDefaults.regionCode ?? original.regionCode {
            comps[NSLocale.Key.countryCode.rawValue] = regionCode
        }
        
        //    WARNING:
        //    user language must be one of the ones available in the app
        //    so make sure that whatever ends up as result, it actually has its own .lproj file
        //    this is good moment to make sanity checks
        //    finally return all of those settings combined
        let identifier = NSLocale.localeIdentifier(fromComponents: comps)
        return identifier
    }
    
    class var identifier: String { return shared.localeIdentifier }
}

extension NSLocale {
    
    ///    This is used to override `current`. It uses `AppLocale.identifier`
    @objc class var app: Locale {
        return Locale(identifier: AppLocale.identifier)
    }
    
    @objc class var appPreferredLanguages: [String] {
        var arr = AppLocale.shared.originalPreferredLanguages
        if let languageCode = UserDefaults.languageCode, !arr.contains(languageCode) {
            arr.insert(languageCode, at: 0)
        }
        return arr
    }
    
    fileprivate static func swizzle(selector: Selector, with replacement: Selector) {
        let originalSelector = selector
        let swizzledSelector = replacement
        let originalMethod = class_getClassMethod(self, originalSelector)!
        let swizzledMethod = class_getClassMethod(self, swizzledSelector)!
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}

extension Locale {
    ///    This should be set to the language you used as Base localization
    fileprivate static var fallbackLanguageCode: String { return AppLocale.shared.original.languageCode ?? "en" }
    
    ///    There is no sensible default for regionCode, as customers can be anywhere.
    ///    Thus optional String
    fileprivate static var fallbackRegionCode: String? { return AppLocale.shared.original.regionCode }
    
    
    ///    Saves chosen language and (optional) region code to UserDefaults so they can be restored on future app starts
    ///
    /// - Parameters:
    ///   - code: two-letter ISO 639-1 language code
    ///   - regionCode: two-letter ISO 3166-1 code
    fileprivate static func enforceLanguage(code: String, regionCode: String? = nil) {
        //    save this choice so it's automatically loaded on next cold start of the app
        UserDefaults.languageCode = code
        UserDefaults.regionCode = regionCode
        
        //    load translated bundle for the chosen language
        Bundle.enforceLanguage(code)
        
        //    update all cached stuff in the app
        DateFormatter.resetupCashed()
        NumberFormatter.resetupCashed()
    }
    
    
    ///    Call this from wherever in the app's UI you are allowing the customer to change the language / region
    ///
    /// - Parameters:
    ///   - code: two-letter ISO 639-1 language code
    ///   - regionCode: two-letter ISO 3166-1 code
    static func updateLanguage(code: String, regionCode: String? = nil) {
        enforceLanguage(code: code, regionCode: regionCode)
        
        //    post notification so the app views can update themselves
        NotificationCenter.default.post(name: NSLocale.currentLocaleDidChangeNotification, object: Locale.current)
    }
    
    
    ///    Removes saved language/region from UserDefaults,
    ///    removes the custom translation bundle, resets Formatter cache,
    ///    posts notification so views can update themselves
    static func clearInAppOverrides() {
        UserDefaults.languageCode = nil
        UserDefaults.regionCode = nil
        
        Bundle.clearInAppOverrides()
        
        //    update all cached stuff in the app
        DateFormatter.resetupCashed()
        NumberFormatter.resetupCashed()
        
        //    post notification so the app views can update themselves
        NotificationCenter.default.post(name: NSLocale.currentLocaleDidChangeNotification, object: Locale.current)
    }
    
    
    ///    Call this as early as possible in application lifecycle,
    ///    say in `application(_:willFinishLaunchingWithOptions:)`
    static func setupInitialLanguage() {
        
        let _ = AppLocale.shared
        
        NSLocale.swizzle(selector: #selector(getter: NSLocale.current), with: #selector(getter: NSLocale.app))
        NSLocale.swizzle(selector: #selector(getter: NSLocale.preferredLanguages), with: #selector(getter: NSLocale.appPreferredLanguages))
        
        //    if there is language chosen in-app, then restore that choice
        if let languageCode = UserDefaults.languageCode {
            let regionCode = UserDefaults.regionCode
            enforceLanguage(code: languageCode, regionCode: regionCode)
            
            //    post notification so the app views can update themselves
            NotificationCenter.default.post(name: NSLocale.currentLocaleDidChangeNotification, object: Locale.current)
            return
        }
        
        //    If customer has never chosen any language overrides,
        //    then it would fallback to original Locale.current
        Locale.updateLanguage(code: RSettings.language ?? "")
    }
    
    
    ///    Returns `true` if given Locale uses right to left direction
    var isRightToLeft: Bool {
        guard let languageCode = languageCode else { return false }
        return Locale.characterDirection(forLanguage: languageCode) == .rightToLeft
    }
}

extension UserDefaults {
    private enum Key : String {
        case languageCode = "LanguageCode"
        case regionCode = "RegionCode"
    }
    
    static var languageCode: String? {
        get {
            let defs = UserDefaults.standard
            return defs.string(forKey: Key.languageCode.rawValue)
        }
        set(value) {
            let defs = UserDefaults.standard
            if let value = value {
                defs.set(value, forKey: Key.languageCode.rawValue)
                return
            }
            defs.removeObject(forKey: Key.languageCode.rawValue)
        }
    }
    
    static var regionCode: String? {
        get {
            let defs = UserDefaults.standard
            return defs.string(forKey: Key.regionCode.rawValue)
        }
        set(value) {
            let defs = UserDefaults.standard
            if let value = value {
                defs.set(value, forKey: Key.regionCode.rawValue)
                return
            }
            defs.removeObject(forKey: Key.regionCode.rawValue)
        }
    }
}

public final class LocalizedBundle: Bundle {
    ///    Overrides system method and enforces usage of particular .lproj translation bundle
    override public func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = Bundle.main.localizedBundle {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        }
        return super.localizedString(forKey: key, value: value, table: tableName)
    }
}


public extension Bundle {
    private struct AssociatedKeys {
        static var lmb = "LocalizedMainBundle"
    }
    
    fileprivate var localizedBundle: Bundle? {
        get {
            //    warning: Make sure this object you are fetching really exists
            return objc_getAssociatedObject(self, &AssociatedKeys.lmb) as? Bundle
        }
    }
    
    /// Loads the translations for the given language code.
    ///
    /// - Parameter code: two-letter ISO 639-1 language code
    static func enforceLanguage(_ code: String) {
        guard let path = Bundle.main.path(forResource: code, ofType: "lproj") else { return }
        guard let bundle = Bundle(path: path) else { return }
        
        //    prepare translated bundle for chosen language and
        //    save it as property of the Bundle.main
        objc_setAssociatedObject(Bundle.main, &AssociatedKeys.lmb, bundle, .OBJC_ASSOCIATION_RETAIN)
        
        //    now override class of the main bundle (only once during the app lifetime)
        //    this way, `localizedString(forKey:value:table)` method in our subclass above will actually be called
        DispatchQueue.once(token: AssociatedKeys.lmb)  {
            object_setClass(Bundle.main, LocalizedBundle.self)
        }
    }
    
    
    ///    Removes the custom bundle
    static func clearInAppOverrides() {
        objc_setAssociatedObject(Bundle.main, &AssociatedKeys.lmb, nil, .OBJC_ASSOCIATION_RETAIN)
    }
}

public extension DispatchQueue {
    private static var onceTracker = [String]()
    
    ///    Execute the given `block` only once during app's lifecycle
    class func once(token: String, block: () -> Void) {
        objc_sync_enter(self);
        defer {
            objc_sync_exit(self)
        }
        
        if onceTracker.contains(token) { return }
        onceTracker.append(token)
        block()
    }
}

extension NumberFormatter {
    
    static let moneyFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.generatesDecimalNumbers = true
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 2
        nf.numberStyle = .decimal
        return nf
    }()
    
    static func resetupCashed() {
        moneyFormatter.locale = Locale.current
    }
}


extension DateFormatter {
    
    static let dobFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .full
        return df
    }()
    
    static func resetupCashed() {
        dobFormatter.locale = Locale.current
    }
}
