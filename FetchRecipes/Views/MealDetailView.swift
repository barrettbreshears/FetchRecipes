//
//  MealDetailView.swift
//  FetchRecipes
//
//  Created by Barrett Breshears on 11/8/23.
//

import SwiftUI

// MealDetailView
struct MealDetailView: View {
    @StateObject var viewModel: MealDetailViewModel
    @Binding var meal:Meal?
    
    init( meal: Binding<Meal?> ) {
        _viewModel = StateObject(wrappedValue: MealDetailViewModel(mealID: meal.wrappedValue!.id))
        _meal = meal
    }
    
    var body: some View {
        ZStack {
            ScrollView{
                VStack {
                    AsyncImage(url: URL(string: meal!.strMealThumb)) { image in
                        image.resizable()
                    } placeholder: {
                        Rectangle()
                            .redacted(reason: .placeholder)
                    }
                    .frame(height: 300)
                    
                    Text(meal!.strMeal)
                        .font(.title)
                        .padding()
                    
                    
                    GroupBox(label: Label("Instructions", systemImage: "frying.pan.fill").font(.title), content: {
                        HStack {
                            Text(viewModel.mealDetail?.strInstructions ?? "")
                                .fontWeight(.semibold)
                                .padding()
                        }
                    }).padding()
                    
                    
                    GroupBox(label: Label("Ingredients", systemImage: "list.clipboard").font(.title), content: {
                        ForEach(viewModel.mealDetail?.ingredientsAndMasurements ?? [], id:\.self) { ingredients in
                            HStack {
                                Text(ingredients)
                                    .fontWeight(.semibold)
                                    .padding()
                                Spacer()
                            }
                        }
                    }).padding()
                    
                }
            }
            VStack{
                HStack{
                    Spacer()
                    Button(action: {meal = nil}, label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .background(Color.black)
                            .clipShape(Circle())
                            .foregroundColor(.white)
                            .padding()
                    })
                }
                Spacer()
            }
        }
        .onAppear {
            Task{
                await viewModel.loadMealDetails()
            }
        }
    }
}
