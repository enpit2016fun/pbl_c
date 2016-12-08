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


extension NSMutableData {
  func appendString(string: String) {
    let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
    appendData(data!)
  }
}





class ImageAnalysisController: UIViewController,UIGestureRecognizerDelegate {
  var ResultLabel: UILabel!
  var PictureView: UIImageView!
  var takenImage:UIImage?
  var parameter: [String: AnyObject] = [:]
  var HomeImage = UIImage(named:"home.png")
  var HomeImageView: UIImageView!
  var SaveImage = UIImage(named:"sitePage.png")
  var SaveImageView: UIImageView!
  var PhotoImage = UIImage(named:"takePhoto_g.png")
  var PhotoImageView: UIImageView!
  var hanteiView: UIImageView!
  var hantei1Image = UIImage(named:"たいへんよくできました.png")
  var hantei2Image = UIImage(named:"よくできました.png")
  var hantei3Image = UIImage(named:"もう少し頑張りましょう.png")
  var resultHSV :HSV!
  var defaultHSV :HSV!
  var view1:UIView!
  var view2:UIView!
  var view3:UIView!
  var view4:UIView!
  var colorName:String!
  var colorView: UIView!
  var luckyView: UIView!
  var loveImage = UIImage(named:"恋愛_180pt.png")
  var jobImage = UIImage(named:"仕事_180pt.png")
  var lifeImage = UIImage(named:"人生運.png")
  var myImage = UIImage(named:"女の子アイコン")
  var familyImage = UIImage(named:"家族_180pt.png")
  var moneyImage = UIImage(named:"金運_180pt.png")
  var healthImage = UIImage(named:"健康_180pt.png")
  var depositImage = UIImage(named:"貯金_180pt.png")
  var beautyImage = UIImage(named:"美容_180pt.png")
  var selectedFortune:String?
  var fortuneLabel: UILabel!
  var furnitureLabel: UILabel!
  var kaisetsuLabel:UITextView!
  var luckyLabel: UILabel!
  var parsentLabel: UILabel!
  var isSuccess:Bool = false
  var fortuneArray:[Fortune] = []
  var red: CGFloat     = 1.0
  var green: CGFloat   = 1.0
  var blue: CGFloat    = 1.0
  var alpha: CGFloat   = 1.0
  
  //  var takenImage_accessor: UIImage? {
  //    get {
  //      return self.takenImage
  //    }
  //    set(value) {
  //      self.takenImage = value
  //    }
  //  }
  func dispatch_async_main(block: () -> ()) {
    dispatch_async(dispatch_get_main_queue(), block)
  }
  
  func dispatch_async_global(block: () -> ()) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    fortuneArray = appDelegate.farray
    print(fortuneArray.isEmpty)
    // Viewの背景色を白色にする
    self.view.backgroundColor = UIColor.whiteColor()
    selectedFortune = appDelegate.selectedFortune
    //Viewを並べる
    print("selectedFortune::\(selectedFortune!)")
    
    // ラッキーカラーを表示するラベルを作成する
    luckyLabel = UILabel(frame: CGRectMake(0,0,120,30))
    luckyLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.75 , y:self.view.bounds.height * 0.8)
    luckyLabel.textAlignment = NSTextAlignment.Center
    luckyLabel.font = UIFont(name:"HiraKakuProN-W6",size:9)
    luckyLabel.textColor = UIColor.lightGrayColor()
    //luckyLabel.text = "ラッキーカラー：白"
    self.view.addSubview(luckyLabel)
    
    luckyView = UIView(frame: CGRectMake(0,0,self.view.bounds.width/5.5,self.view.bounds.width/5.5))
    luckyView.center = CGPoint(x:self.view.bounds.width * 0.75 ,y:self.view.bounds.height * 0.7)
    luckyView.layer.borderWidth = 0.5
    luckyView.layer.borderColor = UIColor.blackColor().CGColor
    //self.luckyView.backgroundColor = UIColor.yellowColor()
    self.view.addSubview(luckyView)
    
    // 運勢タイプを表示するラベルを作成する
    fortuneLabel = UILabel(frame: CGRectMake(0,0,100,50))
    fortuneLabel.layer.position = CGPoint(x: self.view.bounds.width/4 , y:self.view.bounds.height * 0.8)
    fortuneLabel.textAlignment = NSTextAlignment.Center
    fortuneLabel.font = UIFont(name:"HiraKakuProN-W6",size:18)
    fortuneLabel.textColor = UIColor.lightGrayColor()
    self.view.addSubview(fortuneLabel)
    
    //選んだ運勢に合わせて画像を表示
    if selectedFortune! == "love" {
      let loveView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      loveView.center = CGPoint(x:self.view.bounds.width/4,y:self.view.bounds.height * 0.7)
      // UIImageViewに画像を設定する.
      loveView.image = loveImage
      self.view.addSubview(loveView)
      fortuneLabel.text = "恋愛運"
      for farr in fortuneArray {
        print(farr.name!)
        if (farr.name! == "恋愛運"){
          self.luckyView.backgroundColor = farr.color
          farr.color?.getRed(&red,green: &green,blue: &blue,alpha: &alpha)
          print("R:\(red) G:\(green) B:\(blue) a:\(alpha)")
          defaultHSV = fromRGB(red, green: green, blue: blue)
          colorName = farr.colorName!
          luckyLabel.text = "ラッキーカラー：\(farr.colorName!)"
          print("ラッキーカラー：\(farr.colorName!)")
          self.view.addSubview(luckyLabel)
          print(farr.name)
          print(farr.color)
          self.view.addSubview(luckyView)
        }
      }
      
    }else if selectedFortune! == "job" {
      print("--------------------call-----------------")
      let jobView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      jobView.center = CGPoint(x:self.view.bounds.width/4,y:self.view.bounds.height * 0.7)
      // UIImageViewに画像を設定する.
      jobView.image = jobImage
      self.view.addSubview(jobView)
      fortuneLabel.text = "仕事運"
      for farr in fortuneArray {
        print("--------------------call-----------------")
        print(farr.name!)
        print(farr)
        print(farr.name!)
        if (farr.name! == "仕事運"){
          self.luckyView.backgroundColor = farr.color
          farr.color?.getRed(&red,green: &green,blue: &blue,alpha: &alpha)
          print("R:\(red) G:\(green) B:\(blue) a:\(alpha)")
          defaultHSV = fromRGB(red, green: green, blue: blue)
          colorName = farr.colorName!
          self.luckyLabel.text = "ラッキーカラー：\(farr.colorName!)"
          self.view.addSubview(luckyLabel)
          print(farr.name)
          print(farr.colorName!)
          self.view.addSubview(luckyView)
        }
      }
      
    }else if selectedFortune! == "money" {
      let jobView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      jobView.center = CGPoint(x:self.view.bounds.width/4,y:self.view.bounds.height * 0.7)
      // UIImageViewに画像を設定する.
      jobView.image = moneyImage
      self.view.addSubview(jobView)
      fortuneLabel.text = "金運"
      for farr in fortuneArray {
        print(farr)
        print(farr.name!)
        if (farr.name! == "金運"){
          self.luckyView.backgroundColor = farr.color
          farr.color?.getRed(&red,green: &green,blue: &blue,alpha: &alpha)
          print("R:\(red) G:\(green) B:\(blue) a:\(alpha)")
          defaultHSV = fromRGB(red, green: green, blue: blue)
          colorName = farr.colorName!
          self.luckyLabel.text = "ラッキーカラー：\(farr.colorName!)"
          self.view.addSubview(luckyLabel)
          print(farr.name!)
          print(farr.color!)
          self.view.addSubview(luckyView)
        }
      }
      
      
    }else if selectedFortune! == "deposit" {
      let jobView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      jobView.center = CGPoint(x:self.view.bounds.width/4,y:self.view.bounds.height * 0.7)
      // UIImageViewに画像を設定する.
      jobView.image = depositImage
      self.view.addSubview(jobView)
      fortuneLabel.text = "貯金運"
      for farr in fortuneArray {
        print(farr.name!)
        if (farr.name! == "貯金運"){
          self.luckyView.backgroundColor = farr.color
          farr.color?.getRed(&red,green: &green,blue: &blue,alpha: &alpha)
          print("R:\(red) G:\(green) B:\(blue) a:\(alpha)")
          defaultHSV = fromRGB(red, green: green, blue: blue)
          colorName = farr.colorName!
          self.luckyLabel.text = "ラッキーカラー：\(farr.colorName!)"
          self.view.addSubview(luckyLabel)
          print(farr.name)
          print(farr.color)
          self.view.addSubview(luckyView)
        }
      }
      
    }else if selectedFortune! == "health" {
      let jobView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      jobView.center = CGPoint(x:self.view.bounds.width/4,y:self.view.bounds.height * 0.7)
      // UIImageViewに画像を設定する.
      jobView.image = healthImage
      self.view.addSubview(jobView)
      fortuneLabel.text = "健康運"
      for farr in fortuneArray {
        print(farr.name!)
        if (farr.name! == "健康運"){
          self.luckyView.backgroundColor = farr.color
          farr.color?.getRed(&red,green: &green,blue: &blue,alpha: &alpha)
          print("R:\(red) G:\(green) B:\(blue) a:\(alpha)")
          defaultHSV = fromRGB(red, green: green, blue: blue)
          colorName = farr.colorName!
          self.luckyLabel.text = "ラッキーカラー：\(farr.colorName!)"
          self.view.addSubview(luckyLabel)
          print(farr.name!)
          print(farr.color!)
          self.view.addSubview(luckyView)
        }
      }
      
    }else if selectedFortune! == "family" {
      let jobView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      jobView.center = CGPoint(x:self.view.bounds.width/4,y:self.view.bounds.height * 0.7)
      // UIImageViewに画像を設定する.
      jobView.image = familyImage
      self.view.addSubview(jobView)
      fortuneLabel.text = "家族運"
      for farr in fortuneArray {
        print(farr.name!)
        if (farr.name! == "家族運"){
          self.luckyView.backgroundColor = farr.color
          farr.color?.getRed(&red,green: &green,blue: &blue,alpha: &alpha)
          print("R:\(red) G:\(green) B:\(blue) a:\(alpha)")
          defaultHSV = fromRGB(red, green: green, blue: blue)
          colorName = farr.colorName!
          self.luckyLabel.text = "ラッキーカラー：\(farr.colorName!)"
          self.view.addSubview(luckyLabel)
          print(farr.name)
          print(farr.color)
          self.view.addSubview(luckyView)
        }
      }
      
    }else if selectedFortune! == "beauty" {
      let jobView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      jobView.center = CGPoint(x:self.view.bounds.width/4,y:self.view.bounds.height * 0.7)
      // UIImageViewに画像を設定する.
      jobView.image = beautyImage
      self.view.addSubview(jobView)
      fortuneLabel.text = "美容運"
      for farr in fortuneArray {
        print(farr.name!)
        if (farr.name! == "美容運"){
          self.luckyView.backgroundColor = farr.color
          farr.color?.getRed(&red,green: &green,blue: &blue,alpha: &alpha)
          print("R:\(red) G:\(green) B:\(blue) a:\(alpha)")
          defaultHSV = fromRGB(red , green: green, blue: blue )
          colorName = farr.colorName!
          self.luckyLabel.text = "ラッキーカラー：\(farr.colorName!)"
          self.view.addSubview(luckyLabel)
          print(farr.name)
          print(farr.color)
          self.view.addSubview(luckyView)
        }
      }
      
    }else {
      let lifeView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      lifeView.center = CGPoint(x:self.view.bounds.width/4,y:self.view.bounds.height * 0.7)
      // UIImageViewに画像を設定する.
      lifeView.image = lifeImage
      self.view.addSubview(lifeView)
      fortuneLabel.text = "人生運"
      for farr in fortuneArray {
        print(farr.name!)
        if (farr.name! == "人生運"){
          self.luckyView.backgroundColor = farr.color
          farr.color?.getRed(&red,green: &green,blue: &blue,alpha: &alpha)
          print("R:\(red) G:\(green) B:\(blue) a:\(alpha)")
          defaultHSV = fromRGB(red, green: green, blue: blue)
          colorName = farr.colorName!
          self.luckyLabel.text = "ラッキーカラー：\(farr.colorName!)"
          self.view.addSubview(luckyLabel)
          print(farr.name)
          print(farr.color)
          self.view.addSubview(luckyView)
        }
      }
      
    }
    
    
    
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
    let SaveTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ImageAnalysisController.PictureTapAction(_:)))
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
    
    // 方角を表示するラベルを作成する
    ResultLabel = UILabel(frame: CGRectMake(0,0,self.view.bounds.width/2,40))
    ResultLabel.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height * 0.1)
    ResultLabel.textAlignment = NSTextAlignment.Center
    ResultLabel.textColor = UIColor.blackColor()
    ResultLabel.text = "あなたのお部屋は・・・"
    ResultLabel.font = UIFont(name:"HiraKakuProN-W6",size:15)
    self.view.addSubview(ResultLabel)
    
    // 方角を表示するラベルを作成する
    kaisetsuLabel = UITextView(frame: CGRectMake(0,0,200,150))
    kaisetsuLabel.backgroundColor = UIColor.clearColor()
    kaisetsuLabel.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height * 0.62)
    kaisetsuLabel.textAlignment = NSTextAlignment.Left
    kaisetsuLabel.textColor = UIColor.blackColor()
    kaisetsuLabel.text = "水の気が強い方位なので空間が汚れると気がよどむ傾向も強いのでマメに掃除をし清潔な状態をキープします。冷えやすい方位なのでレイアウトするインテリアは暖かみを感じられるものがベストです。"
    kaisetsuLabel.font = UIFont(name:"HiraKakuProN-W6",size:7)
    self.view.addSubview(kaisetsuLabel)
    
    hanteiView = UIImageView(frame: CGRect(x: self.view.bounds.width * 0.5 - 40, y: self.view.bounds.height * 0.44, width: 80, height: 80))
    // UIImageViewに画像を設定する.
    //hanteiView.image = hanteiImage
    hanteiView.alpha = 0.4
    self.view.addSubview(hanteiView)
    
    
    
    
    
    //撮影した画像をViewに描画
    
    // 風水の評価を出力
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
  
  func PictureTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: FindFurnitureController = FindFurnitureController()
    // アニメーションを設定する.
    mySecondViewController.color = colorName
    print(colorName)
    //mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  
  
  
  func addCircleView() {
    let diceRoll = CGFloat(Int(arc4random_uniform(7))*50)
    let circleWidth = CGFloat(120)
    let circleHeight = circleWidth
    
    let circleView = CircleView(frame: CGRectMake(diceRoll, 0, circleWidth, circleHeight))
    circleView.center = CGPoint(x:self.view.bounds.width * 0.5,y:self.view.bounds.height * 0.3  )
    self.view.addSubview(circleView)
    SVProgressHUD.dismiss()
    // Animate the drawing of the circle over the course of 1 second
    circleView.animateCircle(1)
    
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
            self.colorView = UIView(frame: CGRectMake(0,0,self.view.bounds.width/3,self.view.bounds.width/3))
            //view2.backgroundColor = UIColor.blueColor()
            self.colorView.center = CGPoint(x:self.view.bounds.width * 0.75,y:self.view.bounds.height * 0.55 + 8 )
            //self.view4.addSubview(self.furnitureLabel)
            self.colorView.backgroundColor = UIColor(red: json["responses"][0]["imagePropertiesAnnotation"]["dominantColors"]["colors"][0]["color"]["red"].number! as CGFloat / 255, green: json["responses"][0]["imagePropertiesAnnotation"]["dominantColors"]["colors"][0]["color"]["green"].number! as CGFloat / 255, blue: json["responses"][0]["imagePropertiesAnnotation"]["dominantColors"]["colors"][0]["color"]["blue"].number! as CGFloat / 255, alpha: 1.0)
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.circleColor = UIColor(red: json["responses"][0]["imagePropertiesAnnotation"]["dominantColors"]["colors"][0]["color"]["red"].number! as CGFloat / 255, green: json["responses"][0]["imagePropertiesAnnotation"]["dominantColors"]["colors"][0]["color"]["green"].number! as CGFloat / 255, blue: json["responses"][0]["imagePropertiesAnnotation"]["dominantColors"]["colors"][0]["color"]["blue"].number! as CGFloat / 255, alpha: 1.0)
            let score:Double = json["responses"][0]["imagePropertiesAnnotation"]["dominantColors"]["colors"][0]["score"].number! as Double
            self.resultHSV = self.fromRGB(json["responses"][0]["imagePropertiesAnnotation"]["dominantColors"]["colors"][0]["color"]["red"].number! as CGFloat / 255,green: json["responses"][0]["imagePropertiesAnnotation"]["dominantColors"]["colors"][0]["color"]["green"].number! as CGFloat / 255,blue: json["responses"][0]["imagePropertiesAnnotation"]["dominantColors"]["colors"][0]["color"]["blue"].number! as CGFloat / 255)
            print("red==\(json["responses"][0]["imagePropertiesAnnotation"]["dominantColors"]["colors"][0]["color"]["red"].number! as Int / 255)")
            print("HSV.hue=\(self.resultHSV.hue),HSV.saturation=\(self.resultHSV.saturation),HSV.value =\(self.resultHSV.value)")
            print(score)
            let result = self.hsvDistance(self.defaultHSV, hsv2: self.resultHSV)
            if result > 75 {
              self.hanteiView.image = self.hantei1Image!
            }else if result > 40 {
              self.hanteiView.image = self.hantei2Image!
            }else {
              self.hanteiView.image = self.hantei3Image!
            }
            //self.view.addSubview(self.colorView)
            appDelegate.score = result / 100
            self.addCircleView()
            
            // パーセンテージを表示するラベルを作成する
            self.parsentLabel = UILabel(frame: CGRectMake(0,0,100,50))
            self.parsentLabel.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height * 0.3)
            self.parsentLabel.textAlignment = NSTextAlignment.Center
            self.parsentLabel.font = UIFont(name:"HiraKakuProN-W6",size:18)
            self.parsentLabel.textColor = UIColor.lightGrayColor()
            let text = String(format: "%.0f",result)
            self.parsentLabel.text = text + "%"
            self.view.addSubview(self.parsentLabel)
            
          }
        }
    }
  }
  
  func hsvDistance(hsv1:HSV,hsv2:HSV) -> Double{
    let dist_h = abs(hsv1.hue - hsv2.hue)
    print("HSVvalue=\(hsv1.hue,hsv2.hue)")
    print("HSVdistance1\(dist_h)")
    var distance = 0.0
    let numbers = [dist_h, 360.0 - dist_h]
    distance = distance + (numbers.minElement()! * 2)
    print("HSVdistance1 = \(distance)")
    distance = distance + abs(hsv1.saturation - hsv2.saturation) * 180
    print("HSVsaturation=\(hsv1.saturation,hsv2.saturation)")
    print("HSVdistance2 = \(distance)")
    print("HSVvalue=\(hsv1.value,hsv2.value)")
    distance = distance + abs(hsv1.value - hsv2.value) * 180
    print("HSVdistance3 = \(distance)")
    let result = 100 - (distance / 1836100 * 100)
    return result
  }
  //  //撮影した画像の表示
  //  private func initImageView(){
  //    // UIImage インスタンスの生成
  //    let image:UIImage = self.takenImage!
  //    let imageView = UIImageView(frame: CGRect(x: self.view.bounds.width/2,y: self.view.bounds.height * 0.15 + 20,width: self.view.bounds.width * 0.7,height: self.view.bounds.height * 0.3))
  //    imageView.image = image
  //    // UIImageViewのインスタンスをビューに追加
  //    // 画像の表示する座標を指定する.
  //    imageView.center = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height * 0.2)
  //    self.view.addSubview(imageView)
  //  }
  
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
  
  func PhotoTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: CaptureController = CaptureController()
    //mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  func SaveTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: CaptureFurnitureController = CaptureFurnitureController()
    //mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  
  func HomeTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: ChoiceController = ChoiceController()
    //mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    // rootViewControllerの2つ先のViewControllerに戻る
    //self.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  func fromRGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> HSV {
    // R、GおよびBが0.0を最小量、1.0を最大値とする0.0から1.0の範囲にある
    let r = Double(red)
    let g = Double(green)
    let b = Double(blue)
    
    let maxValue = max(max(r, g), b)
    let minValue = min(min(r, g), b)
    let sub = maxValue - minValue
    
    var h: Double = 0
    var s: Double = 0
    var v: Double = 0
    
    // Calculate Hue
    if sub == 0 {
      // MAX = MIN(例・S = 0)のとき、 Hは定義されない。
      h = 0
    } else {
      if (maxValue == r) {
        h = (60 * (g - b) / sub) + 0;
      } else if (maxValue == g) {
        h = (60 * (b - r) / sub) + 120;
      } else if (maxValue == b) {
        h = (60 * (r - g) / sub) + 240;
      }
      // さらに H += 360 if H < 0
      if (h < 0) {
        h += 360;
      }
    }
    
    // Calculate Saturation
    if (maxValue > 0) {
      s = sub / maxValue * 255;
    }
    
    // Calculate Value
    v = maxValue * 255
    
    return HSV(hue: floor(h), saturation: floor(s), value: floor(v))
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