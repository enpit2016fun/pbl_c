//
//  FindFurnitureController.swift
//  Fengshui
//
//  Created by 渡邊翼 on 2016/11/11.
//  Copyright © 2016年 渡邊翼. All rights reserved.
//

import UIKit
import SVProgressHUD

class FindFurnitureController: UIViewController,UIWebViewDelegate {
  //var webView: UIWebView!
  
  func dispatch_async_main(block: () -> ()) {
    dispatch_async(dispatch_get_main_queue(), block)
  }
  
  func dispatch_async_global(block: () -> ()) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    let webView : UIWebView = UIWebView()
    webView.delegate = self
    webView.frame = self.view.bounds
    
    let swipeDownGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FindFurnitureController.handleSwipeleft(_:)))

    swipeDownGesture.numberOfTouchesRequired = 1
    swipeDownGesture.direction = UISwipeGestureRecognizerDirection.Right
    self.view.addGestureRecognizer(swipeDownGesture)
    
    
    
    
    self.view.addSubview(webView)
    let url: NSURL = NSURL(string: "https://www.amazon.co.jp/%E5%AE%B6%E5%85%B7-%E3%82%A4%E3%83%B3%E3%83%86%E3%83%AA%E3%82%A2%E3%83%BB%E5%8F%8E%E7%B4%8D%E3%83%BB%E5%AF%9D%E5%85%B7-%E3%82%AD%E3%83%83%E3%83%81%E3%83%B3%EF%BC%86%E7%94%9F%E6%B4%BB%E9%9B%91%E8%B2%A8-%E3%82%AB%E3%83%86%E3%82%B4%E3%83%AA%E3%83%BC%E5%88%A5/b?ie=UTF8&node=16428011")!
    self.dispatch_async_global { // ここからバックグラウンドスレッド
      SVProgressHUD.showWithStatus("画像解析中")
      let request: NSURLRequest = NSURLRequest(URL: url)
      webView.loadRequest(request)
      self.dispatch_async_main {
        SVProgressHUD.dismiss()
      }
    }

    // Do any additional setup after loading the view.
  }
  func handleSwipeleft(sender: UITapGestureRecognizer){
    print("Swiped up!")
//    // 遷移するViewを定義する.
//    let mySecondViewController: ImageAnalysisController = ImageAnalysisController()
//    // アニメーションを設定する.
//    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
//    // Viewの移動する.
//    self.presentViewController(mySecondViewController, animated: true, completion: nil)
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  //ページが読み終わったときに呼ばれる関数
  func webViewDidFinishLoad(webView: UIWebView) {
    print("ページ読み込み完了しました！")
  }
  //ページを読み始めた時に呼ばれる関数
  func webViewDidStartLoad(webView: UIWebView) {
    print("ページ読み込み開始しました！")
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
