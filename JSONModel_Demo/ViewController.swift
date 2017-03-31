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
        
        // 使用系统自带的类 NSJSONSerialization 获取JSON数据
        getFromLocalJSONFile()
        getFromSwiftObject()
        getFromSwiftObject2()
        
        
        // 使用三方类 JSONModel 获取JSON数据
        //...
    }

    
    func getFromLocalJSONFile() {
        
//        guard let filePath = Bundle.main.path(forResource: "data", ofType: "json") else {
//            print("读取本地JSON文件失败！")
//            return
//        }
        
        guard let filePath = Bundle.main.path(forResource: "videoData", ofType: "json") else {
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
        let list: AnyObject = jsonObject.object(forKey: "list") as AnyObject
        print(list)
    }
    
    
    func getFromSwiftObject() {
        
        // 给定一个对象
        let object = [
            "userName": "xiaohui",
            "tel": ["mobile": "186xxxx6666", "home": "666666"]
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
    
    
    func getFromSwiftObject2(){
        
        // 给定一个对象
        let string: String = "[{\"name\": \"张三\", \"age\": 10}, {\"name\": \"李四\", \"age\": 20}, {\"name\": \"王五\", \"age\": 30}]"
        
        let data = string.data(using: .utf8)!
        
        // 将data转化为JSON对象
        let jsonObject: AnyObject = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        print(jsonObject)
        
        // 使用JSON对象
        let jsonArray = jsonObject as! NSArray
        
        for json in jsonArray {
            print("name", (json as AnyObject).object(forKey: "name") ?? AnyObject.self)
            print("age", (json as AnyObject).object(forKey: "age") ?? AnyObject.self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

