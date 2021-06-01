//
//  ViewMaker.swift
//  Santo
//
//  Created by Eldor Makkambayev on 11/11/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit
class ViewMaker {
    
    static let shared = ViewMaker()
    
    func makeCircleWith(size: CGSize, backgroundColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backgroundColor.cgColor)
        context?.setStrokeColor(UIColor.clear.cgColor)
        let bounds = CGRect(origin: .zero, size: size)
        context?.addEllipse(in: bounds)
        context?.drawPath(using: .fill)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}
