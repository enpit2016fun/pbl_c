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
  var ResultLabel: UILabel!
  var PictureView: UIImageView!
  var takenImage:UIImage?
  var parameter: [String: AnyObject] = [:]
  var view1:UIView!
  var view2:UIView!
  var view3:UIView!
  var view4:UIView!
  var loveImage = UIImage(named:"恋愛運.png")
  var jobImage = UIImage(named:"仕事運.png")
  var lifeImage = UIImage(named:"人生運.png")
  var selectedFortune:String?
  
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
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    print(appDelegate.selectedFortune!)
    selectedFortune = appDelegate.selectedFortune! //appDelegateの変数を操作
    //Viewを並べる
    view1 = UIView(frame: CGRectMake(0,0,self.view.bounds.width/2,self.view.bounds.width/2 * 0.85))
    //view1.backgroundColor = UIColor.redColor()
    view1.center = CGPoint(x:self.view.bounds.width/4,y:self.view.bounds.height * 0.55 + 8)
    view2 = UIView(frame: CGRectMake(0,0,self.view.bounds.width/2,self.view.bounds.width/2 * 0.85))
    //view2.backgroundColor = UIColor.blueColor()
    view2.center = CGPoint(x:self.view.bounds.width * 0.75,y:self.view.bounds.height * 0.55 + 8 )
    view3 = UIView(frame: CGRectMake(0,0,self.view.bounds.width/2,self.view.bounds.width/2 * 0.85))
    //view3.backgroundColor = UIColor.yellowColor()
    view3.center = CGPoint(x:self.view.bounds.width/4,y:self.view.bounds.height * 0.85)
    view4 = UIView(frame: CGRectMake(0,0,self.view.bounds.width/2,self.view.bounds.width/2 * 0.85))
    //view4.backgroundColor = UIColor.greenColor()
    view4.center = CGPoint(x:self.view.bounds.width * 0.75,y:self.view.bounds.height * 0.85)
    view1.layer.borderColor = UIColor.grayColor().CGColor
    view1.layer.borderWidth = 0.5
    view2.layer.borderColor = UIColor.grayColor().CGColor
    view2.layer.borderWidth = 0.5
    view3.layer.borderColor = UIColor.grayColor().CGColor
    view3.layer.borderWidth = 0.5
    view4.layer.borderColor = UIColor.grayColor().CGColor
    view4.layer.borderWidth = 0.5
    self.view.addSubview(view1)
    self.view.addSubview(view2)
    self.view.addSubview(view3)
    self.view.addSubview(view4)
    
    //選んだ運勢に合わせて画像を表示
    if selectedFortune! == "love" {
      let loveView = UIImageView(frame: CGRect(x:0, y:0, width: 100, height: 100))
      loveView.center = CGPoint(x:self.view1.bounds.width/2,y:self.view1.bounds.height/2)
      // UIImageViewに画像を設定する.
      loveView.image = loveImage
      self.view1.addSubview(loveView)
    }else if selectedFortune! == "job" {
      let jobView = UIImageView(frame: CGRect(x:0, y:0, width: 100, height: 100))
      jobView.center = CGPoint(x:self.view1.bounds.width/2,y:self.view1.bounds.height/2)
      // UIImageViewに画像を設定する.
      jobView.image = jobImage
      self.view1.addSubview(jobView)
    }else {
      let lifeView = UIImageView(frame: CGRect(x:0, y:0, width: 100, height: 100))
      lifeView.center = CGPoint(x:self.view1.bounds.width/2,y:self.view1.bounds.height/2)
      // UIImageViewに画像を設定する.
      lifeView.image = lifeImage
      self.view1.addSubview(lifeView)
    }
    
    // 方角を表示するラベルを作成する
    ResultLabel = UILabel(frame: CGRectMake(0,0,self.view.bounds.width,40))
    ResultLabel.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height * 0.4 - 4)
    ResultLabel.textAlignment = NSTextAlignment.Center
    ResultLabel.backgroundColor = UIColor.orangeColor()
    ResultLabel.textColor = UIColor.whiteColor()
    ResultLabel.text = "結果"
    ResultLabel.font = UIFont(name:"HiraKakuProN-W6",size:15)
    self.view.addSubview(ResultLabel)
    // Viewの背景色を白色にする
    self.view.backgroundColor = UIColor.lightGrayColor()
    // 風水の評価を出力
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
    parameter = ["image_path":Image2String(self.takenImage!)!]
    Alamofire.request(.GET,"https://secure-mesa-92119.herokuapp.com/?image_path=",parameters: parameter)
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
    let imageView = UIImageView(frame: CGRect(x: self.view.bounds.width/2,y: self.view.bounds.height * 0.15 + 20,width: self.view.bounds.width * 0.7,height: self.view.bounds.height * 0.3))
    imageView.image = image
    // UIImageViewのインスタンスをビューに追加
    // 画像の表示する座標を指定する.
    imageView.center = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height * 0.2)
    self.view.addSubview(imageView)
  }
  
  func Image2String(image:UIImage) -> String? {
    
    //画像をNSDataに変換
    let data:NSData = UIImagePNGRepresentation(self.takenImage!)!
    
    //NSDataへの変換が成功していたら
    if let pngData:NSData = data {
      
      //BASE64のStringに変換する
      let encodeString:String =
        pngData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
      
      return encodeString
      
    }
    
    return nil
    
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