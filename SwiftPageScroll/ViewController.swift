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
    let count:UInt = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        initSubviews()
        
        view.addSubview(scrollView);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func initSubviews() {
        var fm: CGRect = UIScreen.mainScreen().bounds
        
        var gaps :Float = 20
        
        self.scrollView = UIScrollView(frame:CGRectMake(0, 0, fm.size.width + gaps, fm.size.height))
        self.scrollView!.contentSize =   CGSizeMake(self.scrollView!.frame.size.width * Float(count), fm.size.height)
        self.scrollView!.backgroundColor = UIColor.blackColor()
        self.scrollView!.pagingEnabled = true
        self.scrollView!.bounces = false
        
        for i in 0..count {
            var offset = i * 320
            println("offset :\(offset)")
            var v :UIView =  UIView(frame:  CGRectMake(Float(i) * self.scrollView!.frame.size.width, 0, fm.size.width, fm.size.height))
            v.backgroundColor = UIColor.lightGrayColor()
            self.scrollView?.addSubview(v);
        }
    }

}

