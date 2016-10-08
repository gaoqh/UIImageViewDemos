//
//  UIAlertViewExtensions.swift
//  DiamondClient
//
//  Created by gaoqinghua on 16/1/2.
//  Copyright © 2016年 hiersun. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertView{
    //登录提示
    class func loginAlertViewShow(delegate:UIAlertViewDelegate) -> UIAlertView{

        let loginAlert = UIAlertView(title: "", message: "您还没有登录", delegate: delegate, cancelButtonTitle: "取消", otherButtonTitles: "确定")
        loginAlert.show()
        return loginAlert
    }
}
extension UIAlertController {
    class func anyAlertViewShow(title:String,controller:UIViewController,handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title,
            message: "", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        let okAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.default,
            handler: handler)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    class func anyAlertViewTitleShow(title:String,controller:UIViewController,okTitle:String = "确认",cancelTitle:String = "取消",handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title,
            message: "", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: cancelTitle, style: UIAlertActionStyle.cancel, handler: nil)
        let okAction = UIAlertAction(title: okTitle, style: UIAlertActionStyle.default,
            handler: handler)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    class func anyAlertViewShow(title:String,controller:UIViewController, okHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title,
            message: "", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: cancelHandler)
        let okAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.default,
            handler: okHandler)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
}
