//
//  NowPlayingCollectionViewController.swift
//  Movies
//
//  Created by Rodrigo Andrade on 3/10/16.
//  Copyright © 2016 Rodrigo Andrade. All rights reserved.
//

import UIKit

protocol FocusableCell {
    func setFocused(_ focused: Bool, withAnimationCoordinator coordinator:UIFocusAnimationCoordinator)
}

class NowPlayingCollectionViewController: NowPlayingCVController {
    
    // MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.layoutMargins = UIEdgeInsets(top: 60.0, left: 90.0, bottom: 60.0, right: 90.0)
    }
}
