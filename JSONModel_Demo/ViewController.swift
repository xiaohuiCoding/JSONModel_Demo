//
//  ViewController.swift
//  JSONModel_Demo
//
//  Created by xiaohui on 2017/3/31.
//  Copyright © 2017年 xiaohui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFromLocalJSONFile()
        loadFromSwiftJSONObject()
    }

    func loadFromLocalJSONFile() {
        
        guard let filePath = Bundle.main.path(forResource: "data", ofType: "json") else {
            print("读取本地JSON文件失败！")
            return
        }
        
        // 将文件转化为data
        let data = NSData(contentsOfFile: filePath) as! Data
        
        // 将data转化为string
        let str = String(data: data, encoding: .utf8)!
        print(str)
        
        // 将data转化为JSON对象
        let jsonObject: AnyObject = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        print(jsonObject)
        
        // 使用JSON对象
        let videoList: AnyObject = jsonObject.object(forKey: "videoList") as AnyObject
        print(videoList)
    }
    
    func loadFromSwiftJSONObject() {
        
        // 给定一个对象
        let object = [
            "userName": "张三",
            "tel": ["mobile": "138xxx6666", "home": "010123456"]
        ] as [String : Any]
        
        // 判断一个给定的对象是否可以转换为JSON数据
        guard JSONSerialization.isValidJSONObject(object) else {
            print("无效的Swift对象！")
            return
        }
        
        // 将对象转化为data
        let data = try! JSONSerialization.data(withJSONObject: object, options: []) as Data
        
        // 将data转化为string
        let str = String(data: data, encoding: .utf8)!
        print(str)
        
        // 将data转化为JSON对象
        let jsonObject: AnyObject = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        print(jsonObject)
        
        // 使用JSON对象
        let userName: AnyObject = jsonObject.object(forKey: "userName") as AnyObject
        print(userName)
        
        let mobile: AnyObject = (jsonObject.object(forKey: "tel") as AnyObject).object(forKey: "mobile") as AnyObject
        print(mobile)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

