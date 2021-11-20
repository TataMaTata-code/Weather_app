//
//  DynamicHeightCollectionView.swift
//  CollectionViewTask
//
//  Created by Tata on 16/11/21.
//

import UIKit

class DynamicHeightCollectionView: UICollectionView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}
