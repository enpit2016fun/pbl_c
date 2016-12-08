//
//  ColorChoiceController.swift
//  Fengshui
//
//  Created by 渡邊翼 on 2016/12/08.
//  Copyright © 2016年 渡邊翼. All rights reserved.
//

import UIKit

class ColorChoiceController: UIViewController,UIGestureRecognizerDelegate {
  var TextLabel: UILabel!
  var OkImageView:UIImageView!
  var BackImageView:UIImageView!
  var OkImage = UIImage(named:"ok.png")
  var BackImage = UIImage(named:"back.png")
  var view1:UIView!
  var view2:UIView!
  var view3:UIView!
  var view4:UIView!
  var view5:UIView!
  var view6:UIView!
  var view7:UIView!
  var view8:UIView!
  var view9:UIView!
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    let mySecondViewController: ChoiceController = ChoiceController()
    mySecondViewController.view.userInteractionEnabled = false
    //self.view.userInteractionEnabled = false
    
    OkImageView = UIImageView(frame: CGRect(x: self.view.bounds.width * 0.02 , y: self.view.bounds.height * 0.87, width: self.view.bounds.width * 0.45, height: 50))
    // UIImageViewに画像を設定する.
    OkImageView.image = OkImage
    OkImageView.userInteractionEnabled = true
    let OkTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ColorChoiceController.okTapAction(_:)))
    OkTap.delegate = self
    OkImageView.addGestureRecognizer(OkTap)
    self.view.addSubview(OkImageView)
    
    BackImageView = UIImageView(frame: CGRect(x: self.view.bounds.width * 0.53 , y: self.view.bounds.height * 0.87, width: self.view.bounds.width * 0.45, height: 50))
    // UIImageViewに画像を設定する.
    BackImageView.image = BackImage
    BackImageView.userInteractionEnabled = true
    let  BackTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ColorChoiceController.backTapAction(_:)))
    BackTap.delegate = self
    BackImageView.addGestureRecognizer(BackTap)
    self.view.addSubview(BackImageView)
    
    // 方角を表示するラベルを作成する
    TextLabel = UILabel(frame: CGRectMake(0,0,300,50))
    TextLabel.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height * 0.1)
    TextLabel.textAlignment = NSTextAlignment.Center
    TextLabel.text = "近い色を選択してください。"
    TextLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
    self.view.addSubview(TextLabel)
    
    let text1:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
    text1.layer.position = CGPoint(x: self.view.bounds.width * 0.25 , y:self.view.bounds.height * 0.38)
    text1.textAlignment = NSTextAlignment.Center
    text1.textColor = UIColor.lightGrayColor()
    text1.text = "白"
    text1.font = UIFont(name:"HiraKakuProN-W6",size:10)
    self.view.addSubview(text1)
    
    view1 = UIView(frame:CGRectMake(0, 0, 50, 50))
    view1.center = CGPoint(x:self.view.bounds.width * 0.25,y:self.view.bounds.height * 0.3)
    view1.backgroundColor = UIColor.whiteColor()
    view1.layer.borderColor = UIColor.lightGrayColor().CGColor
    view1.layer.borderWidth = 1
    view1.userInteractionEnabled = true
    
    let  viewTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ColorChoiceController.view1TapAction(_:)))
    viewTap.delegate = self
    view1.addGestureRecognizer(viewTap)
    
    self.view.addSubview(view1)
    
    
    view2 = UIView(frame:CGRectMake(0, 0, 50, 50))
    view2.center = CGPoint(x:self.view.bounds.width * 0.5,y:self.view.bounds.height * 0.3)
    view2.backgroundColor = UIColor.magentaColor()
    view2.layer.borderColor = UIColor.lightGrayColor().CGColor
    view2.layer.borderWidth = 1
    self.view.addSubview(view2)
    
    let text2:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
    text2.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.38)
    text2.textAlignment = NSTextAlignment.Center
    text2.textColor = UIColor.lightGrayColor()
    text2.text = "ピンク"
    text2.font = UIFont(name:"HiraKakuProN-W6",size:10)
    self.view.addSubview(text2)
    
    view3 = UIView(frame:CGRectMake(0, 0, 50, 50))
    view3.center = CGPoint(x:self.view.bounds.width * 0.75,y:self.view.bounds.height * 0.3)
    view3.backgroundColor = UIColor(red: 124.0/255, green: 96.0/255, blue: 53.0/255, alpha: 1.0)
    view3.layer.borderColor = UIColor.lightGrayColor().CGColor
    view3.layer.borderWidth = 1
    self.view.addSubview(view3)
    
    let text3:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
    text3.layer.position = CGPoint(x: self.view.bounds.width * 0.75 , y:self.view.bounds.height * 0.38)
    text3.textAlignment = NSTextAlignment.Center
    text3.textColor = UIColor.lightGrayColor()
    text3.text = "茶"
    text3.font = UIFont(name:"HiraKakuProN-W6",size:10)
    self.view.addSubview(text3)
    
    view4 = UIView(frame:CGRectMake(0, 0, 50, 50))
    view4.center = CGPoint(x:self.view.bounds.width * 0.25,y:self.view.bounds.height * 0.5)
    view4.backgroundColor = UIColor.redColor()
    view4.layer.borderColor = UIColor.lightGrayColor().CGColor
    view4.layer.borderWidth = 1
    self.view.addSubview(view4)
    
    let text4:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
    text4.layer.position = CGPoint(x: self.view.bounds.width * 0.25 , y:self.view.bounds.height * 0.58)
    text4.textAlignment = NSTextAlignment.Center
    text4.textColor = UIColor.lightGrayColor()
    text4.text = "赤"
    text4.font = UIFont(name:"HiraKakuProN-W6",size:10)
    self.view.addSubview(text4)
    
    view5 = UIView(frame:CGRectMake(0, 0, 50, 50))
    view5.center = CGPoint(x:self.view.bounds.width * 0.5,y:self.view.bounds.height * 0.5)
    view5.backgroundColor = UIColor.blueColor()
    view5.layer.borderColor = UIColor.lightGrayColor().CGColor
    view5.layer.borderWidth = 1
    self.view.addSubview(view5)
    
    let text5:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
    text5.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.58)
    text5.textAlignment = NSTextAlignment.Center
    text5.textColor = UIColor.lightGrayColor()
    text5.text = "青"
    text5.font = UIFont(name:"HiraKakuProN-W6",size:10)
    self.view.addSubview(text5)
    
    view6 = UIView(frame:CGRectMake(0, 0, 50, 50))
    view6.center = CGPoint(x:self.view.bounds.width * 0.75,y:self.view.bounds.height * 0.5)
    view6.backgroundColor = UIColor(red: 142.0/255, green: 0.0, blue: 204.0/255, alpha: 1.0)
    view6.layer.borderColor = UIColor.lightGrayColor().CGColor
    view6.layer.borderWidth = 1
    self.view.addSubview(view6)
    
    let text6:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
    text6.layer.position = CGPoint(x: self.view.bounds.width * 0.75 , y:self.view.bounds.height * 0.58)
    text6.textAlignment = NSTextAlignment.Center
    text6.textColor = UIColor.lightGrayColor()
    text6.text = "紫"
    text6.font = UIFont(name:"HiraKakuProN-W6",size:10)
    self.view.addSubview(text6)
    
    view7 = UIView(frame:CGRectMake(0, 0, 50, 50))
    view7.center = CGPoint(x:self.view.bounds.width * 0.25,y:self.view.bounds.height * 0.7)
    view7.backgroundColor = UIColor.greenColor()
    view7.layer.borderColor = UIColor.lightGrayColor().CGColor
    view7.layer.borderWidth = 1
    self.view.addSubview(view7)
    
    let text7:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
    text7.layer.position = CGPoint(x: self.view.bounds.width * 0.25 , y:self.view.bounds.height * 0.78)
    text7.textAlignment = NSTextAlignment.Center
    text7.textColor = UIColor.lightGrayColor()
    text7.text = "緑"
    text7.font = UIFont(name:"HiraKakuProN-W6",size:10)
    self.view.addSubview(text7)
    
    view8 = UIView(frame:CGRectMake(0, 0, 50, 50))
    view8.center = CGPoint(x:self.view.bounds.width * 0.5,y:self.view.bounds.height * 0.7)
    view8.backgroundColor = UIColor(red: 171.0/255, green: 255.0/255, blue: 127.0/255, alpha: 1.0)
    view8.layer.borderColor = UIColor.lightGrayColor().CGColor
    view8.layer.borderWidth = 1
    self.view.addSubview(view8)
    
    let text8:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
    text8.layer.position = CGPoint(x: self.view.bounds.width * 0.5 , y:self.view.bounds.height * 0.78)
    text8.textAlignment = NSTextAlignment.Center
    text8.textColor = UIColor.lightGrayColor()
    text8.text = "黄緑"
    text8.font = UIFont(name:"HiraKakuProN-W6",size:10)
    self.view.addSubview(text8)
    
    view9 = UIView(frame:CGRectMake(0, 0, 50, 50))
    view9.center = CGPoint(x:self.view.bounds.width * 0.75,y:self.view.bounds.height * 0.7)
    view9.layer.borderColor = UIColor.lightGrayColor().CGColor
    view9.layer.borderWidth = 1
    view9.backgroundColor = UIColor.yellowColor()
    self.view.addSubview(view9)
    
    let text9:UILabel = UILabel(frame: CGRectMake(0,0,50,20))
    text9.layer.position = CGPoint(x: self.view.bounds.width * 0.75 , y:self.view.bounds.height * 0.78)
    text9.textAlignment = NSTextAlignment.Center
    text9.textColor = UIColor.lightGrayColor()
    text9.text = "黄"
    text9.font = UIFont(name:"HiraKakuProN-W6",size:10)
    self.view.addSubview(text9)
    
    
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func okTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: ResultColorController = ResultColorController()
    //mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  func backTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: ChoiceController = ChoiceController()
    //mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  func view1TapAction(sender: UITapGestureRecognizer){
    self.view1.layer.borderColor = UIColor.orangeColor().CGColor
    self.view.addSubview(view1)
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    appDelegate.selectedColor = "白"
    
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
