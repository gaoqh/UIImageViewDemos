//
//  TestViewController.swift
//  UIImageViewDemos
//
//  Created by gaoqinghua on 16/9/28.
//  Copyright © 2016年 gaoqinghua. All rights reserved.
//

import UIKit
import ImageIO
import MobileCoreServices
import QuartzCore
import Accelerate

let scale = UIScreen.main.scale
let SCREENW = UIScreen.main.bounds.width
let SCREENH = UIScreen.main.bounds.height
class TestViewController: UIViewController {
    //MARK: - 属性
    fileprivate var index: Int?
    fileprivate var btn1: UIButton!
    fileprivate var rotateImage: UIImage?
    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.index = index
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        btn1 = UIButton(type: UIButtonType.custom)
        btn1.frame.size = CGSize(width: 100, height: 44)
        btn1.frame.origin = CGPoint(x: SCREENW * 0.5 - btn1.frame.size.width * 0.5, y: SCREENH - 100)
        btn1.setTitle("按钮", for: UIControlState.normal)
        btn1.layer.borderWidth = 1
        btn1.layer.cornerRadius = 4
        btn1.layer.borderColor = UIColor.blue.cgColor
        btn1.backgroundColor = UIColor.white
        btn1.setTitleColor(UIColor.blue, for: UIControlState.normal)
        view.backgroundColor = UIColor.white
        switch index! {
        case 0:
            btn1.addTarget(self, action: #selector(TestViewController.jpgToPng), for: UIControlEvents.touchUpInside)
        case 1:
            btn1.addTarget(self, action: #selector(TestViewController.gifDecompose), for: UIControlEvents.touchUpInside)
        case 2:
            btn1.addTarget(self, action: #selector(TestViewController.gifAnimation), for: UIControlEvents.touchUpInside)
        case 3:
//            btn1.addTarget(self, action: #selector(TestViewController.createGif), for: UIControlEvents.touchUpInside)
            toBeContinued()
        case 4:
//            btn1.addTarget(self, action: #selector(TestViewController.showImage), for: UIControlEvents.touchUpInside)
            toBeContinued()
        default:break
        }
        view.addSubview(btn1)
        
    }
    //MARK: - 常用方法
    //图片写入相册 完成
    func finishedWriteToPhotosAlbum() {
        UIAlertController.anyAlertViewShow(title: "图片已写入相册", controller: self, handler: nil)
    }
    //待开发的提示
    func toBeContinued() {
        UIAlertController.anyAlertViewShow(title: "暂未开发，敬请期待", controller: self) { [weak self] action in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    //MARK: - 0、jpg和png互相转换
    func jpgToPng() {
        //jpg转化png
        let image = UIImage(named: "3.jpg")
        let data = UIImagePNGRepresentation(image!)
        let imagePng = UIImage(data: data!)
        UIImageWriteToSavedPhotosAlbum(imagePng!, self, #selector(TestViewController.finishedWriteToPhotosAlbum), nil)
        UIAlertController.anyAlertViewShow(title: "jpg图片已成功转化为png格式", controller: self, handler: nil)
        //jpg转化jpg
//        let image = UIImage(named: "3.jpg")
//        let data = UIImageJPEGRepresentation(image!, 1)
//        let imageJpg = UIImage(data: data!)
//        UIImageWriteToSavedPhotosAlbum(imageJpg!, nil, nil, nil)
    }
    //MARK: - 1、gif分解
    func gifDecompose() {
        //1 拿到gif数据
        guard let gifPathSource = Bundle.main.url(forResource: "1", withExtension: ".gif"), let data = NSData(contentsOf: gifPathSource) else {
            UIAlertController.anyAlertViewShow(title: "gif文件读取失败", controller: self, handler: nil)
            return
        }
        let source = CGImageSourceCreateWithData(CFDataCreate(kCFAllocatorDefault, UnsafePointer(OpaquePointer(data.bytes)), data.length), nil)
    
        let count = CGImageSourceGetCount(source!)
        let tmpArray = NSMutableArray()
        var i = 0
        for _ in 0..<count {
            let imageRef = CGImageSourceCreateImageAtIndex(source!, i, nil)
            let image: UIImage = UIImage(cgImage: imageRef!, scale: UIScreen.main.scale, orientation: UIImageOrientation.up)
            tmpArray.add(image)
            i += 1
        }
        var j = 0
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        print(path!)
        for image in tmpArray {
            let data = UIImagePNGRepresentation(image as! UIImage)
            let pathNum = path?.appendingFormat("/%d.png", j)
            j += 1
            do{
                try data?.write(to: URL(fileURLWithPath: pathNum!), options: Data.WritingOptions.atomic)
            }catch {
                UIAlertController.anyAlertViewShow(title: "图片写入失败", controller: self, handler: nil)
            }
        }
        UIAlertController.anyAlertViewShow(title: "图片写入成功，路径是：\(path!)", controller: self, handler: nil)
    }
    //MARK: - 2、gif展示
    func gifAnimation() {
        var imageTmp = [UIImage]()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 100, width: 320 * scale * 0.5, height: 240 * scale * 0.5))
        view.addSubview(imageView)
        
        for i in 0..<50 {
            let image = UIImage(named: "\(i).png")
            imageTmp.append(image!)
        }
        //设置imageView动画属性
        imageView.animationImages = imageTmp as [UIImage]
        imageView.animationRepeatCount = 10
        imageView.animationDuration = 8
        imageView.startAnimating()
    }
    //MARK: - 3、gif图片合成
    func createGif() {
        //1、获取数据
        var images = [UIImage]()
        for i in 0..<50 {
            images.append(UIImage(named: "\(i).png")!)
        }
        //2、创建gif文件
        let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let textDic = documentPath?.appending("/gif")
        do {
            try FileManager.default.createDirectory(atPath: documentPath!, withIntermediateDirectories: true, attributes: nil)
        }catch {
            print("gif图片路径创建失败")
        }
        let path = textDic?.appending("test1.gif")
        print(path)
        //3、配置gif属性
        let url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, path! as CFString!, CFURLPathStyle.cfurlposixPathStyle, false)
        if let destination = CGImageDestinationCreateWithURL(url!, kUTTypeGIF,images.count, nil) {
            let dict = [kCGImagePropertyGIFDelayTime, NSNumber(floatLiteral: 0.3)] as [Any]
            
            var gifParamDict = Dictionary<String, Any>(minimumCapacity: 2)
            gifParamDict[kCGImagePropertyGIFHasGlobalColorMap as String] = NSNumber(booleanLiteral: true)
            gifParamDict[kCGImagePropertyColorModel as String] = kCGImagePropertyColorModelRGB
            gifParamDict[kCGImagePropertyDepth as String] = NSNumber(integerLiteral: 8)
            gifParamDict[kCGImagePropertyGIFLoopCount as String] = NSNumber(integerLiteral: 0)
            
            let gifProperty = [kCGImagePropertyGIFDictionary, gifParamDict] as [Any]
            for image in images {
                CGImageDestinationAddImage(destination, image.cgImage!, nil)
            }
        
//            CGImageDestinationSetProperties(destination, (gifProperty as! CFDictionary))
            CGImageDestinationFinalize(destination)
        }

    }
    //MARK: - 4、UIImage任意形状旋转
    //显示图片
    func showImage() {
        let image = UIImage(named: "3.jpg")
        // 3.14/180
        if let imageNew = rotate(image: image!, withDegree: 45 * 0.01745)    {
            UIImageWriteToSavedPhotosAlbum(imageNew, self, #selector(TestViewController.finishedWriteToPhotosAlbum), nil)
        }
        
    }

    func rotate(image: UIImage, withDegree: CGFloat) -> UIImage?{
//        //1、image渲染到上下文
//        let width = Int(image.size.width * image.scale)
//        let height = Int(image.size.height * image.scale)
//        if let bmContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: 0, releaseCallback: nil, releaseInfo: nil) {
//            print("渲染成功")
//            bmContext.draw(image.cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
//            //2、旋转
//            var src = vImage_Buffer(data: <#T##UnsafeMutableRawPointer!#>, height: <#T##vImagePixelCount#>, width: <#T##vImagePixelCount#>, rowBytes: <#T##Int#>)
//            var dest = vImage_Buffer(data: <#T##UnsafeMutableRawPointer!#>, height: <#T##vImagePixelCount#>, width: <#T##vImagePixelCount#>, rowBytes: <#T##Int#>)
//
//            vImageRotate_ARGB8888(&src, &dest, nil, Float(withDegree), , <#T##flags: vImage_Flags##vImage_Flags#>)
//            //3、上下文转化为UIImage
//            
//            let rotateImage = UIImage(cgImage: <#T##CGImage#>, scale: image.scale, orientation: image.imageOrientation)
//        }
        
        
        
        return nil
        
    }
}
