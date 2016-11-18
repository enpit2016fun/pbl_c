import UIKit
import CoreLocation

class ViewController: UIViewController ,CLLocationManagerDelegate {
  var locationLabel: UILabel!
  var teachLabel: UILabel!
  var lm: CLLocationManager! = nil
  var myImage = UIImage(named:"方角.png")
  var myRotateView:UIImageView! = nil
  var selectFortune:String?
  let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
  var fortuneArray:[Fortune] = []
  var selectedDirection:String?
  var nextButton:UIButton?

  override func viewDidLoad() {
    super.viewDidLoad()
    fortuneArray = appDelegate.farray
    self.view.backgroundColor = UIColor.whiteColor()
    myRotateView = UIImageView(frame: CGRect(x: self.view.bounds.width/2 - 100 , y: self.view.bounds.height/6, width: 200, height: 200))
    // UIImageViewに画像を設定する.
    myRotateView.image = myImage
    // Viewに張りつけ.
    self.view.addSubview(myRotateView)
    // 方角を表示するラベルを作成する
    locationLabel = UILabel(frame: CGRectMake(0,0,300,50))
    locationLabel.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height * 0.7)
    locationLabel.textAlignment = NSTextAlignment.Center
    locationLabel.font = UIFont(name:"HiraKakuProN-W6",size:25)
    self.view.addSubview(locationLabel)
    // 方角指定を表示するラベルを作成する
    teachLabel = UILabel(frame: CGRectMake(0,0,300,50))
    teachLabel.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height * 0.1)
    teachLabel.textAlignment = NSTextAlignment.Center
    teachLabel.font = UIFont(name:"HiraKakuProN-W6",size:25)
    for farr in fortuneArray {
      print(farr.name!)
      if (farr.name! == selectFortune!){
        selectedDirection = farr.direction!
        teachLabel.text = "\(farr.direction!)に合わせてください"
      }
    }
    
    self.view.addSubview(teachLabel)
    // ボタンを生成する.
    nextButton = UIButton(frame: CGRectMake(0,0,self.view.bounds.width * 0.8,50))
    nextButton!.backgroundColor = UIColor.orangeColor();
    nextButton!.layer.masksToBounds = true
    nextButton!.setTitle("OK", forState: .Normal)
    nextButton!.layer.cornerRadius = 10.0
    nextButton!.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-50)
    nextButton!.addTarget(self, action: #selector(onClickMyButton(_:)), forControlEvents: .TouchUpInside)
    // ボタンを追加する.
    self.view.addSubview(nextButton!)
    
    lm = CLLocationManager()
    // 位置情報を取るよう設定
    // ※ 初回は確認ダイアログ表示
    lm.requestAlwaysAuthorization()
    lm.delegate = self
    lm.distanceFilter = 1.0 // 1m毎にGPS情報取得
    lm.desiredAccuracy = kCLLocationAccuracyBest // 最高精度でGPS取得
    lm.startUpdatingLocation() // 位置情報更新機能起動
    lm.startUpdatingHeading() // コンパス更新機能起動
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //
  // --- CLLocationManagerDelegate ---
  //
 
  /*
   ボタンイベント.
   */
  func onClickMyButton(sender: UIButton){
    // 遷移するViewを定義する.
    let mySecondViewController: CaptureController = CaptureController()
    // アニメーションを設定する.
    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
    // Viewの移動する.
    self.presentViewController(mySecondViewController, animated: true, completion: nil)
  }
  
  // 緯度・経度を受信
  func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation){
    //locationLabel.text = String(format:"%f , %f",newLocation.coordinate.latitude,newLocation.coordinate.longitude)
  }
  
  // コンパスの値を受信
  func locationManager(manager:CLLocationManager, didUpdateHeading newHeading:CLHeading) {
    // radianで回転角度を指定(30度)する.
    let angle:CGFloat = CGFloat(newHeading.magneticHeading * M_PI/180.0)
    
    // 回転用のアフィン行列を生成する.
    myRotateView.transform = CGAffineTransformMakeRotation(angle)
    //コンパスの値に応じて方角を表示
    if newHeading.magneticHeading >= 0 && newHeading.magneticHeading < 45 {
      if (selectedDirection == locationLabel.text){
        locationLabel.textColor = UIColor.redColor()
        self.nextButton!.enabled = true
        self.nextButton!.alpha = 1.0
      }else{
        locationLabel.textColor = UIColor.blackColor()
        self.nextButton!.enabled = false
        self.nextButton!.alpha = 0.3
      }
      locationLabel.text = "北"
    } else if newHeading.magneticHeading >= 45 && newHeading.magneticHeading < 90  {
      if (selectedDirection == locationLabel.text){
        locationLabel.textColor = UIColor.redColor()
        self.nextButton!.enabled = true
        self.nextButton!.alpha = 1.0
      }else{
        locationLabel.textColor = UIColor.blackColor()
        self.nextButton!.enabled = false
        self.nextButton!.alpha = 0.3
      }
      locationLabel.text = "北西"
    } else if newHeading.magneticHeading >= 90 && newHeading.magneticHeading < 135  {
      if (selectedDirection == locationLabel.text){
        locationLabel.textColor = UIColor.redColor()
        self.nextButton!.enabled = true
        self.nextButton!.alpha = 1.0
      }else{
        locationLabel.textColor = UIColor.blackColor()
        self.nextButton!.enabled = false
        self.nextButton!.alpha = 0.3
      }
      locationLabel.text = "西"
    } else if newHeading.magneticHeading >= 135 && newHeading.magneticHeading < 180 {
      if (selectedDirection == locationLabel.text){
        locationLabel.textColor = UIColor.redColor()
        self.nextButton!.enabled = true
        self.nextButton!.alpha = 1.0
      }else{
        locationLabel.textColor = UIColor.blackColor()
        self.nextButton!.enabled = false
        self.nextButton!.alpha = 0.3
      }
      locationLabel.text = "南西"
    } else if newHeading.magneticHeading >= 180 && newHeading.magneticHeading < 225  {
      if (selectedDirection == locationLabel.text){
        locationLabel.textColor = UIColor.redColor()
        self.nextButton!.enabled = true
        self.nextButton!.alpha = 1.0
      }else{
        locationLabel.textColor = UIColor.blackColor()
        self.nextButton!.enabled = false
        self.nextButton!.alpha = 0.3
      }
      locationLabel.text = "南"
    } else if newHeading.magneticHeading >= 225 && newHeading.magneticHeading < 270  {
      if (selectedDirection == locationLabel.text){
        locationLabel.textColor = UIColor.redColor()
        self.nextButton!.enabled = true
        self.nextButton!.alpha = 1.0
      }else{
        locationLabel.textColor = UIColor.blackColor()
        self.nextButton!.enabled = false
        self.nextButton!.alpha = 0.3
      }
      locationLabel.text = "南東"
    } else if newHeading.magneticHeading >= 270 && newHeading.magneticHeading < 315  {
      if (selectedDirection == locationLabel.text){
        locationLabel.textColor = UIColor.redColor()
        self.nextButton!.enabled = true
        self.nextButton!.alpha = 1.0
      }else{
        locationLabel.textColor = UIColor.blackColor()
        self.nextButton!.enabled = false
        self.nextButton!.alpha = 0.3
      }
      locationLabel.text = "東"
    } else {
      if (selectedDirection == locationLabel.text){
        locationLabel.textColor = UIColor.redColor()
        self.nextButton!.enabled = true
        self.nextButton!.alpha = 1.0
      }else{
        locationLabel.textColor = UIColor.blackColor()
        self.nextButton!.enabled = false
        self.nextButton!.alpha = 0.3
      }
      locationLabel.text = "北東"
    }
  
    //方角を角度で表示
    //headingLabel.text = String(format:"%f deg",newHeading.magneticHeading)
  }
}