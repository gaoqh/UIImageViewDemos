//
//  TestViewController.swift
//  UIImageViewDemos
//
//  Created by gaoqinghua on 16/9/28.
//  Copyright © 2016年 gaoqinghua. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    //MARK: - 属性
    private var index: Int?
    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.index = index
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        switch index! {
        case 0:
            jpgToPng()
        default:break
        }
    }
    
    private func jpgToPng() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
