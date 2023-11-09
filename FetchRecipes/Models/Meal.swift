//
//  Meal.swift
//  FetchRecipes
//
//  Created by Barrett Breshears on 11/8/23.
//

import Foundation

// Define the Meal model to hold individual meal data.
struct Meal: Codable, Identifiable {
    var id: String { idMeal }
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
