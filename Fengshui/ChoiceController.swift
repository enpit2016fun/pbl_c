//
//  ChoiceController.swift
//  Fengshui
//
//  Created by 渡邊翼 on 2016/11/25.
//  Copyright © 2016年 渡邊翼. All rights reserved.
//

import UIKit

class ChoiceController: UIViewController,UIGestureRecognizerDelegate {
    //testest
    //test2
  var titleView: UIImageView!
  var furnitureView: UIImageView!
  var roomView: UIImageView!
  var fortuneView: UIImageView!
  var titleImage = UIImage(named:"ホーム帯.jpg")
  var furnitureImage = UIImage(named:"ソファー.png")
  var roomImage = UIImage(named:"家.png")
  var fortuneImage = UIImage(named:"水晶.png")
  var furnitureBackImage = UIImage(named: "家具から占う背景.png")
  var roomBackImage = UIImage(named: "部屋から占う背景.png")
  var fortuneBackImage = UIImage(named: "運勢から占う背景.png")
  var roomLabel: UILabel!
  var fortuneLabel: UILabel!
  var furnitureLabel: UILabel!
  var fortuneArray:[Fortune] = []
    
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    setupFortune()
    
    /*ホーム帯*/
    titleView = UIImageView(frame: CGRect(x: 0 , y: 0 , width: self.view.bounds.width, height: self.view.bounds.height * 0.16))
    // UIImageViewに画像を設定する.
    titleView.image = titleImage
    self.view.addSubview(titleView)
    
    /*家具から占う*/
    furnitureView = UIImageView(frame: CGRect(x: 0 , y: self.view.bounds.height * 0.72, width: self.view.bounds.width, height: self.view.bounds.height * 0.28))
    // UIImageViewに画像を設定する.
    furnitureView.image = furnitureBackImage
    
    furnitureView.userInteractionEnabled = true
    
    let furnitureTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChoiceController.furnitureTapAction(_:)))
    furnitureTap.delegate = self
    furnitureTap.cancelsTouchesInView = false
    furnitureView.addGestureRecognizer(furnitureTap)
    self.view.addSubview(furnitureView)
    
    //家具から占うアイコンを表示
    furnitureView = UIImageView(frame: CGRect(x: self.view.bounds.width * 0.28 , y: self.view.bounds.height * 0.8, width: self.view.bounds.width * 0.20, height: self.view.bounds.height * 0.11))
    furnitureView.image = furnitureImage
    self.view.addSubview(furnitureView)
    //家具から占う文字を表示
    furnitureLabel = UILabel(frame: CGRectMake(0,0,300,50))
    furnitureLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.72,y: self.view.bounds.height * 0.85)
    furnitureLabel.text = "家具から占う"
    furnitureLabel.textColor = UIColor.whiteColor()
    furnitureLabel.font = UIFont(name:"HiraKakuProN-W3",size:27)
    self.view.addSubview(furnitureLabel)
    

    /*運勢から占う*/
    fortuneView = UIImageView(frame: CGRect(x: 0 , y: self.view.bounds.height * 0.44, width: self.view.bounds.width, height: self.view.bounds.height * 0.28))
    // UIImageViewに画像を設定する.
    fortuneView.image = fortuneBackImage
    //fortuneView.image = fortuneImage
    
    fortuneView.userInteractionEnabled = true
    
    let fortuneTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChoiceController.fortuneTapAction(_:)))
    fortuneTap.delegate = self
    fortuneTap.cancelsTouchesInView = false
    fortuneView.addGestureRecognizer(fortuneTap)
    self.view.addSubview(fortuneView)
    
    //運勢から占うアイコンの表示
    fortuneView = UIImageView(frame: CGRect(x: self.view.bounds.width * 0.30 , y: self.view.bounds.height * 0.5, width: self.view.bounds.width * 0.16, height: self.view.bounds.height * 0.15))
    fortuneView.image = fortuneImage
    self.view.addSubview(fortuneView)
    //運勢から占う文字表示
    fortuneLabel = UILabel(frame: CGRectMake(0,0,300,50))
    fortuneLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.72,y: self.view.bounds.height * 0.58)
    fortuneLabel.text = "運勢から占う"
    fortuneLabel.textColor = UIColor.whiteColor()
    fortuneLabel.font = UIFont(name:"HiraKakuProN-W3",size:27)
    self.view.addSubview(fortuneLabel)
    

    /*部屋から占う*/
    roomView = UIImageView(frame: CGRect(x: 0 , y: self.view.bounds.height * 0.16, width: self.view.bounds.width, height: self.view.bounds.height * 0.28))
    // UIImageViewに画像を設定する.
    roomView.image = roomBackImage
    //roomView.image = roomImage
    
    roomView.userInteractionEnabled = true
    
    let roomTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChoiceController.roomTapAction(_:)))
    roomTap.delegate = self
    roomTap.cancelsTouchesInView = false
    roomView.addGestureRecognizer(roomTap)
    self.view.addSubview(roomView)
    
    //部屋から占うアイコン表示
    roomView = UIImageView(frame: CGRect(x: self.view.bounds.width * 0.28 , y: self.view.bounds.height * 0.23, width: self.view.bounds.width * 0.2, height: self.view.bounds.height * 0.13))
    roomView.image = roomImage
    self.view.addSubview(roomView)
    //部屋から占う文字表示
    roomLabel = UILabel(frame: CGRectMake(0,0,300,50))
    roomLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.72,y: self.view.bounds.height * 0.30)
    roomLabel.text = "部屋から占う"
    roomLabel.textColor = UIColor.whiteColor()
    roomLabel.font = UIFont(name:"HiraKakuProN-W3",size:27)
    self.view.addSubview(roomLabel)
    
    // Do any additional setup after loading the view.
    
    //実機の画面のお大きさチェック
    print("width: \(self.view.bounds.width)")
    print("height: \(self.view.bounds.height)")
    
    //縦横比対応
    if(self.view.bounds.width == 1024 && self.view.bounds.height == 1366){
        print("test")
    }
  }
    
    
  
  func furnitureTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: ColorChoiceController = ColorChoiceController()
    //mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  func roomTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: CaptureFurnitureController = CaptureFurnitureController()
    //mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  func fortuneTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: SelectFortuneController = SelectFortuneController()
    //mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }


  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setupFortune(){
    let moneyFortune = Fortune()
    moneyFortune.name = "金運"
    moneyFortune.color = UIColor(red: 255 / 255, green:255  / 255, blue: 0 / 255, alpha: 1.0)
    moneyFortune.direction = "西"
    moneyFortune.colorName = "黄"
    fortuneArray.append(moneyFortune)
    let lifeFortune = Fortune()
    lifeFortune.name = "人生運"
    lifeFortune.color = UIColor(red: 255 / 255, green:215  / 255, blue: 0 / 255, alpha: 1.0)
    lifeFortune.direction = "北西"
    lifeFortune.colorName = "金"
    fortuneArray.append(lifeFortune)
    let depositFortune = Fortune()
    depositFortune.name = "貯金運"
    depositFortune.color = UIColor(red: 255 / 255, green:0  / 255, blue: 255 / 255, alpha: 1.0)
    depositFortune.direction = "北"
    depositFortune.colorName = "ピンク"
    fortuneArray.append(depositFortune)
    let healthFortune = Fortune()
    healthFortune.name = "健康運"
    healthFortune.color = UIColor(red: 255 / 255, green:255  / 255, blue: 255 / 255, alpha: 1.0)
    healthFortune.direction = "北東"
    healthFortune.colorName = "白"
    fortuneArray.append(healthFortune)
    let jobFortune = Fortune()
    jobFortune.name = "仕事運"
    jobFortune.color = UIColor(red: 255 / 255, green:0  / 255, blue: 0 / 255, alpha: 1.0)
    jobFortune.direction = "東"
    jobFortune.colorName = "赤"
    fortuneArray.append(jobFortune)
    let loveFortune = Fortune()
    loveFortune.name = "恋愛運"
    loveFortune.color = UIColor(red: 255 / 255, green:0  / 255, blue: 255 / 255, alpha: 1.0)
    loveFortune.direction = "南東"
    loveFortune.colorName = "ピンク"
    fortuneArray.append(loveFortune)
    let beautyFortune = Fortune()
    beautyFortune.name = "美容運"
    beautyFortune.color = UIColor(red: 0 / 255, green:255  / 255, blue: 0 / 255, alpha: 1.0)
    beautyFortune.direction = "南"
    beautyFortune.colorName = "緑"
    fortuneArray.append(beautyFortune)
    let familyFortune = Fortune()
    familyFortune.name = "家族運"
    familyFortune.color = UIColor(red: 109 / 255, green:76  / 255, blue: 51 / 255, alpha: 1.0)
    familyFortune.direction = "南西"
    familyFortune.colorName = "茶色"
    fortuneArray.append(familyFortune)
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    appDelegate.farray = fortuneArray //appDelegateの変数を操作
    
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
