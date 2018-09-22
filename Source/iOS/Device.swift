//
//  Device.swift
//  Device
//
//  Created by Lucas Ortis on 30/10/2015.
//  Copyright © 2015 Ekhoo. All rights reserved.
//

import UIKit

@objc
open class Device: NSObject {
    static fileprivate func getVersionCode() -> NSString {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let versionCode: String = String(validatingUTF8: NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)!.utf8String!)!
        
        return versionCode as NSString
    }
    
    static fileprivate func getVersionInSimulator() -> Version {
        
        if UIScreen.main.bounds.size.equalTo(CGSize(width: 320, height: 568))  {
            return .iPhoneSE // iPhone 5, 5C, 5S, iPod Touch 5g
        }
        if UIScreen.main.bounds.size.equalTo(CGSize(width: 375, height: 667))  {
            return .iPhone7 // iPhone 6, iPhone 6s, iPhone 7
        }
        if UIScreen.main.bounds.size.equalTo(CGSize(width: 414, height: 736))  {
            return .iPhone7Plus // iPhone 6 Plus, iPhone 6s Plus, iPhone 7 Plus
        }
        if UIScreen.main.bounds.size.equalTo(CGSize(width: 768, height: 1024))  {
            return .iPadMini // iPad Mini 2, iPad Mini 3, iPad Mini 4, iPad 3, iPad 4, iPad Air, iPad Air 2, 9.7-inch iPad Pro
        }
        if UIScreen.main.bounds.size.equalTo(CGSize(width: 834, height: 1112))  {
            return .iPadPro9_7Inch
        }
        if UIScreen.main.bounds.size.equalTo(CGSize(width: 1024, height: 1366))  {
            return .iPadPro12_9Inch // 12.9-inch iPad Pro
        }
        if UIScreen.main.bounds.size.equalTo(CGSize(width: 375, height: 812))  {
            return .iPhoneXS // iPhoneXS or iPhoneX
        }
        if UIScreen.main.bounds.size.equalTo(CGSize(width: 414, height: 896))  {
            return .iPhoneXSMax // iPhoneXR or iPhoneXSMax
        }
        
        return .unknown
    }
    
    static fileprivate func getVersion(code: NSString) -> Version {
        switch code {
            /*** iPhone ***/
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":      return .iPhone4
            case "iPhone4,1", "iPhone4,2", "iPhone4,3":      return .iPhone4S
            case "iPhone5,1", "iPhone5,2":                   return .iPhone5
            case "iPhone5,3", "iPhone5,4":                   return .iPhone5C
            case "iPhone6,1", "iPhone6,2":                   return .iPhone5S
            case "iPhone7,2":                                return .iPhone6
            case "iPhone7,1":                                return .iPhone6Plus
            case "iPhone8,1":                                return .iPhone6S
            case "iPhone8,2":                                return .iPhone6SPlus
            case "iPhone8,4":                                return .iPhoneSE
            case "iPhone9,1", "iPhone9,3":                   return .iPhone7
            case "iPhone9,2", "iPhone9,4":                   return .iPhone7Plus
            case "iPhone10,1", "iPhone10,4":                 return .iPhone8
            case "iPhone10,2", "iPhone10,5":                 return .iPhone8Plus
            case "iPhone10,3", "iPhone10,6":                 return .iPhoneX
            case "iPhone11,2":                               return .iPhoneXS
            case "iPhone11,8":                               return .iPhoneXR
            case "iPhone11,4", "iPhone11,6":                 return .iPhoneXSMax

            /*** iPad ***/
            case "iPad1,1":                                  return Version.iPad1
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return Version.iPad2
            case "iPad3,1", "iPad3,2", "iPad3,3":            return Version.iPad3
            case "iPad3,4", "iPad3,5", "iPad3,6":            return Version.iPad4
            case "iPad6,11", "iPad6,12":                     return Version.iPad5
            case "iPad4,1", "iPad4,2", "iPad4,3":            return Version.iPadAir
            case "iPad5,3", "iPad5,4":                       return Version.iPadAir2
            case "iPad2,5", "iPad2,6", "iPad2,7":            return Version.iPadMini
            case "iPad4,4", "iPad4,5", "iPad4,6":            return Version.iPadMini2
            case "iPad4,7", "iPad4,8", "iPad4,9":            return Version.iPadMini3
            case "iPad5,1", "iPad5,2":                       return Version.iPadMini4
            case "iPad6,7", "iPad6,8":                       return Version.iPadPro12_9Inch
            case "iPad6,3", "iPad6,4":                       return Version.iPadPro9_7Inch
            
            /*** iPod ***/
            case "iPod1,1":                                  return .iPodTouch1Gen
            case "iPod2,1":                                  return .iPodTouch2Gen
            case "iPod3,1":                                  return .iPodTouch3Gen
            case "iPod4,1":                                  return .iPodTouch4Gen
            case "iPod5,1":                                  return .iPodTouch5Gen
            case "iPod7,1":                                  return .iPodTouch6Gen
            
            /*** Simulator ***/
            case "i386", "x86_64":                           return getVersionInSimulator()

            default:                                         return .unknown
        }
    }
    
    static fileprivate func getType(code: NSString) -> Type {
        let versionCode = getVersionCode()
        
        if versionCode.contains("iPhone") {
            return .iPhone
        } else if versionCode.contains("iPad") {
            return .iPad
        } else if versionCode.contains("iPod") {
            return .iPod
        } else if versionCode == "i386" || versionCode == "x86_64" {
            return .simulator
        } else {
            return .unknown
        }
    }

    static public func version() -> Version {
        return getVersion(code: getVersionCode())
    }
    
    static public func versionString() -> NSString {
        return getVersion(code: getVersionCode()).rawValue
    }
    
    static public func size() -> Size {
        let w: Double = Double(UIScreen.main.bounds.width)
        let h: Double = Double(UIScreen.main.bounds.height)
        let screenHeight: Double = max(w, h)
        
        switch screenHeight {
            case 480:
                return .screen3_5Inch
            case 568:
                return .screen4Inch
            case 667:
                return UIScreen.main.scale == 3.0 ? .screen5_5Inch : .screen4_7Inch
            case 736:
                return .screen5_5Inch
            case 1024:
                switch getVersion(code: getVersionCode()) {
                    case .iPadMini,.iPadMini2,.iPadMini3,.iPadMini4:
                        return .screen7_9Inch
                    default:
                        return .screen9_7Inch
                }
            case 1366:
                return .screen12_9Inch
            default:
                return .unknownSize
        }
    }
    
    static public func type() -> Type {
        return getType(code: getVersionCode())
    }
    
    static public func typeString() -> NSString {
        return getType(code: getVersionCode()).rawValue as NSString
    }

    @available(*, deprecated, message: "use == operator instead")
    static public func isEqualToScreenSize(_ size: Size) -> Bool {
        return size == self.size() ? true : false;
    }

    @available(*, deprecated, message: "use > operator instead")
    static public func isLargerThanScreenSize(_ size: Size) -> Bool {
        return size.rawValue < self.size().rawValue ? true : false;
    }

    @available(*, deprecated, message: "use < operator instead")
    static public func isSmallerThanScreenSize(_ size: Size) -> Bool {
        return size.rawValue > self.size().rawValue ? true : false;
    }
    
    static public func isRetina() -> Bool {
        return UIScreen.main.scale > 1.0
    }

    static public func isPad() -> Bool {
        return type() == .iPad
    }
    
    static public func isPhone() -> Bool {
        return type() == .iPhone
    }
    
    static public func isPod() -> Bool {
        return type() == .iPod
    }
    
    static public func isSimulator() -> Bool {
        return type() == .simulator
    }
    
    static public func isNotchDesignPhone() -> Bool {
        let version: Version = Device.version()
        var returnValue = false
        if version == .iPhoneX || version == .iPhoneXS || version == .iPhoneXR || version == .iPhoneXSMax {
            returnValue = true
        }
        return returnValue
    }
    
    static public func isPlusSizePhone() -> Bool {
        let version: Version = Device.version()
        var returnValue = false
        if version == .iPhone6Plus || version == .iPhone6SPlus || version == .iPhone7Plus || version == .iPhone8Plus {
            returnValue = true
        }
        return returnValue
    }
    
}
