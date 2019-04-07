//
//  BannerViewController+UICollectionViewDelegate.swift
//  Lojinha
//
//  Created by Anderson Oliveira on 07/04/19.
//  Copyright © 2019 andersonOliveira. All rights reserved.
//

import UIKit

extension BannerViewController: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard let layout = collectionView.collectionViewLayout as? SnapPagingLayout else { return }
        layout.willBeginDragging()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = collectionView.collectionViewLayout as? SnapPagingLayout else { return }
        print(targetContentOffset)
        layout.willEndDragging(withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
}

class SnapPagingLayout: UICollectionViewFlowLayout {
    private var centerPosition = true
    private var peekWidth: CGFloat = 0
    private var completion: ((Int) -> ())?
    private(set) var indexOfCellBeforeDragging = 0 {
        didSet {
            completion?(indexOfCellBeforeDragging)
        }
    }
    
    convenience init(centerPosition: Bool = true, peekWidth: CGFloat = 0, spacing: CGFloat? = 0, inset: CGFloat? = 0, completion: ((Int) -> ())? = nil) {
        self.init()
        
        self.scrollDirection = .horizontal
        self.centerPosition = centerPosition
        self.peekWidth = peekWidth
        self.completion = completion
        
        if let spacing = spacing {
            self.minimumLineSpacing = spacing
        }
        
        if let inset = inset {
            self.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        }
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        self.itemSize = calculateItemSize(from: collectionView.bounds.size)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView,
            !newBounds.size.equalTo(collectionView.bounds.size) else {
                return false
        }
        
        itemSize = calculateItemSize(from: collectionView.bounds.size)
        return true
    }
}

private extension SnapPagingLayout {
    
    func calculateItemSize(from bounds: CGSize) -> CGSize {
        return CGSize(
            width: bounds.width - peekWidth * 2,
            height: bounds.height
        )
    }
    
    func indexOfMajorCell() -> Int {
        guard let collectionView = collectionView else { return 0 }
        
        let proportionalOffset = collectionView.contentOffset.x
            / (itemSize.width + minimumLineSpacing)
        
        return Int(round(proportionalOffset))
    }
}

extension SnapPagingLayout {
    
    func willBeginDragging() {
        indexOfCellBeforeDragging = indexOfMajorCell()
    }
    
    func willEndDragging(withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let collectionView = collectionView else { return }
        
        // Stop scrollView sliding
        targetContentOffset.pointee = collectionView.contentOffset
        
        // Calculate where scrollView should snap to
        let indexOfMajorCell = self.indexOfMajorCell()
        
        guard let dataSourceCount = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: 0),
            dataSourceCount > 0 else {
                return
        }
        
        // Calculate conditions
        let swipeVelocityThreshold: CGFloat = 0.5 // After some trail and error
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < dataSourceCount && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging
            && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
        
        guard didUseSwipeToSkipCell else {
            // Better way to scroll to a cell
            collectionView.scrollToItem(
                at: IndexPath(row: indexOfMajorCell, section: 0),
                at: centerPosition ? .centeredHorizontally : .left, // TODO: Left ignores inset
                animated: true
            )
            completion?(indexOfMajorCell)
            return
        }
        
        let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
        var toValue = CGFloat(snapToIndex) * (itemSize.width + minimumLineSpacing)
        
        if centerPosition {
            // Back up a bit to center
            toValue = toValue - peekWidth + sectionInset.left
        }
        
        // Damping equal 1 => no oscillations => decay animation
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: velocity.x,
            options: .allowUserInteraction,
            animations: {
                collectionView.contentOffset = CGPoint(x: toValue, y: 0)
                collectionView.layoutIfNeeded()
            }) { (_) in
                self.completion?(snapToIndex)
        }
    }
}
