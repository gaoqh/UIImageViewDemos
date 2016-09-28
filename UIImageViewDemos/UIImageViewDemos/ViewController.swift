//
//  ViewController.swift
//  UIImageViewDemos
//
//  Created by gaoqinghua on 16/9/28.
//  Copyright © 2016年 gaoqinghua. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - 属性
    private let MAIN_CELL_ID = "main_cell_id"
    private lazy var cellTitles: NSMutableArray = NSMutableArray(array: ["jpg和png转化", "gif图片分解", "gif动画展示", "gif图片合成", "webp格式"])
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "UIImageView知识拓展"

        setTableView()
    }

    func setTableView() {
        tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.rowHeight = 44
        tableView.sectionFooterHeight = 0.1
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: MAIN_CELL_ID)
        //设置cell的分割线使其从最左边开始绘制
        if tableView.respondsToSelector(Selector("setSeparatorInset:")) {
            tableView.separatorInset = UIEdgeInsetsZero
        }
        if tableView.respondsToSelector(Selector("setLayoutMargins:")) {
            tableView.layoutMargins = UIEdgeInsetsZero
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MAIN_CELL_ID, forIndexPath: indexPath)
        cell.textLabel?.text = cellTitles[indexPath.row] as? String
        cell.textLabel?.font = UIFont.systemFontOfSize(14)
        cell.textLabel?.textColor = UIColor.blackColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        navigationController?.pushViewController(TestViewController(index: indexPath.row), animated: true)
    }
    
    //重写绘制cell的代理方法，设置cell的分割线使其从最左边开始绘制
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell.respondsToSelector(Selector("setSeparatorInset:")) {
            cell.separatorInset = UIEdgeInsetsZero
        }
        if cell.respondsToSelector(Selector("setLayoutMargins:")) {
            cell.layoutMargins = UIEdgeInsetsZero
        }
        
    }
}

