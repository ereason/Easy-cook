import Foundation

// MARK: - RecipeModel
struct RecipeModel {
    let title: String
    let imageURL: String
    let imageType: String
    let servings: Int
    let likes: Int
    let sourceURL: String
    let minutes: Int
    
    var ingredients: [IngredientModel]
    var steps: [String]
}

// MARK: RecipeModel convenience initializers
extension RecipeModel{
    init(data: RecipeData){
        self.title=data.title
        self.imageURL=data.image.replacingOccurrences(of: "http:", with: "https:")
        self.imageType=data.imageType
        self.servings=data.servings
        self.likes=data.aggregateLikes
        self.sourceURL = data.sourceURL
        self.steps = []
        self.ingredients = []
        self.minutes = data.readyInMinutes
        
        if (!data.analyzedInstructions.isEmpty){
            data.analyzedInstructions[0].steps.forEach{
                steps.append($0.step)
            }
        }
        
        data.extendedIngredients.forEach{
            self.ingredients.append( IngredientModel(data: $0) )
        }
    }
}

// MARK: - IngredientModel
struct IngredientModel{
    let name: String
    let amount: Double
    let units: String
    let original: String
}

// MARK: RecipeModel convenience initializers
extension IngredientModel{
    init(data: ExtendedIngredient){
        self.name = data.nameClean
        self.amount = data.measures.metric.amount
        self.units = data.measures.metric.unitShort
        self.original = data.original
    }
}
