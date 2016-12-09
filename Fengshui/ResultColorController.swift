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


class ResultColorController: UIViewController,UIGestureRecognizerDelegate {
  var ResultLabel: UILabel!
  var PictureView: UIImageView!
  var takenImage:UIImage?
  var parameter: [String: AnyObject] = [:]
  var HomeImage = UIImage(named:"home.png")
  var HomeImageView: UIImageView!
  var SaveImage = UIImage(named:"save.png")
  var SaveImageView: UIImageView!
  var backImage = UIImage(named:"back.png")
  var PhotoImageView: UIImageView!
  var hanteiView: UIImageView!
  var hanteiImage = UIImage(named:"たいへんよくできました.png")
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
  var selectedColor:String?
  var fortuneLabel: UILabel!
  var furnitureLabel: UILabel!
  var kaisetsuLabel:UITextView!
  var luckyLabel: UILabel!
  var parsentLabel: UILabel!
  var isSuccess:Bool = false
  var fortuneArray:[Fortune] = []
  
  
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
    // Viewの背景色を白色にする
    self.view.backgroundColor = UIColor.whiteColor()
    selectedColor = appDelegate.selectedColor
    //Viewを並べる
    
    // ラッキーカラーを表示するラベルを作成する
    luckyLabel = UILabel(frame: CGRectMake(0,0,90,30))
    luckyLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.28)
    luckyLabel.textAlignment = NSTextAlignment.Center
    luckyLabel.font = UIFont(name:"HiraKakuProN-W6",size:10)
    luckyLabel.textColor = UIColor.lightGrayColor()
    luckyLabel.text = "白"
    self.view.addSubview(luckyLabel)
    
    self.luckyView = UIView(frame: CGRectMake(0,0,80,80))
    self.luckyView.center = CGPoint(x:self.view.bounds.width * 0.5 ,y:self.view.bounds.height * 0.25)
    luckyView.layer.borderWidth = 0.5
    luckyView.layer.borderColor = UIColor.lightGrayColor().CGColor
    self.view.addSubview(luckyView)
    
    // 運勢タイプを表示するラベルを作成する
    fortuneLabel = UILabel(frame: CGRectMake(0,0,100,50))
    fortuneLabel.layer.position = CGPoint(x: self.view.bounds.width/4 , y:self.view.bounds.height * 0.8)
    fortuneLabel.textAlignment = NSTextAlignment.Center
    fortuneLabel.font = UIFont(name:"HiraKakuProN-W6",size:18)
    fortuneLabel.textColor = UIColor.lightGrayColor()
    self.view.addSubview(fortuneLabel)
    
    //選んだ運勢に合わせて画像を表示
    if selectedColor! == "白" {
      let lifeView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      lifeView.center = CGPoint(x:self.view.bounds.width * 0.2,y:self.view.bounds.height * 0.5)
      lifeView.image = lifeImage
      self.view.addSubview(lifeView)
      let lifeLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      lifeLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.2 , y:self.view.bounds.height * 0.60)
      lifeLabel.textAlignment = NSTextAlignment.Center
      lifeLabel.textColor = UIColor.lightGrayColor()
      lifeLabel.text = "人生運"
      lifeLabel.font = UIFont(name:"HiraKakuProN-W6",size:15)
      self.view.addSubview(lifeLabel)
      let lifeDirectionLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      lifeDirectionLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.2 , y:self.view.bounds.height * 0.65)
      lifeDirectionLabel.textAlignment = NSTextAlignment.Center
      lifeDirectionLabel.textColor = UIColor.orangeColor()
      lifeDirectionLabel.text = "北西"
      lifeDirectionLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
      self.view.addSubview(lifeDirectionLabel)
      let depositView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      depositView.center = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height * 0.5)
      depositView.image = depositImage
      self.view.addSubview(depositView)
      let depositLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      depositLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.60)
      depositLabel.textAlignment = NSTextAlignment.Center
      depositLabel.textColor = UIColor.lightGrayColor()
      depositLabel.text = "貯金運"
      depositLabel.font = UIFont(name:"HiraKakuProN-W6",size:15)
      self.view.addSubview(depositLabel)
      let depositDirectionLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      depositDirectionLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.65)
      depositDirectionLabel.textAlignment = NSTextAlignment.Center
      depositDirectionLabel.textColor = UIColor.orangeColor()
      depositDirectionLabel.text = "北"
      depositDirectionLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
      self.view.addSubview(depositDirectionLabel)
      let healthView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      healthView.center = CGPoint(x:self.view.bounds.width * 0.8,y:self.view.bounds.height * 0.5)
      healthView.image = healthImage
      self.view.addSubview(healthView)
      let healthLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      healthLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.8 , y:self.view.bounds.height * 0.60)
      healthLabel.textAlignment = NSTextAlignment.Center
      healthLabel.textColor = UIColor.lightGrayColor()
      healthLabel.text = "健康運"
      healthLabel.font = UIFont(name:"HiraKakuProN-W6",size:15)
      self.view.addSubview(healthLabel)
      let healthDirectionLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      healthDirectionLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.8 , y:self.view.bounds.height * 0.65)
      healthDirectionLabel.textAlignment = NSTextAlignment.Center
      healthDirectionLabel.textColor = UIColor.orangeColor()
      healthDirectionLabel.text = "北東"
      healthDirectionLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
      self.view.addSubview(healthDirectionLabel)
      self.luckyView.backgroundColor = UIColor.whiteColor()
      self.view.addSubview(luckyView)
          
    }else if selectedColor! == "ピンク" {
      let depositView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      depositView.center = CGPoint(x:self.view.bounds.width * 0.3,y:self.view.bounds.height * 0.5)
      depositView.image = depositImage
      self.view.addSubview(depositView)
      let depositLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      depositLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.3 , y:self.view.bounds.height * 0.60)
      depositLabel.textAlignment = NSTextAlignment.Center
      depositLabel.textColor = UIColor.lightGrayColor()
      depositLabel.text = "貯金運"
      depositLabel.font = UIFont(name:"HiraKakuProN-W6",size:15)
      self.view.addSubview(depositLabel)
      let depositDirectionLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      depositDirectionLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.3 , y:self.view.bounds.height * 0.65)
      depositDirectionLabel.textAlignment = NSTextAlignment.Center
      depositDirectionLabel.textColor = UIColor.orangeColor()
      depositDirectionLabel.text = "北"
      depositDirectionLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
      self.view.addSubview(depositDirectionLabel)
      self.luckyView.backgroundColor = UIColor.magentaColor()
      self.view.addSubview(luckyView)
      let loveView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      loveView.center = CGPoint(x:self.view.bounds.width * 0.7,y:self.view.bounds.height * 0.5)
      loveView.image = loveImage
      self.view.addSubview(loveView)
      let loveLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      loveLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.7 , y:self.view.bounds.height * 0.60)
      loveLabel.textAlignment = NSTextAlignment.Center
      loveLabel.textColor = UIColor.lightGrayColor()
      loveLabel.text = "恋愛運"
      loveLabel.font = UIFont(name:"HiraKakuProN-W6",size:15)
      self.view.addSubview(loveLabel)
      let loveDirectionLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      loveDirectionLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.7 , y:self.view.bounds.height * 0.65)
      loveDirectionLabel.textAlignment = NSTextAlignment.Center
      loveDirectionLabel.textColor = UIColor.orangeColor()
      loveDirectionLabel.text = "南東"
      loveDirectionLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
      self.view.addSubview(loveDirectionLabel)
      self.luckyView.backgroundColor = UIColor(red: 124.0/255, green: 96.0/255, blue: 53.0/255, alpha: 1.0)
      self.view.addSubview(luckyView)
      
    }else if selectedColor! == "茶" {
      let familyView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      familyView.center = CGPoint(x:self.view.bounds.width * 0.3,y:self.view.bounds.height * 0.5)
      familyView.image = familyImage
      self.view.addSubview(familyView)
      let familyLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      familyLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.3 , y:self.view.bounds.height * 0.60)
      familyLabel.textAlignment = NSTextAlignment.Center
      familyLabel.textColor = UIColor.lightGrayColor()
      familyLabel.text = "家族運"
      familyLabel.font = UIFont(name:"HiraKakuProN-W6",size:15)
      self.view.addSubview(familyLabel)
      let familyDirectionLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      familyDirectionLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.3 , y:self.view.bounds.height * 0.65)
      familyDirectionLabel.textAlignment = NSTextAlignment.Center
      familyDirectionLabel.textColor = UIColor.orangeColor()
      familyDirectionLabel.text = "南西"
      familyDirectionLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
      self.view.addSubview(familyDirectionLabel)
      let lifeView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      lifeView.center = CGPoint(x:self.view.bounds.width * 0.7,y:self.view.bounds.height * 0.5)
      lifeView.image = lifeImage
      self.view.addSubview(lifeView)
      let lifeLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      lifeLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.7 , y:self.view.bounds.height * 0.60)
      lifeLabel.textAlignment = NSTextAlignment.Center
      lifeLabel.textColor = UIColor.lightGrayColor()
      lifeLabel.text = "人生運"
      lifeLabel.font = UIFont(name:"HiraKakuProN-W6",size:15)
      self.view.addSubview(lifeLabel)
      let lifeDirectionLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      lifeDirectionLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.7 , y:self.view.bounds.height * 0.65)
      lifeDirectionLabel.textAlignment = NSTextAlignment.Center
      lifeDirectionLabel.textColor = UIColor.orangeColor()
      lifeDirectionLabel.text = "北西"
      lifeDirectionLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
      self.view.addSubview(lifeDirectionLabel)
      self.luckyView.backgroundColor = UIColor(red: 124.0/255, green: 96.0/255, blue: 53.0/255, alpha: 1.0)
      self.view.addSubview(luckyView)

      
      
    }else if selectedColor! == "赤" {
      let jobView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      jobView.center = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height * 0.5)
      jobView.image = jobImage
      self.view.addSubview(jobView)
      let jobLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      jobLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.60)
      jobLabel.textAlignment = NSTextAlignment.Center
      jobLabel.textColor = UIColor.lightGrayColor()
      jobLabel.text = "仕事運"
      jobLabel.font = UIFont(name:"HiraKakuProN-W6",size:15)
      self.view.addSubview(jobLabel)
      let jobDirectionLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      jobDirectionLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.65)
      jobDirectionLabel.textAlignment = NSTextAlignment.Center
      jobDirectionLabel.textColor = UIColor.orangeColor()
      jobDirectionLabel.text = "東"
      jobDirectionLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
      self.view.addSubview(jobDirectionLabel)
      self.luckyView.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
      self.view.addSubview(luckyView)
      
    }else if selectedColor! == "青" {
      let jobView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      jobView.center = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height * 0.5)
      jobView.image = jobImage
      self.view.addSubview(jobView)
      let jobLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      jobLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.60)
      jobLabel.textAlignment = NSTextAlignment.Center
      jobLabel.textColor = UIColor.lightGrayColor()
      jobLabel.text = "仕事運"
      jobLabel.font = UIFont(name:"HiraKakuProN-W6",size:15)
      self.view.addSubview(jobLabel)
      let jobDirectionLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      jobDirectionLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.65)
      jobDirectionLabel.textAlignment = NSTextAlignment.Center
      jobDirectionLabel.textColor = UIColor.orangeColor()
      jobDirectionLabel.text = "東"
      jobDirectionLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
      self.view.addSubview(jobDirectionLabel)
      self.luckyView.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
      self.view.addSubview(luckyView)
      

      self.luckyView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1.0)
      self.view.addSubview(luckyView)
      
    }else if selectedColor! == "紫" {
      let healthView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      healthView.center = CGPoint(x:self.view.bounds.width * 0.5,y:self.view.bounds.height * 0.5)
      healthView.image = healthImage
      self.view.addSubview(healthView)
      let healthLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      healthLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.60)
      healthLabel.textAlignment = NSTextAlignment.Center
      healthLabel.textColor = UIColor.lightGrayColor()
      healthLabel.text = "健康運"
      healthLabel.font = UIFont(name:"HiraKakuProN-W6",size:15)
      self.view.addSubview(healthLabel)
      let healthDirectionLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      healthDirectionLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.65)
      healthDirectionLabel.textAlignment = NSTextAlignment.Center
      healthDirectionLabel.textColor = UIColor.orangeColor()
      healthDirectionLabel.text = "北東"
      healthDirectionLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
      self.view.addSubview(healthDirectionLabel)
      self.luckyView.backgroundColor = UIColor(red: 142.0/255, green: 0.0, blue: 204.0/255, alpha: 1.0)
      self.luckyView.addSubview(luckyView)
    }else if selectedColor! == "緑" {
      let beautyView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      beautyView.center = CGPoint(x:self.view.bounds.width * 0.5,y:self.view.bounds.height * 0.5)
      beautyView.image = beautyImage
      self.view.addSubview(beautyView)
      let beautyLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      beautyLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.60)
      beautyLabel.textAlignment = NSTextAlignment.Center
      beautyLabel.textColor = UIColor.lightGrayColor()
      beautyLabel.text = "美容運"
      beautyLabel.font = UIFont(name:"HiraKakuProN-W6",size:15)
      self.view.addSubview(beautyLabel)
      let beautyDirectionLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      beautyDirectionLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.65)
      beautyDirectionLabel.textAlignment = NSTextAlignment.Center
      beautyDirectionLabel.textColor = UIColor.orangeColor()
      beautyDirectionLabel.text = "南"
      beautyDirectionLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
      self.view.addSubview(beautyDirectionLabel)

      self.luckyView.backgroundColor = UIColor.greenColor()
      self.luckyView.addSubview(luckyView)
    }else if selectedColor! == "黄緑" {
      let familyView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      familyView.center = CGPoint(x:self.view.bounds.width * 0.5,y:self.view.bounds.height * 0.5)
      familyView.image = familyImage
      self.view.addSubview(familyView)
      let familyLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      familyLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.60)
      familyLabel.textAlignment = NSTextAlignment.Center
      familyLabel.textColor = UIColor.lightGrayColor()
      familyLabel.text = "家族運"
      familyLabel.font = UIFont(name:"HiraKakuProN-W6",size:15)
      self.view.addSubview(familyLabel)
      let familyDirectionLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      familyDirectionLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.65)
      familyDirectionLabel.textAlignment = NSTextAlignment.Center
      familyDirectionLabel.textColor = UIColor.orangeColor()
      familyDirectionLabel.text = "南西"
      familyDirectionLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
      self.view.addSubview(familyDirectionLabel)
      self.luckyView.backgroundColor = UIColor(red: 171.0/255, green: 255.0/255, blue: 127.0/255, alpha: 1.0)
      self.luckyView.addSubview(luckyView)
    }else {
      let moneyView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      moneyView.center = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height * 0.5)
      moneyView.image = moneyImage
      self.view.addSubview(moneyView)
      let moneyLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      moneyLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.60)
      moneyLabel.textAlignment = NSTextAlignment.Center
      moneyLabel.textColor = UIColor.lightGrayColor()
      moneyLabel.text = "金運"
      moneyLabel.font = UIFont(name:"HiraKakuProN-W6",size:15)
      self.view.addSubview(moneyLabel)
      let moneyDirectionLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      moneyDirectionLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.65)
      moneyDirectionLabel.textAlignment = NSTextAlignment.Center
      moneyDirectionLabel.textColor = UIColor.orangeColor()
      moneyDirectionLabel.text = "西"
      moneyDirectionLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
      self.view.addSubview(moneyDirectionLabel)
      self.luckyView.backgroundColor = UIColor.yellowColor()
      self.luckyView.addSubview(luckyView)
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
    PhotoImageView.image = backImage
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
    ResultLabel.text = "上昇する運"
    ResultLabel.font = UIFont(name:"HiraKakuProN-W6",size:15)
    self.view.addSubview(ResultLabel)
    
  }
  

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
  func PhotoTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: ColorChoiceController = ColorChoiceController()
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
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
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