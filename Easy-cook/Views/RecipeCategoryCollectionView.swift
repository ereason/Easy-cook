//
//  RecipeCategoryCollectionView.swift
//  Easy-cook
//
//  Created by Дербе Эмма on 04.03.2023.
//

import UIKit

class RecipeCategoryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

 var cells = [RecieptListModel]()

 func set(cells: [RecieptListModel]) {
    self.cells = cells
}

// MARK: - init
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = 16
        contentInset = UIEdgeInsets(top: 0, left: CellsConstants.leftDestination, bottom: 0, right: CellsConstants.rightDestination)

        delegate = self
        dataSource = self
        register(RecipeCategoryViewCell.self, forCellWithReuseIdentifier: RecipeCategoryViewCell.reuseId)
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
        let cell = dequeueReusableCell(withReuseIdentifier: RecipeCategoryViewCell.reuseId, for: indexPath) as! RecipeCategoryViewCell
        cell.mainImage.image = cells[indexPath.row].image
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