//
//  UIView+nib.swift
//  FriTest
//
//  Created by Ali Gutierrez on 10/11/22.
//

import UIKit

extension UIView {
    static var nib: UINib {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)
        return nib
    }
    
    @discardableResult
    func loadFromNib<T: UIView>() -> T? {
        let nibName = "\(type(of: self))"
        let bundle = Bundle(for: type(of: self))
        guard let contentView = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? T else { return nil }
        
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return contentView
    }
}

extension UIView {
    static var identifier: String {
        return "\(self)"
    }
}
