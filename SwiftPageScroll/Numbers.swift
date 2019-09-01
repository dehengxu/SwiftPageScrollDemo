//
//  Numbers.swift
//  SwiftPageScroll
//
//  Created by HenryX on 2017/8/17.
//  Copyright © 2017年 DehengXu. All rights reserved.
//

import Foundation
import UIKit

extension Float {
    
    var CGFloatValue :CGFloat {
        get {
            return CGFloat(self)
        }
        set {
            self = Float(newValue)
        }
    }
    
    var IntValue :Int {
        get {
            return Int(self)
        }
        set {
            self = Float(newValue)
        }
    }
    
    var UIntValue :UInt {
        get {
            return UInt(self)
        }
        set {
            self = Float(newValue)
        }
    }
    
}

extension UInt {
    var CGFloatValue :CGFloat {
        get {
            return CGFloat(self)
        }
    }
    
    var FloatValue :Float {
        get {
            return Float(self)
        }
    }
    
    var IntValue :Int {
        get {
            return Int(self)
        }
    }
}

extension Int {
    var CGFloatValue :CGFloat {
        get {
            return CGFloat(self)
        }
    }
    
    var FloatValue :Float {
        get {
            return Float(self)
        }
    }
    
    var UIntValue :Int {
        get {
            return self
        }
        set {
            self = Int(newValue)
        }
    }
}
