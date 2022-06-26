//
//  ContentView.swift
//  WeSplit
//
//  Created by Sanad Barjawi on 20/06/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount: Double
    @State private var selectedNumberOfPeople: Int
    @State private var selectedTipPercentage: Int
    
    private var numberOfPeopleRange = 1...100
    private var tipPercentages: [Int] = [10,15,20,25]

    private var totalAmount: Double {
        let peopleCount = Double(selectedNumberOfPeople)
        let tipSelection = Double(selectedTipPercentage)
        let tipValue = amount / 100 * tipSelection
        let total = tipValue / peopleCount
        return total
    }
    
    init() {
        _selectedNumberOfPeople = .init(initialValue: numberOfPeopleRange.lowerBound)
        _selectedTipPercentage = .init(initialValue: tipPercentages.first!)
        _amount = .init(initialValue: 0.0)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("amount", value: $amount, format: .currency(code: "USD"))
                    Picker("Numbe of People", selection: $selectedNumberOfPeople) {
                        ForEach(numberOfPeopleRange, id: \.self) { num in
                            Text("\(num)")
                        }
                    }.pickerStyle(.automatic)
                }
                Section {
                    Picker("Tip Percentage", selection: $selectedTipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(totalAmount, format: .currency(code: "USD"))
                }
            }
            .navigationTitle("We Split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
