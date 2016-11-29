//
//  DirectionAnalysisController.swift
//  Fengshui
//
//  Created by 渡邊翼 on 2016/11/27.
//  Copyright © 2016年 渡邊翼. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
class DirectionAnalysisController: UIViewController,UIGestureRecognizerDelegate {
  var takenImage:UIImage?
  var PictureView: UIImageView!
  var DirectionLabel: UILabel!
  var ColorView:UIView!
  var ColorLabel:UILabel!
  var HomeImage = UIImage(named:"home.png")
  var HomeImageView: UIImageView!
  var SaveImage = UIImage(named:"save.png")
  var SaveImageView: UIImageView!
  var PhotoImage = UIImage(named:"takePhoto_g.png")
  var PhotoImageView: UIImageView!
  var isSuccess:Bool = false
  var TextLabel: UILabel!
  var parameter: [String: AnyObject] = [:]
  
  func dispatch_async_main(block: () -> ()) {
    dispatch_async(dispatch_get_main_queue(), block)
  }
  
  func dispatch_async_global(block: () -> ()) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    let PictureView = UIImageView(frame: CGRect(x:0, y:0, width: 140, height: 200))
    PictureView.image = takenImage!
    PictureView.center = CGPoint(x:self.view.bounds.width * 0.35,y:self.view.bounds.height * 0.4)
    self.view.addSubview(PictureView)
    
    // 方角を表示するラベルを作成する
    DirectionLabel = UILabel(frame: CGRectMake(0,0,300,50))
    DirectionLabel.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height * 0.1)
    DirectionLabel.textAlignment = NSTextAlignment.Center
    DirectionLabel.text = "おすすめ方角は東です。"
    DirectionLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
    self.view.addSubview(DirectionLabel)
    // Do any additional setup after loading the view.
    
    // 方角を表示するラベルを作成する
    ColorLabel = UILabel(frame: CGRectMake(0,0,300,50))
    ColorLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.75 , y:self.view.bounds.height * 0.4)
    ColorLabel.textAlignment = NSTextAlignment.Center
    ColorLabel.text = "ラッキーカラー:青"
    ColorLabel.font = UIFont(name:"HiraKakuProN-W6",size:10)
    self.view.addSubview(ColorLabel)
    
    // 方角を表示するラベルを作成する
    TextLabel = UILabel(frame: CGRectMake(0,0,300,50))
    TextLabel.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height * 0.75)
    TextLabel.textAlignment = NSTextAlignment.Center
    TextLabel.text = "上昇する運"
    TextLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
    self.view.addSubview(TextLabel)
    
    HomeImageView = UIImageView(frame: CGRect(x: self.view.bounds.width * 0.68 , y: self.view.bounds.height * 0.87, width: self.view.bounds.width * 0.3, height: 50))
    // UIImageViewに画像を設定する.
    HomeImageView.image = HomeImage
    HomeImageView.userInteractionEnabled = true
    let HomeTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DirectionAnalysisController.HomeTapAction(_:)))
    HomeTap.delegate = self
    HomeImageView.addGestureRecognizer(HomeTap)
    self.view.addSubview(HomeImageView)
    SaveImageView = UIImageView(frame: CGRect(x: self.view.bounds.width * 0.35 , y: self.view.bounds.height * 0.87, width: self.view.bounds.width * 0.3, height: 50))
    // UIImageViewに画像を設定する.
    SaveImageView.image = SaveImage
    SaveImageView.userInteractionEnabled = true
    let SaveTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DirectionAnalysisController.SaveTapAction(_:)))
    SaveTap.delegate = self
    SaveImageView.addGestureRecognizer(SaveTap)
    self.view.addSubview(SaveImageView)
    PhotoImageView = UIImageView(frame: CGRect(x: self.view.bounds.width * 0.02 , y: self.view.bounds.height * 0.87, width: self.view.bounds.width * 0.3, height: 50))
    // UIImageViewに画像を設定する.
    PhotoImageView.image = PhotoImage
    PhotoImageView.userInteractionEnabled = true
    let photoTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DirectionAnalysisController.PhotoTapAction(_:)))
    photoTap.delegate = self
    PhotoImageView.addGestureRecognizer(photoTap)
    self.view.addSubview(PhotoImageView)
    
    //============= ディスパッチグループおよびディスパッチキューの作成 ============= //
    let dispatchGroup = dispatch_group_create()
    let queue1 = dispatch_queue_create("キュー1", DISPATCH_QUEUE_SERIAL)
    //let queue2 = dispatch_queue_create("キュー2", DISPATCH_QUEUE_CONCURRENT)
    
    //============= 単純なタスクの追加 ============= //
    dispatch_group_async(dispatchGroup, queue1, {
      //self.initImageView()
    })
    dispatch_group_async(dispatchGroup, queue1, {
      self.dispatch_async_global { // ここからバックグラウンドスレッド
        SVProgressHUD.showWithStatus("画像解析中")
        self.myImageUploadRequest({message in
          print(message)
          self.getColor()})
        self.dispatch_async_main { // ここからメインスレッド
          print("dismiss")
          //SVProgressHUD.dismiss()
        }
      }
      
    })
    
    //============= 前の全タスクが全て処理し終わったあとに処理されるタスクの追加 ============= //
    dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER)
    
    print("end")
  }
  
  func PhotoTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: CaptureFurnitureController = CaptureFurnitureController()
    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  func SaveTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: CaptureFurnitureController = CaptureFurnitureController()
    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  
  func HomeTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: ChoiceController = ChoiceController()
    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  func getColor(){
    parameter = ["image_path":"http://wing-bsk.sakura.ne.jp/uploads/2016/user-profile.jpg"]
    Alamofire.request(.GET,"http://wing-bsk.sakura.ne.jp/GoogleCloudVision_php/?image_path=",parameters: parameter)
      .responseJSON { respon in
        guard let object = respon.result.value else {
          //print(respon.result.value)
          return
        }
        self.dispatch_async_global { // ここからバックグラウンドスレッド
          //SVProgressHUD.showWithStatus("画像解析中")
          let json = JSON(object)
          print(json)
          self.dispatch_async_main { // ここからメインスレッド
            let ColorView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
            ColorView.center = CGPoint(x:self.view.bounds.width * 0.75,y:self.view.bounds.height * 0.3 )
            ColorView.backgroundColor = UIColor(red: json["responses"][0]["imagePropertiesAnnotation"]["dominantColors"]["colors"][0]["color"]["red"].number! as CGFloat / 255, green: json["responses"][0]["imagePropertiesAnnotation"]["dominantColors"]["colors"][0]["color"]["green"].number! as CGFloat / 255, blue: json["responses"][0]["imagePropertiesAnnotation"]["dominantColors"]["colors"][0]["color"]["blue"].number! as CGFloat / 255, alpha: 1.0)
            self.view.addSubview(ColorView)
            SVProgressHUD.dismiss()
          }
        }
    }
  }
  
  //画像のアップロード処理
  func myImageUploadRequest(callback:(String) -> Void){
    //myUrlには自分で用意したphpファイルのアドレスを入れる
    let myUrl = NSURL(string:"http://wing-bsk.sakura.ne.jp/")
    let request = NSMutableURLRequest(URL:myUrl!)
    request.HTTPMethod = "POST"
    //下記のパラメータはあくまでもPOSTの例
    let param = [
      "userId" : "12345"
    ]
    let message:String = "isSuccess"
    let boundary = generateBoundaryString()
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    let imageData = UIImageJPEGRepresentation(self.takenImage!, 1)
    if(imageData==nil) { return; }
    request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
      data, response, error in
      if error != nil {
        print("error=\(error)")
        return
      }
      // レスポンスを出力
      print("******* response = \(response)")
      let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
      print("****** response data = \(responseString!)")
      self.isSuccess = true
      dispatch_async(dispatch_get_main_queue(),{
        //アップロード完了
        callback(message)
      });
    }
    task.resume()
    
  }
  
  func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
    let body = NSMutableData()
    if parameters != nil {
      for (key, value) in parameters! {
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
        body.appendString("\(value)\r\n")
      }
    }
    let filename = "user-profile.jpg"
    let mimetype = "image/jpg"
    body.appendString("--\(boundary)\r\n")
    body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
    body.appendString("Content-Type: \(mimetype)\r\n\r\n")
    body.appendData(imageDataKey)
    body.appendString("\r\n")
    body.appendString("--\(boundary)--\r\n")
    return body
  }
  
  
  func generateBoundaryString() -> String {
    return "Boundary-\(NSUUID().UUIDString)"
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
