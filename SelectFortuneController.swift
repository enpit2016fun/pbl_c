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
  var imageView: UIImageView!
  var loveLabel: UILabel!
  var jobLabel: UILabel!
  var lifeLabel: UILabel!
  var loveImage = UIImage(named:"恋愛運.png")
  var jobImage = UIImage(named:"仕事運.png")
  var lifeImage = UIImage(named:"人生運.png")
  var myImage = UIImage(named:"女の子アイコン")
  var locationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      imageView = UIImageView(frame: CGRect(x: self.view.bounds.width / 2 - 90, y: self.view.bounds.height * 0.1, width: 180, height: 180))
      // UIImageViewに画像を設定する.
      imageView.image = myImage
      self.view.addSubview(imageView)
      // 方角を表示するラベルを作成する
      locationLabel = UILabel(frame: CGRectMake(0,0,300,50))
      locationLabel.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height * 0.55)
      locationLabel.textAlignment = NSTextAlignment.Center
      locationLabel.text = "どの運勢を占いますか？"
      locationLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
      self.view.addSubview(locationLabel)
      
      // 恋愛運を表示するラベルを作成する
      loveLabel = UILabel(frame: CGRectMake(0,0,100,50))
      loveLabel.layer.position = CGPoint(x: self.view.bounds.width * (1/3) - 40 , y:self.view.bounds.height * 0.90)
      loveLabel.textAlignment = NSTextAlignment.Center
      loveLabel.text = "恋愛運"
      loveLabel.textColor = UIColor.lightGrayColor()
      loveLabel.font = UIFont(name:"HiraKakuProN-W6",size:12)
      self.view.addSubview(loveLabel)

      // 仕事運を表示するラベルを作成する
      jobLabel = UILabel(frame: CGRectMake(0,0,100,50))
      jobLabel.layer.position = CGPoint(x: self.view.bounds.width * (1/2) , y:self.view.bounds.height * 0.90)
      jobLabel.textAlignment = NSTextAlignment.Center
      jobLabel.text = "仕事運"
      jobLabel.textColor = UIColor.lightGrayColor()
      jobLabel.font = UIFont(name:"HiraKakuProN-W6",size:12)
      self.view.addSubview(jobLabel)

      
      // 人生運を表示するラベルを作成する
      lifeLabel = UILabel(frame: CGRectMake(0,0,100,50))
      lifeLabel.layer.position = CGPoint(x: self.view.bounds.width * (2/3) + 40 , y:self.view.bounds.height * 0.90)
      lifeLabel.textAlignment = NSTextAlignment.Center
      lifeLabel.text = "人生運"
      lifeLabel.textColor = UIColor.lightGrayColor()
      lifeLabel.font = UIFont(name:"HiraKakuProN-W6",size:12)
      self.view.addSubview(lifeLabel)

      
      loveView = UIImageView(frame: CGRect(x: self.view.bounds.width * (1/3) - 80  , y: self.view.bounds.height * 0.7, width: 80, height: 80))
      // UIImageViewに画像を設定する.
      loveView.image = loveImage
      
      loveView.userInteractionEnabled = true
      
      let loveTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectFortuneController.loveTapAction(_:)))
      loveTap.delegate = self
      
      loveView.addGestureRecognizer(loveTap)
      // Viewに張りつけ.
      self.view.addSubview(loveView)
      
      jobView = UIImageView(frame: CGRect(x: self.view.bounds.width * (1/2) - 40 , y: self.view.bounds.height * 0.7, width: 80, height: 80))
      // UIImageViewに画像を設定する.
      jobView.image = jobImage
      
      jobView.userInteractionEnabled = true
      
      let jobTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectFortuneController.jobTapAction(_:)))
      jobTap.delegate = self
      
      jobView.addGestureRecognizer(jobTap)
      // Viewに張りつけ.
      self.view.addSubview(jobView)
      
      lifeView = UIImageView(frame: CGRect(x: self.view.bounds.width * (2/3) , y: self.view.bounds.height * 0.7, width: 80, height: 80))
      // UIImageViewに画像を設定する.
      lifeView.image = lifeImage
      
      lifeView.userInteractionEnabled = true
      
      let lifeTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectFortuneController.lifeTapAction(_:)))
      
      lifeTap.delegate = self
      
      lifeView.addGestureRecognizer(lifeTap)
      // Viewに張りつけ.
      self.view.addSubview(lifeView)
        
      
      
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
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
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
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    appDelegate.selectedFortune = "job" //appDelegateの変数を操作    // アニメーションを設定する.
    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  func lifeTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: ViewController = ViewController()
    mySecondViewController.selectFortune = "life"
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
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
