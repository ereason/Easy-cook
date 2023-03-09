import Foundation

//описан протокол делегата запроса списка рецептов
protocol RequestListRecipeDelegate{
    func didUpdateRecipeList(_ requestListRecipeManager: RequestListRecipesManager, recipeList: RecipeListModel)
    func didFailWithError(error: Error)
}

struct RequestListRecipesManager{
    var delegate: RequestListRecipeDelegate?
    enum TypeQueryRecipes {
        case list(number: Int, offset: Int)
        case search(query: String, number: Int, offset: Int)
        case category(cat: String)
    }
    
    let apiKey = Secrets.API_KEY  //Dont forget to set in Secrets.swift !!!!
    func getURL(typeQuery: TypeQueryRecipes)->String{
        switch typeQuery {
        case .list(let number, let offset):
            return       "https://api.spoonacular.com/recipes/complexSearch?number=\(number)&sort=popularity&offset=\(offset)&apiKey=\(apiKey)"
        case .search(let query, let number, let offset):
            return "https://api.spoonacular.com/recipes/complexSearch?number=\(number)&offset=\(offset)&apiKey=\(apiKey)&query=\(query)"
        default:        //case .category(let cat):
            return ""
        }
    }
    
    //func fetchRecipe(number: Int, offset: Int, query: String)
    func fetchRecipe(query: TypeQueryRecipes) {
        performRequest(with: getURL(typeQuery: query))
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
