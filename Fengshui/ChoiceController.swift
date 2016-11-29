//
//  ChoiceController.swift
//  Fengshui
//
//  Created by 渡邊翼 on 2016/11/25.
//  Copyright © 2016年 渡邊翼. All rights reserved.
//

import UIKit

class ChoiceController: UIViewController,UIGestureRecognizerDelegate {
  var titleView: UIImageView!
  var furnitureView: UIImageView!
  var roomView: UIImageView!
  var titleImage = UIImage(named:"FortunDoctor文字.png")
  var furnitureImage = UIImage(named:"家具アイコン.png")
  var roomImage = UIImage(named:"部屋アイコン.png")
  var roomLabel: UILabel!
  var furnitureLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    titleView = UIImageView(frame: CGRect(x: self.view.bounds.width / 2 - 150 , y: self.view.bounds.height * 0.1, width: 300, height: 60))
    // UIImageViewに画像を設定する.
    titleView.image = titleImage
    self.view.addSubview(titleView)
    
    furnitureView = UIImageView(frame: CGRect(x: self.view.bounds.width / 2 - 50 , y: self.view.bounds.height * 0.3, width: 100, height: 100))
    // UIImageViewに画像を設定する.
    furnitureView.image = furnitureImage
    
    furnitureView.userInteractionEnabled = true
    
    let furnitureTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChoiceController.furnitureTapAction(_:)))
    furnitureTap.delegate = self
    furnitureView.addGestureRecognizer(furnitureTap)
    self.view.addSubview(furnitureView)

    
    furnitureLabel = UILabel(frame: CGRectMake(0,0,300,50))
    furnitureLabel.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height * 0.55)
    furnitureLabel.textAlignment = NSTextAlignment.Center
    furnitureLabel.text = "家具から占う"
    furnitureLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
    self.view.addSubview(furnitureLabel)
    
    


    
    roomView = UIImageView(frame: CGRect(x: self.view.bounds.width / 2 - 50 , y: self.view.bounds.height * 0.65, width: 100, height: 100))
    // UIImageViewに画像を設定する.
    roomView.image = roomImage
    
    
    roomView.userInteractionEnabled = true
    
    let roomTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChoiceController.roomTapAction(_:)))
    roomTap.delegate = self
    roomView.addGestureRecognizer(roomTap)
    self.view.addSubview(roomView)
    // 家具占いを表示するラベルを作成する
    roomLabel = UILabel(frame: CGRectMake(0,0,300,50))
    roomLabel.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height * 0.9)
    roomLabel.textAlignment = NSTextAlignment.Center
    roomLabel.text = "部屋から占う"
    roomLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
    self.view.addSubview(roomLabel)
    // Do any additional setup after loading the view.
  }
  
  func furnitureTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: SelectFurnitureController = SelectFurnitureController()
    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  func roomTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: SelectFortuneController = SelectFortuneController()
    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
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
