//
//  ContentView.swift
//  WeSplit
//
//  Created by Sanad Barjawi on 20/06/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount: Double?
    @State private var selectedNumberOfPeople: Int
    @State private var selectedTipPercentage: Int
    @FocusState private var amountFieldIsFocused: Bool
    
    private var currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: "USD")
    private var numberOfPeopleRange = 1...100
    private var tipPercentages: Range<Int> =  0..<101

    private var totalAmount: Double {
        let peopleCount = Double(selectedNumberOfPeople)
        let tipSelection = Double(selectedTipPercentage)
        let tipValue = (amount ?? 0.0) / 100 * tipSelection
        let total = tipValue / peopleCount
        return total
    }
    
    private var amountPerCheck: Double {
        return (amount ?? 0.0) + Double(selectedTipPercentage)
    }
    
    init() {
        _selectedNumberOfPeople = .init(initialValue: numberOfPeopleRange.lowerBound)
        _selectedTipPercentage = .init(initialValue: tipPercentages.first!)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("amount", value: $amount, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountFieldIsFocused)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    amountFieldIsFocused = false
                                }
                            }
                        }
                    Picker("Number of People", selection: $selectedNumberOfPeople) {
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
                    }.pickerStyle(.automatic)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(totalAmount, format: currencyFormat)
                } header: {
                    Text("Amount per person")
                }
                Section {
                    Text(amountPerCheck, format: currencyFormat)
                } header: {
                    Text("Total amount for the check")
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
