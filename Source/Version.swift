//
//  Version.swift
//  Device
//
//  Created by Lucas Ortis on 30/10/2015.
//  Copyright © 2015 Ekhoo. All rights reserved.
//

import Foundation

public enum Version: NSString {
    /*** iPhone ***/
    case iPhone4
    case iPhone4S
    case iPhone5
    case iPhone5C
    case iPhone5S
    case iPhone6
    case iPhone6Plus
    case iPhone6S
    case iPhone6SPlus
    case iPhoneSE
    case iPhone7
    case iPhone7Plus
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXS
    case iPhoneXR
    case iPhoneXSMax
    
    /*** iPad ***/
    case iPad1
    case iPad2
    case iPad3
    case iPad4
    case iPad5
    case iPadAir
    case iPadAir2
    case iPadMini
    case iPadMini2
    case iPadMini3
    case iPadMini4
    case iPadPro9_7Inch
    case iPadPro12_9Inch
    
    /*** iPod ***/
    case iPodTouch1Gen
    case iPodTouch2Gen
    case iPodTouch3Gen
    case iPodTouch4Gen
    case iPodTouch5Gen
    case iPodTouch6Gen
    
    /*** simulator ***/
    case simulator
    
    /*** unknown ***/
    case unknown
}
