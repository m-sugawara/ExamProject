//
//  UIFont+Extensions.swift
//  ExamProject
//
//  Created by M_Sugawara on 2017/06/24.
//  Copyright © 2017年 Sugawar. All rights reserved.
//

import UIKit

enum AppleSDGothicNeoType {
    case thin
    case semiBold
    case medium
    case regular
    case bold
    case light
}

extension UIFont {
    static func appleSDGothicNeo(type: AppleSDGothicNeoType, size: CGFloat) -> UIFont? {
        switch type {
        case .thin:
            return UIFont(name: "AppleSDGothicNeo-Thin", size: size)
        case .semiBold:
            return UIFont(name: "AppleSDGothicNeo-SemiBold", size: size)
        case .medium:
            return UIFont(name: "AppleSDGothicNeo-Medium", size: size)
        case .regular:
            return UIFont(name: "AppleSDGothicNeo-Regular", size: size)
        case .bold:
            return UIFont(name: "AppleSDGothicNeo-Bold", size: size)
        case .light:
            return UIFont(name: "AppleSDGothicNeo-Light", size: size)
        }
    }
}
