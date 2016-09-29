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
    fileprivate let MAIN_CELL_ID = "main_cell_id"
    fileprivate lazy var cellTitles: NSMutableArray = NSMutableArray(array: ["jpg和png转化", "gif图片分解", "gif动画展示", "gif图片合成", "webp格式"])
    fileprivate var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "UIImageView知识拓展"

        setTableView()
    }

    func setTableView() {
        tableView = UITableView(frame: UIScreen.main.bounds, style: UITableViewStyle.plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 44
        tableView.sectionFooterHeight = 0.1
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MAIN_CELL_ID)
        //设置cell的分割线使其从最左边开始绘制
        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsets.zero
        }
        if tableView.responds(to: #selector(setter: UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsets.zero
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MAIN_CELL_ID, for: indexPath)
        cell.textLabel?.text = cellTitles[(indexPath as NSIndexPath).row] as? String
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.textColor = UIColor.black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(TestViewController(index: (indexPath as NSIndexPath).row), animated: true)
    }
    
    //重写绘制cell的代理方法，设置cell的分割线使其从最左边开始绘制
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
        
    }
}

