import UIKit


extension NSMutableData {
  func appendString(string: String) {
    let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
    appendData(data!)
  }
}

class UploadController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  //UIImagePickerControllerDelegate, UINavigationControllerDelegateを忘れずに
  //画像のアップロード処理
  func myImageUploadRequest(){
    //myUrlには自分で用意したphpファイルのアドレスを入れる
    let myUrl = NSURL(string:"http://example.com/upload.php")
    let request = NSMutableURLRequest(URL:myUrl!)
    request.HTTPMethod = "POST"
    //下記のパラメータはあくまでもPOSTの例
    let param = [
      "userId" : "12345"
    ]
    let boundary = generateBoundaryString()
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    let imageData = UIImageJPEGRepresentation(self.imageForUpload.image, 1)
    if(imageData==nil) { return; }
    request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData, boundary: boundary)
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
      data, response, error in
      if error != nil {
        print("error=\(error)")
        return
      }
      // レスポンスを出力
      print("******* response = \(response)")
      let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
      print("****** response data = \(responseString!)")
      dispatch_async(dispatch_get_main_queue(),{
        //アップロード完了
      });
    }
    task.resume()
    
  }
  
  func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
    var body = NSMutableData()
    if parameters != nil {
      for (key, value) in parameters! {
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
        body.appendString("\(value)\r\n")
      }
    }
    let filename = "user-profile.jpg"
    let mimetype = "image/jpg"
    body.appendString("--\(boundary)\r\n")
    body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
    body.appendString("Content-Type: \(mimetype)\r\n\r\n")
    body.appendData(imageDataKey)
    body.appendString("\r\n")
    body.appendString("--\(boundary)--\r\n")
    return body
  }
  
  func generateBoundaryString() -> String {
    return "Boundary-\(NSUUID().UUIDString)"
  }
  
  //カメラで写真を取る
  func pickImageFromCamera() {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
      let controller = UIImagePickerController()
      controller.delegate = self
      controller.sourceType = UIImagePickerControllerSourceType.Camera
      self.presentViewController(controller, animated: true, completion: nil)
    }
  }
  
  //写真をライブラリから選択
  func pickImageFromLibrary() {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
      let controller = UIImagePickerController()
      controller.delegate = self
      controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
      self.presentViewController(controller, animated: true, completion: nil)
    }
  }
  
  //画像が選択されたら呼び出される
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    if info[UIImagePickerControllerOriginalImage] != nil {
      let image = info[UIImagePickerControllerOriginalImage] as! UIImage
      //iamgeForUploadというUIImageを用意しておいてそこに一旦預ける
      self.imageForUpload.image = image
      self.myImageUploadRequest()
    }
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
}