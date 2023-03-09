//
//  RecipeCategoryCollectionView.swift
//  Easy-cook
//
//  Created by Дербе Эмма on 04.03.2023.
//

import UIKit
import Kingfisher

class RecipeCategoryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

 var cells = [ResultModel]()

 func set(cells: [ResultModel]) {
    self.cells = cells
    self.reloadData()
}

// MARK: - init
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = 16
        contentInset = UIEdgeInsets(top: 0, left: CellsConstants.leftDestination, bottom: 0, right: CellsConstants.rightDestination)

        backgroundColor = .backgroundColor
        delegate = self
        dataSource = self
        register(RecipeCategoryViewCell.self, forCellWithReuseIdentifier: K.reuseIdRecipwCategoryVC)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - numberOFItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }

// MARK: - cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: K.reuseIdRecipwCategoryVC, for: indexPath) as! RecipeCategoryViewCell
    
        cell.mainImage.kf.setImage(with: URL(string: cells[indexPath.row].image))
        cell.recipeLabel.text = cells[indexPath.row].title
        return cell
    }

}

//MARK: - sizeForItem
extension RecipeCategoryCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: 300, height: 458)
    }
}
