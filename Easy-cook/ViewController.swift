//
//  ViewController.swift
//  Easy cook
//
//  Created by George on 26.02.2023.
//

// An example for inherinetce of Table View between VC's

import UIKit

class ViewController: ReciptsListVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        
        request.delegate = self
        
        request.fetchRecipe(recipeId: 446729)
        reciepts = fetchNewData()
    }

    
    func didUpdateWeather(_ requestManager: RequestManager, recipe: RecipeModel) {
        DispatchQueue.main.async {
         print(recipe)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
     func fetchNewData() -> [RecieptListModel] {
        let reciept1 = RecieptListModel(image: UIImage(named: "reciptExampleImage")!, title: "Home made Shwarma")
        let reciept2 = RecieptListModel(image: UIImage(named: "foodPictureExample")!, title: "EggCookedfifteenMINUTS")
        let reciept3 = RecieptListModel(image: UIImage(named: "123picture")!, title: "IDk whats is it but looks tasty")
        let reciept4 = RecieptListModel(image: UIImage(named: "reciptExampleImage")!, title: "Home made Shwarma")
        let reciept5 = RecieptListModel(image: UIImage(named: "foodPictureExample")!, title: "EggCookedfifteenMINUTS")
        return [reciept1, reciept2, reciept3, reciept4, reciept5]
    }
}

