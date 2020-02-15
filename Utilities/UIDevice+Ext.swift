//
//  UIDevice+Ext.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 15/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit
import AVFoundation

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }

    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
    
    var is4Inch: Bool { UIScreen.main.bounds.width < 350 }
    
}
