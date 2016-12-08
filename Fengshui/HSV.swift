//
//  HSV.swift
//  Fengshui
//
//  Created by 渡邊翼 on 2016/12/08.
//  Copyright © 2016年 渡邊翼. All rights reserved.
//

import UIKit

class HSV {
  //色相
  var hue: Double = 0
  //彩度
  var saturation: Double = 0
  //明度
  var value: Double = 0
  
  init(hue: Double, saturation: Double, value: Double) {
    self.hue = hue
    self.saturation = saturation
    self.value = value
  }
}