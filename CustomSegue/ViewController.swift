//
//  ViewController.swift
//  CustomSegue
//
//  Created by luojie on 16/7/7.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func back(segue: UIStoryboardSegue) {}
    
}

extension ViewController: HasCircularRevealCenter {
    var circularRevealCenter: CGPoint {
        return view.center
    }
}

