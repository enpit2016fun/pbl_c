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
  var titleView: UIImageView!
  var furnitureView: UIImageView!
  var roomView: UIImageView!
  var fortuneView: UIImageView!
  var titleImage = UIImage(named:"ホーム帯.jpg")
  var furnitureImage = UIImage(named:"ホーム画面：家具から占う.jpg")
  var roomImage = UIImage(named:"ホーム画面：部屋から占う.jpg")
  var fortuneImage = UIImage(named:"ホーム画面：運勢から占う.jpg")
  var roomLabel: UILabel!
  var fortuneLabel: UILabel!
  var furnitureLabel: UILabel!
  var fortuneArray:[Fortune] = []
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    setupFortune()
    titleView = UIImageView(frame: CGRect(x: 0 , y:self.view.bounds.height * 0.04  , width: self.view.bounds.width, height: self.view.bounds.height * 0.15))
    // UIImageViewに画像を設定する.
    titleView.image = titleImage
    self.view.addSubview(titleView)
    
    furnitureView = UIImageView(frame: CGRect(x: 0 , y: self.view.bounds.height * 0.73, width: self.view.bounds.width, height: self.view.bounds.height * 0.27))
    // UIImageViewに画像を設定する.
    furnitureView.image = furnitureImage
    
    furnitureView.userInteractionEnabled = true
    
    let furnitureTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChoiceController.furnitureTapAction(_:)))
    furnitureTap.delegate = self
    furnitureTap.cancelsTouchesInView = false
    furnitureView.addGestureRecognizer(furnitureTap)
    self.view.addSubview(furnitureView)

    
    fortuneView = UIImageView(frame: CGRect(x: 0 , y: self.view.bounds.height * 0.46, width: self.view.bounds.width, height: self.view.bounds.height * 0.27))
    // UIImageViewに画像を設定する.
    fortuneView.image = fortuneImage
    
    fortuneView.userInteractionEnabled = true
    
    let fortuneTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChoiceController.fortuneTapAction(_:)))
    fortuneTap.delegate = self
    fortuneTap.cancelsTouchesInView = false
    fortuneView.addGestureRecognizer(fortuneTap)
    self.view.addSubview(fortuneView)
    roomView = UIImageView(frame: CGRect(x: 0 , y: self.view.bounds.height * 0.19, width: self.view.bounds.width, height: self.view.bounds.height * 0.27))
    // UIImageViewに画像を設定する.
    roomView.image = roomImage
    
    
    roomView.userInteractionEnabled = true
    
    let roomTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChoiceController.roomTapAction(_:)))
    roomTap.delegate = self
    roomTap.cancelsTouchesInView = false
    roomView.addGestureRecognizer(roomTap)
    self.view.addSubview(roomView)
    // Do any additional setup after loading the view.
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
