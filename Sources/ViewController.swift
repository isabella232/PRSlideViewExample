//
//  ViewController.swift
//  PRSlideViewExample
//
//  Created by Elethom Hunter on 7/15/19.
//  Copyright © 2019 Wiredcraft. All rights reserved.
//

import UIKit
import PRSlideView

class ViewController: UIViewController {
    
    private let imageData = stride(from: 0, to: 9, by: 1).map{ "\($0)" }
    
    private lazy var slideView: PRSlideView = {
        let view = PRSlideView(direction: .horizontal, infiniteScrolling: true)
        view.dataSource = self
        view.delegate = self
        view.pageControl.pageIndicatorTintColor = .lightGray
        view.pageControl.currentPageIndicatorTintColor = .darkGray
        view.register(ImagePage.self,
                      forPageReuseIdentifier: String(describing: type(of: ImagePage.self)))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func configure() {
        self.title = "Wiredcraft"
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            view.addSubview(slideView)
            let attributes: [NSLayoutConstraint.Attribute] = [.leading, .trailing]
            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: slideView,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: topLayoutGuide,
                                   attribute: .bottom,
                                   multiplier: 1,
                                   constant: 0),
                NSLayoutConstraint(item: slideView,
                                   attribute: .bottom,
                                   relatedBy: .equal,
                                   toItem: bottomLayoutGuide,
                                   attribute: .top,
                                   multiplier: 1,
                                   constant: 0)
                ] + attributes.map {
                    return NSLayoutConstraint(item: slideView,
                                              attribute: $0,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: $0,
                                              multiplier: 1,
                                              constant: 0)
                })
        }
        
        do {
            slideView.insertSubview(titleLabel,
                                    belowSubview: slideView.pageControl)
            let attributes: [NSLayoutConstraint.Attribute] = [.top, .leading, .trailing]
            NSLayoutConstraint.activate(attributes.map {
                return NSLayoutConstraint(item: titleLabel,
                                          attribute: $0,
                                          relatedBy: .equal,
                                          toItem: slideView,
                                          attribute: $0,
                                          multiplier: 1,
                                          constant: 0)
                } + [
                    NSLayoutConstraint(item: titleLabel,
                                       attribute: .height,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .notAnAttribute,
                                       multiplier: 1,
                                       constant: 44)
                ])
        }
        slideView.reloadData()
    }
    
}

extension ViewController: PRSlideViewDataSource {
    
    func numberOfPagesInSlideView(_ slideView: PRSlideView) -> Int {
        return imageData.count
    }
    
    func slideView(_ slideView: PRSlideView, pageAt index: Int) -> PRSlideViewPage {
        let page = slideView.dequeueReusablePage(withIdentifier: String(describing: type(of: ImagePage.self)),
                                                 for: index) as! ImagePage
        page.imageView.image = UIImage(named: imageData[index] + ".jpg")
        return page
    }
    
}

extension ViewController: PRSlideViewDelegate {
    
    func slideView(_ slideView: PRSlideView, didScrollToPageAt index: Int) {
        titleLabel.text = imageData[index]
    }
    
    func slideView(_ slideView: PRSlideView, didClickPageAt index: Int) {
        let alert = UIAlertController(title: nil,
                                      message: "You clicked on image \(imageData[index])",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
}
