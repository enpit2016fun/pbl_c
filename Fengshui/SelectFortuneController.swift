//
//  SelectFortuneController.swift
//  Fengshui
//
//  Created by 渡邊翼 on 2016/11/04.
//  Copyright © 2016年 渡邊翼. All rights reserved.
//

import UIKit

class SelectFortuneController: UIViewController,UIGestureRecognizerDelegate{
  var loveView: UIImageView!
  var jobView: UIImageView!
  var lifeView: UIImageView!
  var familiyView: UIImageView!
  var moneyView: UIImageView!
  var healthView: UIImageView!
  var depositView: UIImageView!
  var beautyView: UIImageView!
  var imageView: UIImageView!
  var loveLabel: UILabel!
  var jobLabel: UILabel!
  var lifeLabel: UILabel!
  var familyLabel: UILabel!
  var moneyLabel: UILabel!
  var healthLabel: UILabel!
  var depositLabel: UILabel!
  var beautyLabel: UILabel!
  var loveImage = UIImage(named:"恋愛_180pt.png")
  var jobImage = UIImage(named:"仕事_180pt.png")
  var lifeImage = UIImage(named:"人生運.png")
  var myImage = UIImage(named:"女の子アイコン")
  var familyImage = UIImage(named:"家族_180pt.png")
  var moneyImage = UIImage(named:"金運_180pt.png")
  var healthImage = UIImage(named:"健康_180pt.png")
  var depositImage = UIImage(named:"貯金_180pt.png")
  var beautyImage = UIImage(named:"美容_180pt.png")
  var locationLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageView = UIImageView(frame: CGRect(x: self.view.bounds.width / 2 - 70, y: self.view.bounds.height * 0.08, width: 140, height: 140))
    // UIImageViewに画像を設定する.
    imageView.image = myImage
    self.view.addSubview(imageView)
    // 方角を表示するラベルを作成する
    locationLabel = UILabel(frame: CGRectMake(0,0,300,50))
    locationLabel.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height * 0.43)
    locationLabel.textAlignment = NSTextAlignment.Center
    locationLabel.text = "どの運勢を占いますか？"
    locationLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
    self.view.addSubview(locationLabel)
    
    // 家族運を表示するラベルを作成する
    familyLabel = UILabel(frame: CGRectMake(0,0,100,50))
    familyLabel.layer.position = CGPoint(x: self.view.bounds.width * (2/16) , y:self.view.bounds.height * 0.91)
    familyLabel.textAlignment = NSTextAlignment.Center
    familyLabel.text = "家族運"
    familyLabel.textColor = UIColor.lightGrayColor()
    familyLabel.font = UIFont(name:"HiraKakuProN-W6",size:12)
    self.view.addSubview(familyLabel)
    
    // 恋愛運を表示するラベルを作成する
    loveLabel = UILabel(frame: CGRectMake(0,0,100,50))
    loveLabel.layer.position = CGPoint(x: self.view.bounds.width * (14/16) , y:self.view.bounds.height * 0.91)
    loveLabel.textAlignment = NSTextAlignment.Center
    loveLabel.text = "恋愛運"
    loveLabel.textColor = UIColor.lightGrayColor()
    loveLabel.font = UIFont(name:"HiraKakuProN-W6",size:12)
    self.view.addSubview(loveLabel)
    
    // 仕事運を表示するラベルを作成する
    jobLabel = UILabel(frame: CGRectMake(0,0,100,50))
    jobLabel.layer.position = CGPoint(x: self.view.bounds.width * (6/16) , y:self.view.bounds.height * 0.91)
    jobLabel.textAlignment = NSTextAlignment.Center
    jobLabel.text = "仕事運"
    jobLabel.textColor = UIColor.lightGrayColor()
    jobLabel.font = UIFont(name:"HiraKakuProN-W6",size:12)
    self.view.addSubview(jobLabel)
    
    // 人生運を表示するラベルを作成する
    lifeLabel = UILabel(frame: CGRectMake(0,0,100,50))
    lifeLabel.layer.position = CGPoint(x: self.view.bounds.width * (10/16) , y:self.view.bounds.height * 0.91)
    lifeLabel.textAlignment = NSTextAlignment.Center
    lifeLabel.text = "人生運"
    lifeLabel.textColor = UIColor.lightGrayColor()
    lifeLabel.font = UIFont(name:"HiraKakuProN-W6",size:12)
    self.view.addSubview(lifeLabel)
    
    
    // 貯金運を表示するラベルを作成する
    depositLabel = UILabel(frame: CGRectMake(0,0,100,50))
    depositLabel.layer.position = CGPoint(x: self.view.bounds.width * (2/16) , y:self.view.bounds.height * 0.71)
    depositLabel.textAlignment = NSTextAlignment.Center
    depositLabel.text = "貯金運"
    depositLabel.textColor = UIColor.lightGrayColor()
    depositLabel.font = UIFont(name:"HiraKakuProN-W6",size:12)
    self.view.addSubview(depositLabel)
    
    // 美容運を表示するラベルを作成する
    beautyLabel = UILabel(frame: CGRectMake(0,0,100,50))
    beautyLabel.layer.position = CGPoint(x: self.view.bounds.width * (14/16) , y:self.view.bounds.height * 0.71)
    beautyLabel.textAlignment = NSTextAlignment.Center
    beautyLabel.text = "美容運"
    beautyLabel.textColor = UIColor.lightGrayColor()
    beautyLabel.font = UIFont(name:"HiraKakuProN-W6",size:12)
    self.view.addSubview(beautyLabel)
    
    // 健康運を表示するラベルを作成する
    beautyLabel = UILabel(frame: CGRectMake(0,0,100,50))
    beautyLabel.layer.position = CGPoint(x: self.view.bounds.width * (6/16) , y:self.view.bounds.height * 0.71)
    beautyLabel.textAlignment = NSTextAlignment.Center
    beautyLabel.text = "健康運"
    beautyLabel.textColor = UIColor.lightGrayColor()
    beautyLabel.font = UIFont(name:"HiraKakuProN-W6",size:12)
    self.view.addSubview(beautyLabel)
    
    // 金運を表示するラベルを作成する
    moneyLabel = UILabel(frame: CGRectMake(0,0,100,50))
    moneyLabel.layer.position = CGPoint(x: self.view.bounds.width * (10/16) , y:self.view.bounds.height * 0.71)
    moneyLabel.textAlignment = NSTextAlignment.Center
    moneyLabel.text = "金運"
    moneyLabel.textColor = UIColor.lightGrayColor()
    moneyLabel.font = UIFont(name:"HiraKakuProN-W6",size:12)
    self.view.addSubview(moneyLabel)
    
    
    
    loveView = UIImageView(frame: CGRect(x: self.view.bounds.width * (12.4/16)  , y: self.view.bounds.height * 0.75, width: 65, height: 65))
    // UIImageViewに画像を設定する.
    loveView.image = loveImage
    
    loveView.userInteractionEnabled = true
    
    let loveTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectFortuneController.loveTapAction(_:)))
    loveTap.delegate = self
    
    loveView.addGestureRecognizer(loveTap)
    // Viewに張りつけ.
    self.view.addSubview(loveView)
    
    
    
    familiyView = UIImageView(frame: CGRect(x: self.view.bounds.width * (0.4/16)   , y: self.view.bounds.height * 0.75, width: 65, height: 65))
    // UIImageViewに画像を設定する.
    familiyView.image = familyImage
    
    familiyView.userInteractionEnabled = true
    
    let familyTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectFortuneController.familyTapAction(_:)))
    familyTap.delegate = self
    
    familiyView.addGestureRecognizer(familyTap)
    // Viewに張りつけ.
    self.view.addSubview(familiyView)
    
    jobView = UIImageView(frame: CGRect(x: self.view.bounds.width * (4.4/16)  , y: self.view.bounds.height * 0.75, width: 65, height: 65))
    // UIImageViewに画像を設定する.
    jobView.image = jobImage
    
    jobView.userInteractionEnabled = true
    
    let jobTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectFortuneController.jobTapAction(_:)))
    jobTap.delegate = self
    
    jobView.addGestureRecognizer(jobTap)
    // Viewに張りつけ.
    self.view.addSubview(jobView)
    
    lifeView = UIImageView(frame: CGRect(x: self.view.bounds.width * (8.4/16) , y: self.view.bounds.height * 0.75, width: 65, height: 65))
    // UIImageViewに画像を設定する.
    lifeView.image = lifeImage
    
    lifeView.userInteractionEnabled = true
    
    let lifeTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectFortuneController.lifeTapAction(_:)))
    
    lifeTap.delegate = self
    
    lifeView.addGestureRecognizer(lifeTap)
    // Viewに張りつけ.
    self.view.addSubview(lifeView)
    
    
    
    moneyView = UIImageView(frame: CGRect(x: self.view.bounds.width * (12.4/16)  , y: self.view.bounds.height * 0.55, width: 65, height: 65))
    // UIImageViewに画像を設定する.
    moneyView.image = moneyImage
    
    moneyView.userInteractionEnabled = true
    
    let moneyTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectFortuneController.moneyTapAction(_:)))
    moneyTap.delegate = self
    
    moneyView.addGestureRecognizer(moneyTap)
    // Viewに張りつけ.
    self.view.addSubview(moneyView)
    
    
    
    depositView = UIImageView(frame: CGRect(x: self.view.bounds.width * (0.4/16)   , y: self.view.bounds.height * 0.55, width: 65, height: 65))
    // UIImageViewに画像を設定する.
    depositView.image = depositImage
    
    depositView.userInteractionEnabled = true
    
    let depositTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectFortuneController.depositTapAction(_:)))
    depositTap.delegate = self
    
    depositView.addGestureRecognizer(depositTap)
    // Viewに張りつけ.
    self.view.addSubview(depositView)
    
    beautyView = UIImageView(frame: CGRect(x: self.view.bounds.width * (4.4/16)  , y: self.view.bounds.height * 0.55, width: 65, height: 65))
    // UIImageViewに画像を設定する.
    beautyView.image = beautyImage
    
    beautyView.userInteractionEnabled = true
    
    let beautyTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectFortuneController.beautyTapAction(_:)))
    beautyTap.delegate = self
    
    beautyView.addGestureRecognizer(beautyTap)
    // Viewに張りつけ.
    self.view.addSubview(beautyView)
    
    healthView = UIImageView(frame: CGRect(x: self.view.bounds.width * (8.4/16) , y: self.view.bounds.height * 0.55, width: 65, height: 65))
    // UIImageViewに画像を設定する.
    healthView.image = healthImage
    
    healthView.userInteractionEnabled = true
    
    let healthTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectFortuneController.healthTapAction(_:)))
    
    healthTap.delegate = self
    
    healthView.addGestureRecognizer(healthTap)
    // Viewに張りつけ.
    self.view.addSubview(healthView)
    
    
    
    
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func loveTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: ViewController = ViewController()
    mySecondViewController.selectFortune = "love"
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    appDelegate.selectedFortune = "love" //appDelegateの変数を操作
    // アニメーションを設定する.
    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  func jobTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: ViewController = ViewController()
    mySecondViewController.selectFortune = "job"
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    appDelegate.selectedFortune = "job" //appDelegateの変数を操作    // アニメーションを設定する.
    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  func moneyTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: ViewController = ViewController()
    mySecondViewController.selectFortune = "money"
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    appDelegate.selectedFortune = "money" //appDelegateの変数を操作
    // アニメーションを設定する.
    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  func depositTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: ViewController = ViewController()
    mySecondViewController.selectFortune = "deposit"
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    appDelegate.selectedFortune = "deposit" //appDelegateの変数を操作
    // アニメーションを設定する.
    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  func healthTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: ViewController = ViewController()
    mySecondViewController.selectFortune = "health"
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    appDelegate.selectedFortune = "health" //appDelegateの変数を操作
    // アニメーションを設定する.
    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }

  
  func beautyTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: ViewController = ViewController()
    mySecondViewController.selectFortune = "beauty"
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    appDelegate.selectedFortune = "beauty" //appDelegateの変数を操作
    // アニメーションを設定する.
    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }

  
  func familyTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: ViewController = ViewController()
    mySecondViewController.selectFortune = "family"
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    appDelegate.selectedFortune = "family" //appDelegateの変数を操作
    // アニメーションを設定する.
    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }

  
  func lifeTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: ViewController = ViewController()
    mySecondViewController.selectFortune = "life"
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    appDelegate.selectedFortune = "life" //appDelegateの変数を操作
    // アニメーションを設定する.
    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
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
  
}
