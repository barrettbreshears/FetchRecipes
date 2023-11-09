//
//  MealDetailResponse.swift
//  FetchRecipes
//
//  Created by Barrett Breshears on 11/8/23.
//

import Foundation

struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}
