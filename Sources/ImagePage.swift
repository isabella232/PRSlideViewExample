//
//  ImagePage.swift
//  PRSlideViewExample
//
//  Created by Elethom Hunter on 7/16/19.
//  Copyright © 2019 Wiredcraft. All rights reserved.
//

import UIKit
import PRSlideView

class ImagePage: PRSlideViewPage {
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .leading, .trailing]
        NSLayoutConstraint.activate(attributes.map{
            return NSLayoutConstraint(item: view,
                                      attribute: $0,
                                      relatedBy: .equal,
                                      toItem: self,
                                      attribute: $0,
                                      multiplier: 1,
                                      constant: 0)
        })
        return view
    }()
    
}
