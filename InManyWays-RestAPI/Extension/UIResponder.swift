//
//  UIResponder.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/15.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
