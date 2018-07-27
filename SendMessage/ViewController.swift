//
//  ViewController.swift
//  SendMessage
//
//  Created by 范文华 on 2018/7/5.
//  Copyright © 2018年 范文华. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var bodyText: UITextField!
    
    @IBOutlet weak var showText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sender(_ sender: UIButton) {
        let phonesList: [String] = ["18123632335", "13318987537", "18588235532"]
        self.showMessageView(phones: phonesList, title: self.titleText.text!, body: self.bodyText.text!)
    }
    
    @IBAction func empty(_ sender: UIButton) {
        self.showText.text = ""
    }
    
    //实现代理方法MFMessageComposeViewControllerDelegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        self.dismiss(animated: true, completion: nil)
        
        switch result {
        case MessageComposeResult.sent:
            //信息传送成功
            self.showText.text = "信息传送成功"
        case MessageComposeResult.failed:
            //信息传送失败
            self.showText.text = "信息传送失败"
        case MessageComposeResult.cancelled:
            //信息被用户取消传送
            self.showText.text = "信息被用户取消传送"
        default:
            self.showText.text = "其他问题"
        }
    }
    
    //发送短信
    func showMessageView(phones: [String], title: String, body: String){
        
        if(MFMessageComposeViewController.canSendText()){
            let controller: MFMessageComposeViewController = MFMessageComposeViewController()
            controller.recipients = phones
            controller.navigationBar.tintColor = UIColor.red
            controller.body = body
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
            //修改短信界面标题
            controller.viewControllers.last?.navigationItem.title = title
        }else{
            let alertController: UIAlertController = UIAlertController(title: "提示信息", message: "该设备不支持短信功能", preferredStyle: UIAlertControllerStyle.alert)
            let action: UIAlertAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}

