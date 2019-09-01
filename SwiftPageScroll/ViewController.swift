//
//  ViewController.swift
//  SwiftPageScroll
//
//  Created by DehengXu on 14/6/13.
//  Copyright (c) 2014年 DehengXu. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var scrollView: UIScrollView?
    var presentView :PresentationScrollView<UIImageView>?
    
    let count:UInt = 3
    var pageSize = CGSize(width: 160, height: 80)
    var viewSize = CGSize(width: 170, height: 90)
    
    var scaleMin = 8.0
    var scaleMax = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initSubviews()
        
        view.addSubview(scrollView!)
        view.addSubview(presentView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func initSubviews() {
        let fm: CGRect = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)//UIScreen.main.bounds
        
        //let gaps :Float = 1
        
        self.scrollView = UIScrollView(frame:CGRect(x: 0, y: 0, width: fm.size.width + CGFloat(0), height: fm.size.height))
        self.scrollView!.contentSize =   CGSize(width: (self.scrollView!.frame.size.width + CGFloat(0)) * CGFloat(count), height: fm.size.height)
        self.scrollView!.backgroundColor = UIColor.red
        self.scrollView!.isPagingEnabled = true
        self.scrollView!.bounces = false
        
        let colors :[UIColor] = [UIColor.gray, UIColor.black, UIColor.white]
        
        for i in 0..<count {
            let offset = CGFloat(i) * fm.size.width
            print("offset :\(offset)")
            let v :UIView =  UIView(frame:  CGRect(x: 10 + CGFloat(i) * self.scrollView!.frame.size.width, y: 10, width: self.pageSize.width, height: self.pageSize.height))
            v.backgroundColor = colors[Int(i)]
            self.scrollView?.addSubview(v);
        }

        self.presentView = PresentationScrollView(frame: CGRect(x: 0, y: 300, width: fm.size.width + CGFloat(0), height: fm.size.height), pageSize: self.pageSize, count: 3)
        self.presentView?.center = CGPoint(x: self.view.centerX, y: (self.presentView?.centerY)!)

        self.presentView?.becomeFirstResponder()
//        for i in 0..<count {
//            let offset = CGFloat(i) * fm.size.width
//            print("offset :\(offset)")
//            let v :UIView =  UIView(frame:  CGRect(x: 10 + CGFloat(i) * self.pageSize.width, y: 10, width: self.pageSize.width, height: self.pageSize.height))
//            v.backgroundColor = colors[Int(i)]
//            self.presentView?.addSubview(v);
//        }
        
    }

    
}

