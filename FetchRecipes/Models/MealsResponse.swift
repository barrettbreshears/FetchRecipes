//
//  MealsResponse.swift
//  FetchRecipes
//
//  Created by Barrett Breshears on 11/8/23.
//

import Foundation

// Define the MealsResponse model to hold the response from the /filter.php endpoint.
struct MealsResponse: Codable {
    let meals: [Meal]
}
