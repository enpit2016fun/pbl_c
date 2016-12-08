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
    self.luckyView.backgroundColor = UIColor.whiteColor()
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
      lifeView.image = loveImage
      self.view.addSubview(lifeView)
      let lifeLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      lifeLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.2 , y:self.view.bounds.height * 0.60)
      lifeLabel.textAlignment = NSTextAlignment.Center
      lifeLabel.textColor = UIColor.lightGrayColor()
      lifeLabel.text = "健康運"
      lifeLabel.font = UIFont(name:"HiraKakuProN-W6",size:15)
      self.view.addSubview(lifeLabel)
      let lifeDirectionLabel:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
      lifeDirectionLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.2 , y:self.view.bounds.height * 0.65)
      lifeDirectionLabel.textAlignment = NSTextAlignment.Center
      lifeDirectionLabel.textColor = UIColor.orangeColor()
      lifeDirectionLabel.text = "北東"
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
      healthDirectionLabel.text = "北西"
      healthDirectionLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
      self.view.addSubview(healthDirectionLabel)
          
    }else if selectedColor! == "ピンク" {
      let jobView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      jobView.center = CGPoint(x:self.view.bounds.width/4,y:self.view.bounds.height * 0.7)
      // UIImageViewに画像を設定する.
      jobView.image = jobImage
      self.view.addSubview(jobView)
      fortuneLabel.text = "仕事運"
      for farr in fortuneArray {
        print(farr.name!)
        if (farr.name! == "仕事運"){
          self.luckyView.backgroundColor = farr.color
          colorName = farr.colorName!
          self.luckyLabel.text = "ラッキーカラー：\(farr.colorName!)"
          self.view.addSubview(luckyLabel)
          print(farr.name)
          print(farr.color)
          self.view.addSubview(luckyView)
        }
      }
      
    }else if selectedColor! == "茶" {
      let jobView = UIImageView(frame: CGRect(x:0, y:0, width: 70, height: 70))
      jobView.center = CGPoint(x:self.view.bounds.width/4,y:self.view.bounds.height * 0.7)
      // UIImageViewに画像を設定する.
      jobView.image = moneyImage
      self.view.addSubview(jobView)
      fortuneLabel.text = "金運"
      for farr in fortuneArray {
        print(farr.name!)
        if (farr.name! == "金運"){
          self.luckyView.backgroundColor = farr.color
          colorName = farr.colorName!
          self.luckyLabel.text = "ラッキーカラー：\(farr.colorName!)"
          self.view.addSubview(luckyLabel)
          print(farr.name!)
          print(farr.color!)
          self.view.addSubview(luckyView)
        }
      }
      
      
    }else if selectedColor! == "赤" {
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
          colorName = farr.colorName!
          self.luckyLabel.text = "ラッキーカラー：\(farr.colorName!)"
          self.view.addSubview(luckyLabel)
          print(farr.name)
          print(farr.color)
          self.view.addSubview(luckyView)
        }
      }
      
    }else if selectedColor! == "青" {
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
          colorName = farr.colorName!
          self.luckyLabel.text = "ラッキーカラー：\(farr.colorName!)"
          self.view.addSubview(luckyLabel)
          print(farr.name!)
          print(farr.color!)
          self.view.addSubview(luckyView)
        }
      }
      
    }else if selectedColor! == "紫" {
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
          colorName = farr.colorName!
          self.luckyLabel.text = "ラッキーカラー：\(farr.colorName!)"
          self.view.addSubview(luckyLabel)
          print(farr.name)
          print(farr.color)
          self.view.addSubview(luckyView)
        }
      }
      
    }else if selectedColor! == "緑" {
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
          colorName = farr.colorName!
          self.luckyLabel.text = "ラッキーカラー：\(farr.colorName!)"
          self.view.addSubview(luckyLabel)
          print(farr.name)
          print(farr.color)
          self.view.addSubview(luckyView)
        }
      }
      
    }else if selectedColor! == "黄緑" {
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