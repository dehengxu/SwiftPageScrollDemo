//
//  PresentationScrollView.swift
//  SwiftPageScroll
//
//  Created by HenryX on 2017/8/17.
//  Copyright © 2017年 DehengXu. All rights reserved.
//

import Foundation

//
//  TCLiveProgramPresentationView.swift
//  TCFinance
//
//  Created by HenryX on 2017/8/16.
//  Copyright © 2017年 Tiancai. All rights reserved.
//

import Foundation
import UIKit

let colors :[UIColor] = [UIColor.red, UIColor.yellow, UIColor.black,
                         UIColor.cyan, UIColor.orange, UIColor.lightGray,
                         UIColor.blue, UIColor.brown, UIColor.green]

extension UIScrollView {
    
    func initPresentation(pageSize :CGSize, pageCount :UInt) {
        //self.contentSize = CGSize(width: (self.frame.size.width + CGFloat(0)) * CGFloat(pageCount), height: self.height)
        var h = 20, v = 20

        self.initPresentation(pageCount: pageCount)
        
    }
    
    func initPresentation(pageCount :UInt) {
        self.contentSize = CGSize(width: pageCount.CGFloatValue * self.frame.size.width, height: 60)
        self.isPagingEnabled = true
        self.bounces = false
        self.showsHorizontalScrollIndicator = true
        self.showsVerticalScrollIndicator = true
        self.backgroundColor = UIColor.lightGray
        self.clipsToBounds = false
    }
    
}

class PageView : UIView {
    
    var contentView :UIView!/* {
        willSet {
            if contentView != nil {
                contentView.removeFromSuperview()
            }
        }
        didSet {
            self.addSubview(contentView)
        }
    }*/
}

class PresentationScrollView<ContentType :UIView> : UIScrollView, UIScrollViewDelegate {
    
    var pageViews :[PageView] = []
    
    var gridWidth :Float = 170, gridHeight :Float = 90
    var gaps :Float = 1.0
    var pageSize :CGSize = CGSize.zero
    let scaleMin :Float = 0.87
    let scaleMax :Float = 1.0
    let scaleSpreadProtect :Float = 10.0
    let scaleSpreadLength :Float = 30.0
    var pageCount :UInt = 3
    var currentView :UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //self.addSubview(self.scrollView)
    }
    
    convenience init(frame: CGRect, pageSize: CGSize = CGSize.zero, count :UInt = 1) {
        self.init(frame: frame)
        self.pageSize = pageSize
        self.pageCount = count
        
        self.initSubviews()
        self.initPresentation(pageSize: pageSize, pageCount: self.pageCount)
    }
    
    func initSubviews() {
        
        self.delegate = self
        
        self.updateDatas(datas: ["", "", "", "", ""])
        
    }
    
    func createPageView(withImageView imageView:UIImageView?) -> PageView {
        
        let pageView = PageView(frame: CGRect.zero)
        let imageView :UIImageView! = (imageView == nil) ? UIImageView() : imageView
        
        pageView.contentView = imageView
        pageView.addSubview(imageView)
        
        pageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: pageView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0))
        pageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: pageView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0))
        
        pageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: pageView, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1.0, constant: 0))
        pageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: pageView, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1.0, constant: 0))
        
        pageView.layer.masksToBounds = true
        pageView.layer.cornerRadius = 3.5
        
        return pageView
    }
    
    override func layoutSubviews() {
        
        var i = 0
        for page in self.pageViews {
            print("\(page.contentView)")
            page.contentView.backgroundColor = colors[i]
            i += 1
        }
        
        self.updateViewsScale()
    }
    
    func loadAutoLayout() {
        //Center point
//        self.addConstraint(NSLayoutConstraint.init(item: self.scrollView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0))
//        self.addConstraint(NSLayoutConstraint.init(item: self.scrollView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0))
//        //Size
//        self.addConstraint(NSLayoutConstraint.init(item: self.scrollView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0))
//        self.addConstraint(NSLayoutConstraint.init(item: self.scrollView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 0))
//        
    }
    
    func updateScaleFactor(target :UIView) -> Float {
        let r = abs(target.x + target.width / 2.0 - self.contentOffset.x - (self.width / 2.0))
        
        //print("centex :\(target.center.x), offsetx :\(self.contentOffset.x)")
        let ratio = (scaleSpreadLength - (Float(r))) / scaleSpreadLength
        print("r :\(r), ratio :\(ratio)")
        
        if ratio > scaleMin {
            return ratio
        }
        return scaleMin
    }
    
    func updateViewsScale() {
        for page in self.pageViews {
            var scale = updateScaleFactor(target: page)
            page.layer.contentsScale = scale.CGFloatValue
            //UIView.beginAnimations("a", context: nil)
            page.layer.transform = CATransform3DScale(CATransform3DIdentity, scale.CGFloatValue, scale.CGFloatValue, 1.0)
            //UIView.commitAnimations()
            //})
        }
    }
    
    func updateDatas(datas :[Any]?) {
        
        if (datas?.count) == nil {
            return
        }
        
        for page in self.pageViews {
            page.removeFromSuperview()
        }
        
        self.pageViews.removeAll()
        self.pageCount = UInt(datas!.count)
        
        
        for i in 0..<self.pageCount {
            
            let page = createPageView(withImageView: nil)
            print("\(CGPoint(x: CGFloat(i) * self.width + (self.width - pageSize.width) / 2.0, y: (self.height - pageSize.height) / 2.0))")
            //page.origin = CGPoint(x: CGFloat(i) * self.width + 10, y: 10)
            page.size = self.pageSize
            page.contentView.size = self.pageSize
            page.center = CGPoint(x: self.width / 2.0 + (i.CGFloatValue * self.width), y: self.height / 2.0)
            
            page.contentView.backgroundColor = colors[Int(i)]
            self.addSubview(page)
            self.pageViews.append(page)
        }

        self.initPresentation(pageCount: self.pageCount)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //var scale = updateScaleFactor(target: self.pageViews[1])
        //print("scale :\(scale)")
        updateViewsScale()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("did end decelerating scrolling")
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return self
    }
    
}
