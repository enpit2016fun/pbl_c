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
  var color = "緑"
  var word = "家具"
  
  func dispatch_async_main(block: () -> ()) {
    dispatch_async(dispatch_get_main_queue(), block)
  }
  
  func dispatch_async_global(block: () -> ()) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
  }
  
  func urlEncode(str: String) -> String {
    return str.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
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
    
    
    
    urlEncode("\(color) \(word)")
    
    self.view.addSubview(webView)
    let url: NSURL = NSURL(string: "https://www.amazon.co.jp/s/ref=nb_sb_noss_1?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&url=search-alias%3Daps&field-keywords=%E5%AE%B6%E5%85%B7&rh=i%3Aaps%2Ck%3A%E5%AE%B6%E5%85%B7")!
    self.dispatch_async_global { // ここからバックグラウンドスレッド
      SVProgressHUD.showWithStatus("ロード中")
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
