//
//  MainView.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/26/26.
//

import SwiftUI

struct MainView: View {
    @Binding var cudget: Cudget
    
    private var todaysCudget: Int {
        Weekday.today().getCalories(from: cudget)
    }

    private var remainingCalories: Int {
        todaysCudget - foods.reduce(0) { $0 + $1.calories }
    }

    @State private var foods: [Food] = [
        Food(name: "Apple", calories: 95),
        Food(name: "Banana", calories: 105),
        Food(name: "Greek Yogurt", calories: 150),
//        Food(name: "Chicken Breast", calories: 240),
//        Food(name: "Rice Bowl", calories: 430),
//        Food(name: "Avocado Toast", calories: 290),
//        Food(name: "Turkey Sandwich", calories: 360),
//        Food(name: "Caesar Salad", calories: 410),
//        Food(name: "Protein Smoothie", calories: 320),
//        Food(name: "Eggs", calories: 140),
//        Food(name: "Oatmeal", calories: 180),
//        Food(name: "Peanut Butter Toast", calories: 330),
//        Food(name: "Salmon", calories: 390),
//        Food(name: "Pasta", calories: 520)
    ]
    
    private static let dummyFood = Food(name: "Dummy", calories: 0)
    
    @State private var selectedFood = Self.dummyFood
    @State private var showingFoodAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(spacing: 10) {
                HStack {
                    Text("Track your calories today!")
                        .font(
                            .footnote
                            .italic()
                        )
                        .contentShape(Rectangle())
                        .padding(.top, 3)
                    
                    Spacer()
                    
                    NavigationLink {
                        CudgetView(cudget: $cudget)
                    } label: {
                        Text("My Cudget 🗓️")
                            .font(.title2)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 10)

                Text("Cudget")
                    .font(.system(size: 84, weight: .black, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .center)
            }

            ScrollView {
                VStack(spacing: 8) {
                    if foods.isEmpty {
                        Text("🥗")
                            .font(.system(size: 36))

                        Text("no foods yet")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(foods) { food in
                            Button {
                                selectedFood = food
                                showingFoodAlert = true
                            } label: {
                                FoodRowView(name: food.name, calories: food.calories)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .frame(maxWidth: .infinity, minHeight: 220, maxHeight: 430)
            .background(Color.gray.opacity(0.18))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(spacing: 12) {
                HStack {
                    Text("Today's Cudget:")
                        .font(.title2.bold())

                    Spacer()

                    Text("\(todaysCudget)")
                        .font(.title2)
                }

                HStack {
                    Text("Remaining Calories:")
                        .font(.title2.bold())

                    Spacer()

                    Text("\(remainingCalories)")
                        .font(.title2)
                }
            }

            NavigationLink {
                FoodEntryView { food in
                    foods.append(food)
                }
            } label: {
                CalorieButtonView(text: "Add Food", color: .red)
            }
            .buttonStyle(.plain)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 24)
        .padding(.horizontal)
        .alert("Food Details", isPresented: $showingFoodAlert, presenting: selectedFood) { food in
            Button("Okay", role: .cancel) {
                selectedFood = Self.dummyFood
            }

            Button("Delete Food", role: .destructive) {
                foods.removeAll { $0.id == food.id }
                selectedFood = Self.dummyFood
            }
        } message: { food in
            Text(AttributedString("\(food.name)\n\(food.calories) cal"))
        }
    }
}

#Preview {
    MainView(cudget: .constant(Cudget()))
}
