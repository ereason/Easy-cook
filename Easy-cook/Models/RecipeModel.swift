import Foundation


struct RecipeModel {
  
    init(data: RecipeData){
        self.title=data.title
        self.imageURL=data.image
        self.imageType=data.imageType
        self.servings=data.servings
        self.Likes=data.aggregateLikes
        self.sourceURL = data.sourceURL
        self.steps = []
        self.ingredients = []
        
        data.analyzedInstructions[0].steps.forEach{
            steps.append($0.step)
        }
        
        data.extendedIngredients.forEach{
            self.ingredients.append( IngredientModel(data: $0) )
        }
    }
    
    let title: String
    let imageURL: String
    let imageType: String
    let servings: Int
    let Likes: Int
    let sourceURL: String
    
    var ingredients: [IngredientModel]
    var steps: [String]
   
}

struct IngredientModel{
    
    init(data: ExtendedIngredient){
        self.name = data.nameClean
    
        self.amount = data.measures.metric.amount
        self.units = data.measures.metric.unitShort
    }
    
    let name: String
    let amount: Double
    let units: String
}


