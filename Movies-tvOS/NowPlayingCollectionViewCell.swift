//
//  NowPlayingCollectionViewCell.swift
//  Movies
//
//  Created by Rodrigo Andrade on 3/11/16.
//  Copyright © 2016 Rodrigo Andrade. All rights reserved.
//

import UIKit

class NowPlayingCollectionViewCell: NowPlayingCVCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        poster.adjustsImageWhenAncestorFocused = true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        var color: UIColor!
        var transform: CGAffineTransform!
        var font: UIFont!
        
        if context.previouslyFocusedView == self {
            color = UIColor.black
            transform = CGAffineTransform.identity
            font = UIFont.systemFont(ofSize: 16)
        }
        else {
            color = UIColor.white
            transform = CGAffineTransform(translationX: 0, y: 40)
            font = UIFont.boldSystemFont(ofSize: 24)
        }
        
        coordinator.addCoordinatedAnimations({
            self.nameLabel.transform = transform
            self.nameLabel.textColor = color
            self.nameLabel.font = font
            }, completion: nil)
    }

}
