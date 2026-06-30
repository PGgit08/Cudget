//
//  MainView.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/26/26.
//

import SwiftUI

struct MainView: View {
    @Binding var cudget: Cudget
    @Binding var calories: [Calorie]
    
    private var todaysCudget: Int {
        Weekday.today().getCalories(from: cudget)
    }

    private var remainingCalories: Int {
        todaysCudget + calories.reduce(0) { $0 + $1.calories }
    }
    
    private static let dummyCalorie = Calorie(name: "Dummy", calories: 0)
    
    @State private var selectedCalorie = Self.dummyCalorie
    @State private var showingCalorieAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(spacing: 2) {
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
                .padding(.horizontal, 12)

                Text("Cudget")
                    .font(.system(size: 84, weight: .black, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.top, 10)

            ScrollView {
                VStack(spacing: 8) {
                    if calories.isEmpty {
                        Text("🥗 🏃")
                            .font(.system(size: 36))

                        Text("nothing yet")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(calories) { calorie in
                            Button {
                                selectedCalorie = calorie
                                showingCalorieAlert = true
                            } label: {
                                CalorieRowView(name: calorie.name, calories: calorie.calories)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .frame(maxWidth: .infinity, minHeight: 230, maxHeight: 430)
            .background(Color.gray.opacity(0.18))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(spacing: 12) {
                HStack {
                    Text("Today's Cudget:")
                        .font(.title2.bold())

                    Spacer()

                    Text("\(todaysCudget) cal")
                        .font(.title2)
                }

                HStack {
                    Text("Remaining Calories:")
                        .font(.title2.bold())

                    Spacer()

                    Text("\(remainingCalories) cal")
                        .font(.title2)
                }
            }
            .padding()

            VStack(spacing: 10) {
                NavigationLink {
                    CalorieEntryView(activity: false, onAdd: { calorie in
                        calories.append(calorie)
                    })
                } label: {
                    CalorieButtonView(text: "Add Food", color: .red)
                }
                .buttonStyle(.plain)
                
                NavigationLink {
                    CalorieEntryView(activity: true, onAdd: { calorie in
                        calories.append(calorie)
                    })
                } label: {
                    CalorieButtonView(text: "Add Activity", color: .green)
                }
                .buttonStyle(.plain)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.horizontal)
        .alert("Details", isPresented: $showingCalorieAlert, presenting: selectedCalorie) { calorie in
            Button("Okay", role: .cancel) {
                selectedCalorie = Self.dummyCalorie
            }

            Button("Delete", role: .destructive) {
                calories.removeAll { $0.id == calorie.id }
                selectedCalorie = Self.dummyCalorie
            }
        } message: { calorie in
            Text(AttributedString("\(calorie.name)\n\(calorie.calories) cal"))
        }
    }
}

#Preview {
    MainView(cudget: .constant(Cudget()), calories: .constant([
        Calorie(name: "Apple", calories: 95),
        Calorie(name: "Banana", calories: 105),
        Calorie(name: "Greek Yogurt", calories: 150)
    ]))
}
