//
//  FindFurnitureController.swift
//  Fengshui
//
//  Created by 渡邊翼 on 2016/11/11.
//  Copyright © 2016年 渡邊翼. All rights reserved.
//

import UIKit
import SVProgressHUD

class FindFurnitureController: UIViewController,UIWebViewDelegate,UIGestureRecognizerDelegate {
  //var webView: UIWebView!
  var color:String?
  var word = "家具"
  var backImage = UIImage(named:"site遷移.png")
  var backImageView: UIImageView!
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

    
    
    
    urlEncode("\(color)")
    
    self.view.addSubview(webView)
    let url: NSURL = NSURL(string: "https://www.amazon.co.jp/s/ref=nb_sb_noss_2?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&url=node%3D16428011&field-keywords=\(urlEncode("\(color!)"))")!
    self.dispatch_async_global { // ここからバックグラウンドスレッド
      SVProgressHUD.showWithStatus("ロード中")
      let request: NSURLRequest = NSURLRequest(URL: url)
      webView.loadRequest(request)
      self.dispatch_async_main {
        SVProgressHUD.dismiss()
      }
    }
    backImageView = UIImageView(frame: CGRect(x: self.view.bounds.width * 0.1  , y: self.view.bounds.height * 0.9, width: 50, height: 50))
    // UIImageViewに画像を設定する.
    backImageView.image = backImage
    
    backImageView.userInteractionEnabled = true
    
    let backTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FindFurnitureController.backTapAction(_:)))
    backTap.delegate = self
    
    backImageView.addGestureRecognizer(backTap)
    // Viewに張りつけ.
    self.view.addSubview(backImageView)
    // Do any additional setup after loading the view.
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
  
  func backTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    self.dismissViewControllerAnimated(true, completion: nil)
//    let mySecondViewController: ImageAnalysisController = ImageAnalysisController()
//    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
//    // Viewの移動する.
//    self.presentViewController(mySecondViewController, animated: true, completion: nil)
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
