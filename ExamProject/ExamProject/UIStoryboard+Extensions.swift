//
//  UIStoryboard+Extensions.swift
//  ExamProject
//
//  Created by M_Sugawara on 2017/06/24.
//  Copyright © 2017年 Sugawar. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

extension UIStoryboard {
    var top: TopViewController {
        guard let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "Top") as? TopViewController else {
            fatalError("TopViewController couldn't be found!")
        }
        return vc
    }
}
