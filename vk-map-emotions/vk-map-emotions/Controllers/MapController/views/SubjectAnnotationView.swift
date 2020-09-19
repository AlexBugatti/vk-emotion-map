//
//  SubjectAnnotationView.swift
//  vk-map-emotions
//
//  Created by Александр on 19.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import MapKit

final class SubjectAnnotationView: MKAnnotationView, ReusableView {

    // MARK: Initialization

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)

        canShowCallout = true
        setupUI(post: annotation as? Post)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup

    lazy var pinView: PinView = {
        var view = PinView()
        return view
    }()
   func setupUI(post: Post?) {
        backgroundColor = .clear

//        let view = PinView()
//        view.titleLabel.text = post?.subject.toEmodji()
//        view.layer.cornerRadius = 25
//        view.layer.masksToBounds = true
        
        addSubview(self.pinView)
        self.pinView.frame = bounds
        self.pinView.layer.cornerRadius = bounds.height / 2
        self.pinView.layer.masksToBounds = true
    }
}
