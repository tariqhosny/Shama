//
//  textFieldPadding.swift
//  Shoping Gate
//
//  Created by Tariq on 11/4/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class textFieldPadding: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
