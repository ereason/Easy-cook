//
//  ViewController.swift
//  Easy cook
//
//  Created by George on 26.02.2023.
//

import UIKit

class ViewController: UIViewController, RequestManagerDelegate {

    var request = RequestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        
        request.delegate = self
        
        request.fetchRecipe(recipeId: 446729)
    }

    
    func didUpdateWeather(_ requestManager: RequestManager, recipe: RecipeModel) {
        DispatchQueue.main.async {
         print(recipe)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }

}

