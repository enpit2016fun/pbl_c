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
  var loveImage = UIImage(named:"恋愛運.png")
  var jobImage = UIImage(named:"仕事運.png")
  var lifeImage = UIImage(named:"人生運.png")
    override func viewDidLoad() {
        super.viewDidLoad()
      loveView = UIImageView(frame: CGRect(x: self.view.bounds.width/6 - 50  , y: self.view.bounds.height - 150, width: 100, height: 100))
      // UIImageViewに画像を設定する.
      loveView.image = loveImage
      
      loveView.userInteractionEnabled = true
      
      let loveTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectFortuneController.loveTapAction(_:)))
      loveTap.delegate = self
      
      loveView.addGestureRecognizer(loveTap)
      // Viewに張りつけ.
      self.view.addSubview(loveView)
      
      jobView = UIImageView(frame: CGRect(x: self.view.bounds.width * 0.5 - 50 , y: self.view.bounds.height - 150, width: 100, height: 100))
      // UIImageViewに画像を設定する.
      jobView.image = jobImage
      
      jobView.userInteractionEnabled = true
      
      let jobTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectFortuneController.loveTapAction(_:)))
      jobTap.delegate = self
      
      jobView.addGestureRecognizer(jobTap)
      // Viewに張りつけ.
      self.view.addSubview(jobView)
      
      lifeView = UIImageView(frame: CGRect(x: self.view.bounds.width - 105, y: self.view.bounds.height - 150, width: 100, height: 100))
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
    // アニメーションを設定する.
    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  func jobTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: ViewController = ViewController()
    mySecondViewController.selectFortune = "job"
    // アニメーションを設定する.
    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  func lifeTapAction(sender: UITapGestureRecognizer){
    // 遷移するViewを定義する.
    let mySecondViewController: ViewController = ViewController()
    mySecondViewController.selectFortune = "life"
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
