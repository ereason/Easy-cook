//
//  RecieptListModel.swift
//  Easy-cook
//
//  Created by Дербе Эмма on 04.03.2023.
//

import UIKit
struct RecieptListModel {
    let image: UIImage
    let title: String

    static func fetchData() -> [RecieptListModel] {
        let reciept1 = RecieptListModel(image: UIImage(named: "reciptExampleImage")!, title: "Home made Shwarma")
        let reciept2 = RecieptListModel(image: UIImage(named: "foodPictureExample")!, title: "EggCookedfifteenMINUTS")
        let reciept3 = RecieptListModel(image: UIImage(named: "123picture")!, title: "IDk whats is it but looks tasty")
        let reciept4 = RecieptListModel(image: UIImage(named: "reciptExampleImage")!, title: "Home made Shwarma")
        let reciept5 = RecieptListModel(image: UIImage(named: "foodPictureExample")!, title: "EggCookedfifteenMINUTS")
        let reciept6 = RecieptListModel(image: UIImage(named: "123picture")!, title: "IDk whats is it but looks tasty")
        let reciept7 = RecieptListModel(image: UIImage(named: "reciptExampleImage")!, title: "Home made Shwarma")
        let reciept8 = RecieptListModel(image: UIImage(named: "foodPictureExample")!, title: "EggCookedfifteenMINUTS")
        let reciept9 = RecieptListModel(image: UIImage(named: "123picture")!, title: "IDk whats is it but looks tasty")
        let reciept10 = RecieptListModel(image: UIImage(named: "reciptExampleImage")!, title: "Home made Shwarma")

        return [reciept1, reciept2, reciept3, reciept4, reciept5, reciept6, reciept7, reciept8, reciept9, reciept10]
    }
}
