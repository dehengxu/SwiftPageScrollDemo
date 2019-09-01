//
//  UIView_extensions.swift
//  SwiftPageScroll
//
//  Created by HenryX on 2017/8/17.
//  Copyright © 2017年 DehengXu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var x :CGFloat {
        get {
            return self.frame.origin.x
        }
    }
    
    var y :CGFloat {
        get {
            return self.frame.origin.y
        }
        
    }
    
    var width :CGFloat {
        get {
            return self.frame.size.width
        }
        
        set {
            self.frame.size = CGSize(width: newValue, height: self.height)
        }
    }
    
    var height :CGFloat {
        get {
            return self.frame.size.height
        }
        
        set {
            self.frame.size = CGSize(width: self.width, height: newValue)
        }
    }
    
    var origin :CGPoint {
        get {
            return self.frame.origin
        }
        
        set {
            self.frame = CGRect(origin: newValue, size: self.size)//.origin = newValue
        }
    }
    
    var size :CGSize {
        get {
            return self.frame.size
        }
        
        set {
            self.frame = CGRect(origin: self.origin, size: newValue)
        }
    }
    
    var centerX :CGFloat {
        get {
            return self.center.x
        }
    }
    
    var centerY :CGFloat {
        get {
            return self.center.y
        }
    }
}

