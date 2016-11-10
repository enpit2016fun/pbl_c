import UIKit

class CircleView: UIView {
  
  var circleLayer: CAShapeLayer!
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clearColor()
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    print(appDelegate.circleColor!)
    let endAngle:CGFloat!
    
    // Use UIBezierPath as an easy way to create the CGPath for the layer.
    // The path should be the entire circle.
    if appDelegate.score! >= 0.25 {
      endAngle = CGFloat(M_PI * 2.0) * (CGFloat(appDelegate.score!) - 0.25)
    } else {
      endAngle = CGFloat(M_PI * 2.0) * (0.75 + CGFloat(appDelegate.score!))
    }
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: CGFloat(M_PI * 2.0) * 0.75, endAngle: endAngle, clockwise: true)
    
    // Setup the CAShapeLayer with the path, colors, and line width
    circleLayer = CAShapeLayer()
    circleLayer.path = circlePath.CGPath
    circleLayer.fillColor = UIColor.clearColor().CGColor
    //circleLayer.strokeColor = UIColor.redColor().CGColor
    circleLayer.strokeColor = appDelegate.circleColor!.CGColor //appDelegateの変数を操作
    circleLayer.lineWidth = 20.0;
    
    // Don't draw the circle initially
    circleLayer.strokeEnd = 0.0
    
    // Add the circleLayer to the view's layer's sublayers
    layer.addSublayer(circleLayer)
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func drawRect(rect: CGRect) {
    // Get the Graphics Context
    var context = UIGraphicsGetCurrentContext();
    
    // Set the circle outerline-width
    CGContextSetLineWidth(context, 0.0);
    
    // Set the circle outerline-colour
    UIColor.redColor().set()
    
    // Create Circle
    CGContextAddArc(context, (frame.size.width)/2, frame.size.height/2, (frame.size.width - 10)/2, 0.0, CGFloat(M_PI * 2.0), 1)
    
    // Draw
    CGContextStrokePath(context);
  }

  
  func animateCircle(duration: NSTimeInterval) {
    // We want to animate the strokeEnd property of the circleLayer
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    
    // Set the animation duration appropriately
    animation.duration = duration
    
    // Animate from 0 (no circle) to 1 (full circle)
    animation.fromValue = 0
    animation.toValue = 1
    //animation.repeatCount = 5
    // Do a linear animation (i.e. the speed of the animation stays the same)
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
    // right value when the animation ends.
    circleLayer.strokeEnd = 1.0
    
    // Do the actual animation
    circleLayer.addAnimation(animation, forKey: "animateCircle")
  }

  
  
  
  }