//
//  MealDetail.swift
//  FetchRecipes
//
//  Created by Barrett Breshears on 11/8/23.
//

import Foundation

struct MealDetail: Decodable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: URL
    let strTags: String?
    let strYoutube: URL?
    let ingredients: [String]
    let measurements: [String]
    let ingredientsAndMasurements: [String]
    
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strCategory, strArea, strInstructions, strMealThumb, strTags, strYoutube
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
        case strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
        case strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5
        case strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15
        case strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strCategory = try container.decode(String.self, forKey: .strCategory)
        strArea = try container.decode(String.self, forKey: .strArea)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(URL.self, forKey: .strMealThumb)
        strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        strYoutube = try container.decodeIfPresent(URL.self, forKey: .strYoutube)
        
        
        // Extract ingredients and measurements
        var tempIngredients = [String]()
        var tempMeasurements = [String]()
        var tempIngredientsAndMasurements = [String]()
        for i in 1...20 {
            let ingredientKey = CodingKeys(rawValue: "strIngredient\(i)")!
            let measureKey = CodingKeys(rawValue: "strMeasure\(i)")!
            
            if let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey), !ingredient.isEmpty, let measurement = try container.decodeIfPresent(String.self, forKey: measureKey), !measurement.isEmpty {
                tempIngredients.append(ingredient)
                tempMeasurements.append(measurement)
                tempIngredientsAndMasurements.append("\(ingredient) - \(measurement)")
            }
        }
        ingredients = tempIngredients
        measurements = tempMeasurements
        ingredientsAndMasurements = tempIngredientsAndMasurements
    }
}
