//
//  bottomBorderView.swift
//  Munchies
//
//  Created by Quinten Smith on 10/20/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class bottomBorderView: UIView {

    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func draw(_ rect: CGRect) {
        addSubview(borderView)

        // Height 1, bottom leading trailing
        borderView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        borderView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        borderView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        borderView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
