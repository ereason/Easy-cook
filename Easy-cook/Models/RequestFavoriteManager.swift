//
//  RequestFavorite.swift
//  Easy-cook
//
//  Created by Sergey Azimov on 07.03.2023.
//

import Foundation

// MARK: - RequestFavoriteManagerDelegate
protocol RequestFavoriteManagerDelegate{
    func didUpdateRecipe(_ requestManager: RequestFavoriteManager, recipe: RecipeModel)
    func didFailWithError(error: Error)
}

// MARK: - RequestFavoriteManager
struct RequestFavoriteManager{
    var delegate: RequestFavoriteManagerDelegate?
    let apiKey = Secrets.API_KEY  //Dont forget to set in Secrets.swift !!!!
    
    let arrayId = UserDefaults.standard.array(forKey: K.idFavorite)
    
    func formatIdToString() -> String {
        if let arrayId = UserDefaults.standard.array(forKey: K.idFavorite) as? [Int] {
            let IdString = arrayId.map { String($0) }.joined(separator: ",")
            print("https://api.spoonacular.com/recipes/informationBulk?apiKey\(apiKey)&ids=\(IdString)")
            return IdString
        }
        return "Error"
    }
    
    func getURL(recipeId: Int)->String{
        
        return "https://api.spoonacular.com/recipes/informationBulk?apiKey\(apiKey)&ids=\(formatIdToString())"
    }
    
    func fetchRecipe(_ recipeId: Int) {
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
                        self.delegate?.didUpdateRecipe(self, recipe: recipe)
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
            
            return RecipeModel(data: decodedData)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
