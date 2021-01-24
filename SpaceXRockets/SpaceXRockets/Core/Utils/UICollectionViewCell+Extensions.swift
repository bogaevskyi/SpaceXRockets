//
//  UICollectionViewCell+Extensions.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import UIKit

extension UICollectionViewCell {
    static var defaultNibName: String {
        return String(describing: self)
    }
    
    class var defaultReuseIdentifier: String {
        return "\(defaultNibName)ReuseIdentifier"
    }
    
    static var defaultNib: UINib {
        return getNib(nibName: defaultNibName)
    }
    
    static func getNib(nibName: String) -> UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
    
    static func getCellFromDefaultNib<T: UICollectionViewCell>() -> T {
        return getCell(fromNib: defaultNibName)
    }
    
    static func getCell<T: UICollectionViewCell>(fromNib nibName: String) -> T {
        guard let cell = getNib(nibName: nibName).instantiate(withOwner: nil, options: nil).first as? T else {
            fatalError("\(self) can not be initialized from nib \(nibName)")
        }
        return cell
    }
    
    static func registerNib(for collectionView: UICollectionView) {
        registerNib(for: collectionView, reuseIdentifier: defaultReuseIdentifier)
    }
    
    static func registerNib(for collectionView: UICollectionView, reuseIdentifier: String) {
        let nib = UINib(nibName: defaultNibName, bundle: Bundle(for: self))
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    static func registerClass(for collectionView: UICollectionView) {
        registerClass(for: collectionView, reuseIdentifier: defaultReuseIdentifier)
    }
    
    static func registerClass(for collectionView: UICollectionView, reuseIdentifier: String) {
        collectionView.register(self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    static func dequeue<T: UICollectionViewCell>(from collectionView: UICollectionView, for indexPath: IndexPath) -> T {
        return dequeue(from: collectionView, for: indexPath, reuseIdentifier: defaultReuseIdentifier)
    }
    
    static func dequeue<T: UICollectionViewCell>(from collectionView: UICollectionView, for indexPath: IndexPath, reuseIdentifier: String) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue cell of type \(T.self) with reuse identifier '\(reuseIdentifier)'")
        }
        return cell
    }
}
