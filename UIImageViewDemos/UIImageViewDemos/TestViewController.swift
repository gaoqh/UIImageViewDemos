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

let scale = UIScreen.main.scale
class TestViewController: UIViewController {
    //MARK: - 属性
    fileprivate var index: Int?
    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.index = index
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        switch index! {
        case 0:
            jpgToPng()
        case 1:
            gifDecompose()
        case 2:
            gifAnimation()
        case 3:
            createGif()
        default:break
        }
    }
    //MARK: - 0
    fileprivate func jpgToPng() {
        //jpg转化png
        let image = UIImage(named: "3.jpg")
        let data = UIImagePNGRepresentation(image!)
        let imagePng = UIImage(data: data!)
        UIImageWriteToSavedPhotosAlbum(imagePng!, nil, nil, nil)
        //jpg转化jpg
//        let image = UIImage(named: "3.jpg")
//        let data = UIImageJPEGRepresentation(image!, 1)
//        let imageJpg = UIImage(data: data!)
//        UIImageWriteToSavedPhotosAlbum(imageJpg!, nil, nil, nil)
    }
    //MARK: - 1、gif分解
    fileprivate func gifDecompose() {
        //1 拿到gif数据
        guard let gifPathSource = Bundle.main.url(forResource: "1", withExtension: ".gif"), let data = NSData(contentsOf: gifPathSource) else {
            print("gif文件读取失败")
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
                print("图片写入失败")
            }
        }
        
    }
    //MARK: - 2、gif展示
    private func gifAnimation() {
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
    private func createGif() {
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

}
