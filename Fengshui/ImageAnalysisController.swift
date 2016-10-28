//
//  ImageAnalysisController.swift
//  Fengshui
//
//  Created by 渡邊翼 on 2016/10/21.
//  Copyright © 2016年 渡邊翼. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ImageAnalysisController: UIViewController {
  var PictureView: UIImageView!
  var TextView: UITextView!
  var ResultTextView : UITextView!
  var takenImage:UIImage?
  var parameter: [String: AnyObject] = [:]
  var takenImage_accessor: UIImage? {
    get {
      return self.takenImage
    }
    set(value) {
      self.takenImage = value
    }
  }
  func dispatch_async_main(block: () -> ()) {
    dispatch_async(dispatch_get_main_queue(), block)
  }
  
  func dispatch_async_global(block: () -> ()) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Viewの背景色を白色にする
    self.view.backgroundColor = UIColor.whiteColor()
    // 画像を解析した結果を出力
    TextView = UITextView(frame: CGRect(x: 0 , y: self.view.bounds.height - 50, width: self.view.frame.size.width*0.4, height: self.view.frame.size.height * 0.4))
    TextView.backgroundColor = UIColor.blackColor()
    TextView.textColor = UIColor.whiteColor()
    TextView.center = CGPoint(x:self.view.frame.size.width*3/4,y:self.view.frame.size.height/4)
    TextView.textAlignment = NSTextAlignment.Center
    TextView.text = "黒い髪をしたマッチョがいます。"
    self.view.addSubview(TextView)
    // 風水の評価を出力
    ResultTextView = UITextView(frame: CGRect(x: 0 , y: self.view.bounds.height - 50, width: self.view.frame.size.width, height: 200))
    ResultTextView.center = CGPoint(x:self.view.frame.size.width/2,y:self.view.frame.size.height - TextView.frame.size.height/2)
    ResultTextView.backgroundColor = UIColor.blackColor()
    ResultTextView.textColor = UIColor.whiteColor()
    ResultTextView.textAlignment = NSTextAlignment.Center
    ResultTextView.text = "撮影した場所の風水得点は100点です。"
    self.view.addSubview(ResultTextView)
    getColor()
    //撮影した画像をViewに描画
    initImageView()
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func getColor(){
    //parameter = ["image_path":"https://pbs.twimg.com/profile_images/459921170251264000/ax4FMwXA.jpeg"]
    Alamofire.request(.GET,"https://secure-mesa-92119.herokuapp.com/?image_path=https://pbs.twimg.com/profile_images/459921170251264000/ax4FMwXA.jpeg")
      .responseJSON { respon in
        guard let object = respon.result.value else {
          print(respon.result.value)
          return
        }
        self.dispatch_async_global { // ここからバックグラウンドスレッド
          let json = JSON(object)
          print(json)
          self.dispatch_async_main { // ここからメインスレッド
            // HUD消したり
            // hideHUD()
            // 結果をUIへ表示したり
            SVProgressHUD.dismiss()
          }
        }
    }
  }

  
  //撮影した画像の表示
  private func initImageView(){
    // UIImage インスタンスの生成
    let image:UIImage = self.takenImage!
    let imageView = UIImageView(frame: CGRect(x: 100,y: 120,width: self.view.frame.size.width,height: self.view.frame.size.height))
    imageView.image = image
    // 撮影した画像を縮小
    imageView.transform = CGAffineTransformMakeScale(0.4, 0.4)
    // 画像の表示する座標を指定する.
    imageView.center = CGPoint(x:self.view.frame.size.width/4,y:self.view.frame.size.height/4)
    // UIImageViewのインスタンスをビューに追加
    self.view.addSubview(imageView)
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  //　GoogleCloudVisionAPIを呼び出す
}