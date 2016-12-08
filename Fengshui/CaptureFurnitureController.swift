import UIKit
import AVFoundation
import CoreLocation
class CaptureFurnitureController: UIViewController, UIGestureRecognizerDelegate,CLLocationManagerDelegate {
  var locationLabel: UILabel!
  var textLabel: UILabel!
  var text2Label: UILabel!
  var fortuneView:UIImageView!
  var statusView:UIView!
  var loveImage = UIImage(named:"恋愛_180pt.png")
  var jobImage = UIImage(named:"仕事_180pt.png")
  var lifeImage = UIImage(named:"人生運.png")
  var familyImage = UIImage(named:"家族_180pt.png")
  var moneyImage = UIImage(named:"金運_180pt.png")
  var healthImage = UIImage(named:"健康_180pt.png")
  var depositImage = UIImage(named:"貯金_180pt.png")
  var beautyImage = UIImage(named:"美容_180pt.png")
  
  // AVキャプチャセッション
  
  var avSession: AVCaptureSession!
  
  // AVキャプチャデバイス
  var avDevice: AVCaptureDevice!
  
  // AVキャプチャデバイスインプット
  var avInput: AVCaptureInput!
  
  // AVキャプチャアウトプット
  var avOutput: AVCaptureStillImageOutput!
  
  var cameraView: UIImageView!
  var cameraImage = UIImage(named:"camera.png")
  var lm: CLLocationManager! = nil
  override func viewDidLoad() {
    super.viewDidLoad()
    lm = CLLocationManager()
    // 位置情報を取るよう設定
    // ※ 初回は確認ダイアログ表示
    lm.requestAlwaysAuthorization()
    lm.delegate = self
    lm.distanceFilter = 1.0 // 1m毎にGPS情報取得
    lm.desiredAccuracy = kCLLocationAccuracyBest // 最高精度でGPS取得
    lm.startUpdatingLocation() // 位置情報更新機能起動
    lm.startUpdatingHeading() // コンパス更新機能起動
    
    // 画面タップで撮影
    //    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CaptureController.takePhoto(_:)))
    //    tapGesture.delegate = self;
    //    self.view.addGestureRecognizer(tapGesture)
    
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.initCamera()
  }
  
  func initCamera() {
    
    // AVキャプチャセッション
    // (AVFoundationにおけるキャプチャ入出力を管理するクラス)
    avSession = AVCaptureSession()
    
    if (avSession.canSetSessionPreset(AVCaptureSessionPresetPhoto)) {
      avSession.beginConfiguration()
      
      // キャプチャクオリティ設定
      // AVCaptureSessionPresetPhoto    写真専用、デバイスの最大解像度
      // AVCaptureSessionPresetHigh     最高録画品質 (静止画でも一番高画質なのはコレ)
      // AVCaptureSessionPresetMedium   WiFi向け
      // AVCaptureSessionPresetLow      3G向け
      // AVCaptureSessionPreset640x480  640x480 VGA固定
      // AVCaptureSessionPreset1280x720 1280x720 HD固定
      avSession.sessionPreset = AVCaptureSessionPresetPhoto
      
      avSession.commitConfiguration()
    }
    
    // AVキャプチャデバイス
    // (前背面カメラやマイク等のデバイス)
    let devices = AVCaptureDevice.devices()
    for capDevice in devices {
      if (capDevice.position == AVCaptureDevicePosition.Back) {
        // 背面カメラを取得
        avDevice = capDevice as? AVCaptureDevice
      }
    }
    
    if (avDevice != nil) {
      
      // AVキャプチャデバイスインプット
      // (AVキャプチャデバイスからの入力)
      do {
        // バックカメラからVideoInputを取得
        avInput = try AVCaptureDeviceInput.init(device: avDevice!)
      } catch let error as NSError {
        print(error)
      }
      
      // AVキャプチャデバイスインプットをセッションに追加
      if (avSession.canAddInput(avInput)) {
        
        avSession.addInput(avInput)
        
        // AVキャプチャアウトプット (出力方法)
        // AVCaptureStillImageOutput: 静止画
        // AVCaptureMovieFileOutput: 動画ファイル
        // AVCaptureAudioFileOutput: 音声ファイル
        // AVCaptureVideoDataOutput: 動画フレームデータ
        // AVCaptureAudioDataOutput: 音声データ
        
        avOutput = AVCaptureStillImageOutput()
        
        // 出力設定
        avOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        
        // AVキャプチャアウトプットをセッションに追加
        if (avSession.canAddOutput(avOutput)) {
          avSession.addOutput(avOutput)
        }
        
        // 画像を表示するレイヤーを生成.
        let capVideoLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.init(session:avSession)
        capVideoLayer.frame = self.view.bounds
        capVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        // AVLayerVideoGravityResizeAspectFill
        //      アスペクト比維持 + 必要に応じてトリミング (縦いっぱいに表示し横をトリミング)
        
        // AVLayerVideoGravityResizeAspect
        //      アスペクト比維持 (縦横とも収まる様に表示)
        
        // AVLayerVideoGravityResize
        //      利用可能な画面領域いっぱいにリサイズ
        
        
        // Viewに追加.
        self.view.layer.addSublayer(capVideoLayer)
        
        // セッション開始.
        avSession.startRunning()
        
        renderView()
        
      }
      
    } else {
      
      // UIAlertControllerを作成する.
      let sampleAlert: UIAlertController = UIAlertController(title: "", message: "背面カメラがある実機で動かしてね。", preferredStyle: .Alert)
      
      // アクションを作成、追加
      let yesAction = UIAlertAction(title: "OK", style: .Default) {
        UIAlertAction in
        self.close()
      }
      sampleAlert.addAction(yesAction)
      
      // UIAlertを表示する
      self.presentViewController(sampleAlert, animated: true, completion: nil)
    }
  }
  
  // 画面を閉じる
  func close() {
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  // 緯度・経度を受信
  func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation){
    //locationLabel.text = String(format:"%f , %f",newLocation.coordinate.latitude,newLocation.coordinate.longitude)
  }
  
  // コンパスの値を受信
  func locationManager(manager:CLLocationManager, didUpdateHeading newHeading:CLHeading) {
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    
    // radianで回転角度を指定(30度)する.
    
    // 回転用のアフィン行列を生成する.
    //myRotateView.transform = CGAffineTransformMakeRotation(angle)
    //コンパスの値に応じて方角を表示
  
    if newHeading.magneticHeading >= 0 && newHeading.magneticHeading < 45 {
      locationLabel.text = "北"
      self.fortuneView.image = depositImage
      self.textLabel.text = "貯金運"
      appDelegate.selectedFortune = "deposit"
      statusView.backgroundColor = UIColor.magentaColor()
    } else if newHeading.magneticHeading >= 45 && newHeading.magneticHeading < 90  {
      locationLabel.text = "北西"
      self.fortuneView.image = lifeImage
      self.textLabel.text = "人生運"
      appDelegate.selectedFortune = "life"
      statusView.backgroundColor = UIColor(red: 255 / 255, green:215  / 255, blue: 0 / 255, alpha: 1.0)
    } else if newHeading.magneticHeading >= 90 && newHeading.magneticHeading < 135  {
      locationLabel.text = "西"
      self.fortuneView.image = moneyImage
      self.textLabel.text = "金運"
      appDelegate.selectedFortune = "money"
      statusView.backgroundColor = UIColor.yellowColor()
    } else if newHeading.magneticHeading >= 135 && newHeading.magneticHeading < 180 {
      locationLabel.text = "南西"
      self.fortuneView.image = familyImage
      self.textLabel.text = "家族運"
      appDelegate.selectedFortune = "family"
      statusView.backgroundColor = UIColor(red: 109 / 255, green:76  / 255, blue: 51 / 255, alpha: 1.0)
    } else if newHeading.magneticHeading >= 180 && newHeading.magneticHeading < 225  {
      
      locationLabel.text = "南"
      self.fortuneView.image = beautyImage
      self.textLabel.text = "美容運"
      appDelegate.selectedFortune = "beauty"
      statusView.backgroundColor = UIColor.greenColor()
    } else if newHeading.magneticHeading >= 225 && newHeading.magneticHeading < 270  {
      
      locationLabel.text = "南東"
      self.fortuneView.image = loveImage
      self.textLabel.text = "恋愛運"
      appDelegate.selectedFortune = "love"
      statusView.backgroundColor = UIColor.magentaColor()
    } else if newHeading.magneticHeading >= 270 && newHeading.magneticHeading < 315  {
      
      locationLabel.text = "東"
      self.fortuneView.image = jobImage
      self.textLabel.text = "仕事運"
      appDelegate.selectedFortune = "job"
      statusView.backgroundColor = UIColor.redColor()
    } else {
      locationLabel.text = "北東"
      self.fortuneView.image = healthImage
      self.textLabel.text = "健康運"
      appDelegate.selectedFortune = "health"
      statusView.backgroundColor = UIColor.whiteColor()
    }
    
    //方角を角度で表示
    //headingLabel.text = String(format:"%f deg",newHeading.magneticHeading)
  }
  
  
  // 画面になにか重ねて表示する
  func renderView() {
    statusView = UIView(frame:CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height * 0.2))
    statusView.center = CGPoint(x:self.view.bounds.width * 0.5,y:self.view.bounds.height * 0.1)
    statusView.layer.borderColor = UIColor.lightGrayColor().CGColor
    statusView.layer.borderWidth = 1
    statusView.backgroundColor = UIColor.whiteColor()
    self.view.addSubview(statusView)
    cameraView = UIImageView(frame: CGRect(x: self.view.bounds.width * 0.5 - 30  , y: self.view.bounds.height * 0.80, width: 60, height: 60))
    // UIImageViewに画像を設定する.
    cameraView.image = cameraImage
    cameraView.userInteractionEnabled = true
    let cameraTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CaptureController.takePhoto(_:)))
    cameraTap.delegate = self
    cameraView.addGestureRecognizer(cameraTap)
    self.view.addSubview(cameraView)
    
    fortuneView = UIImageView(frame: CGRect(x: self.view.bounds.width * 0.5 - 30 , y: self.view.bounds.height * 0.05, width: 60, height: 60))
    // UIImageViewに画像を設定する.
    self.statusView.addSubview(fortuneView)
    
    
    
    
    locationLabel = UILabel(frame: CGRectMake(0,0,60,60))
    locationLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.2 , y:self.view.bounds.height * 0.13)
    locationLabel.textAlignment = NSTextAlignment.Center
    locationLabel.text = ""
    locationLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
    self.statusView.addSubview(locationLabel)
    
    textLabel = UILabel(frame: CGRectMake(0,0,80,60))
    textLabel.layer.position = CGPoint(x: self.view.bounds.width * 0.8 , y:self.view.bounds.height * 0.1)
    textLabel.textAlignment = NSTextAlignment.Center
    textLabel.text = ""
    textLabel.textColor = UIColor.lightGrayColor()
    textLabel.font = UIFont(name:"HiraKakuProN-W6",size:20)
    self.statusView.addSubview(textLabel)
    
    text2Label = UILabel(frame: CGRectMake(0,0,120,60))
    text2Label.layer.position = CGPoint(x: self.view.bounds.width * 0.8 , y:self.view.bounds.height * 0.15)
    text2Label.textAlignment = NSTextAlignment.Center
    text2Label.textColor = UIColor.lightGrayColor()
    text2Label.text = "が上がります"
    text2Label.font = UIFont(name:"HiraKakuProN-W6",size:14)
    self.statusView.addSubview(text2Label)

  }
  
  
  // 撮影をする
  func takePhoto(sender: UITapGestureRecognizer){
    
    // ビデオ出力に接続する
    let videoConnection = avOutput.connectionWithMediaType(AVMediaTypeVideo)
    
    // 接続から画像を取得する
    self.avOutput.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: { (imageDataBuffer, error) -> Void in
      
      // Jpegに変換する (NSDataにはExifなどのメタデータも含まれている)
      let imageData: NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer)
      
      // UIIMageを作成する
      let image: UIImage = UIImage(data: imageData)!
      
      // アルバムに追加する
      UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
      
      // 遷移するViewを定義する.
      let mySecondViewController: ImageAnalysisController = ImageAnalysisController()
      // アニメーションを設定する.
      //mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
      // 撮影した画像を解析画面に受け渡し
      //mySecondViewController.takenImage_accessor  = image
      mySecondViewController.takenImage = image
      // Viewの移動する.
      self.presentViewController(mySecondViewController, animated: true, completion: nil)
      
      
      self.close()
    })
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    
    // カメラの停止とメモリ解放
    self.avSession.stopRunning()
    
    for output in self.avSession.outputs {
      self.avSession.removeOutput(output as? AVCaptureOutput)
    }
    
    for input in self.avSession.inputs {
      self.avSession.removeInput(input as? AVCaptureInput)
    }
    
    self.avOutput = nil
    self.avInput = nil
    self.avDevice = nil
    self.avSession = nil
  }
  
}