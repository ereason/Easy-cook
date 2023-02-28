//
//  requestManager.swift
//  Easy cook
//
//  Created by George on 28.02.2023.
//

import Foundation

protocol RequestManagerDelegate{
    func didUpdateWeather(_ requestManager: RequestManager, recipe: RecipeModel)
    func didFailWithError(error: Error)
}

struct RequestManager{
    var delegate: RequestManagerDelegate?
    
    let apiKey = Secrets.API_KEY
    func getURL(recipeId: Int)->String{
        return "https://api.spoonacular.com/recipes/\(recipeId)/information?apiKey=\(apiKey)"
    }
    
    
    func fetchRecipe(recipeId: Int) {
        performRequest(with: getURL(recipeId: recipeId))
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
                        self.delegate?.didUpdateWeather(self, recipe: recipe)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(_ recipeData: Data) -> RecipeModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RecipeData.self, from: recipeData)
            let title = decodedData.title
            
            return RecipeModel(title: title)
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
