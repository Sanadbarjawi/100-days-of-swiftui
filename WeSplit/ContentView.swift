//
//  ContentView.swift
//  WeSplit
//
//  Created by Sanad Barjawi on 20/06/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentages: [Int] = [15,20,25]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("amount", value: $amount, format: .currency(code: "USD"))
                    Picker("Numbe of People", selection: $numberOfPeople) {
                        ForEach(0..<10) { num in
                            Text("\(num)")
                        }
                    }.pickerStyle(.automatic)
                }
                Section("How much tip do you want to leave?") {
                    Picker("Tip Percentage", selection: $tipPercentages) {
                        ForEach(tipPercentages, id: \.self) { tip in
                            Text(tip, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
            }.navigationTitle("We Split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
