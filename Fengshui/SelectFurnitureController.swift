//
//  SelectFurnitureController.swift
//  Fengshui
//
//  Created by 渡邊翼 on 2016/11/27.
//  Copyright © 2016年 渡邊翼. All rights reserved.
//

import UIKit

class SelectFurnitureController: UIViewController,UIGestureRecognizerDelegate {
  var titleView: UIImageView!
  var titleImage = UIImage(named:"FortunDoctor文字.png")
  var furnitureImage = UIImage(named:"家具アイコン.png")
  var okView: UIImageView!
  var backView: UIImageView!
  var okImage = UIImage(named:"ok.png")
  var backImage = UIImage(named:"back.png")
  var furnitureView: UIImageView!
  var furnitureLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    // 遷移するViewを定義する.
    let mySecondViewController: ChoiceController = ChoiceController()
    mySecondViewController.view.userInteractionEnabled = false
    titleView = UIImageView(frame: CGRect(x: self.view.bounds.width / 2 - 150 , y: self.view.bounds.height * 0.1, width: 300, height: 60))
    // UIImageViewに画像を設定する.
    titleView.image = titleImage
    self.view.addSubview(titleView)
    
    furnitureView = UIImageView(frame: CGRect(x: self.view.bounds.width / 2 - 50 , y: self.view.bounds.height * 0.35, width: 100, height: 100))
    // UIImageViewに画像を設定する.
    furnitureView.image = furnitureImage
    self.view.addSubview(furnitureView)
    
    furnitureLabel = UILabel(frame: CGRectMake(0,0,300,50))
    furnitureLabel.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height * 0.62)
    furnitureLabel.textAlignment = NSTextAlignment.Center
    furnitureLabel.text = "占いたい家具を撮影してください"
    furnitureLabel.font = UIFont(name:"HiraKakuProN-W6",size:14)
    self.view.addSubview(furnitureLabel)
    
    okView = UIImageView(frame: CGRect(x: self.view.bounds.width * 0.5  , y: self.view.bounds.height * 0.87, width: self.view.bounds.width * 0.45, height: 50))
    // UIImageViewに画像を設定する.
    okView.image = okImage
    okView.userInteractionEnabled = true
    let okTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectFurnitureController.okTapAction(_:)))
    okTap.delegate = self
    okView.addGestureRecognizer(okTap)
    self.view.addSubview(okView)
    backView = UIImageView(frame: CGRect(x: self.view.bounds.width * 0.03 , y: self.view.bounds.height * 0.87, width: self.view.bounds.width * 0.45, height: 50))
    // UIImageViewに画像を設定する.
    backView.image = backImage
    backView.userInteractionEnabled = true
    let backTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectFurnitureController.backTapAction(_:)))
    backTap.delegate = self
    backView.addGestureRecognizer(backTap)
    self.view.addSubview(backView)

    
    // Do any additional setup after loading the view.
  }
  
  func okTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: CaptureFurnitureController = CaptureFurnitureController()
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
