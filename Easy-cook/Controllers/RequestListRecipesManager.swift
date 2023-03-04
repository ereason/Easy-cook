//
//  RequestListRecipesManager.swift
//  Easy-cook
//
//  Created by MacBook on 02.03.2023.
//

import Foundation

protocol RequestListRecipeDelegate{
    func didUpdateRecipeList(_ requestListRecipeManager: RequestListRecipesManager, recipeList: RecipeListModel)
    func didFailWithError(error: Error)
}

struct RequestListRecipesManager{
    var delegate: RequestListRecipeDelegate?
    
    let apiKey = Secrets.API_KEY  //Dont forget to set in Secrets.swift !!!!
    func getURL(number: Int, offset: Int)->String{
        return "https://api.spoonacular.com/recipes/complexSearch?number=\(number)&sort=popularity&offset=\(offset)&apiKey=\(apiKey)"
        //return "https://api.spoonacular.com/recipes/\(recipeId)/information?apiKey=\(apiKey)&includeNutrition=true"
        //https://api.spoonacular.com/recipes/complexSearch?number=\(number)&sort=popularit&offset=\(offset)&apiKey=\(apiKey)
    }
    
    func fetchRecipe(number: Int, offset: Int) {
        performRequest(with: getURL(number: number, offset: offset))
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let recipe = self.parseJSON(safeData) {
                        self.delegate?.didUpdateRecipeList(self, recipeList: recipe)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(_ recipeListData: Data) -> RecipeListModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Recipes.self, from: recipeListData)
            
            return RecipeListModel(data: decodedData)
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
