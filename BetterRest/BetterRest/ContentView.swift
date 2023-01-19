//
//  ContentView.swift
//  BetterRest
//
//  Created by Sanad on 15/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount: Double = 8.0
    @State private var wakeUp: Date = Date.now
    @State private var coffeeAmount = 1
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .center) {
                Text("When do you want to wake up?")
                    .font(.headline)
                
                DatePicker("Please enter a time",
                           selection: $wakeUp,
                           in: Date.now...,
                           displayedComponents: .hourAndMinute)
                .labelsHidden()
                
                Text("Desired amount to sleep")
                    .font(.headline)
                
                Stepper("\(sleepAmount.formatted()) hours",
                        value: $sleepAmount, in: 4...12,
                        step: 0.25)
                
                Text("Daily coffee intake")
                    .font(.headline)
                
                Stepper( coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups",
                         value: $coffeeAmount, in: 1...12,
                         step: 1)
            }
            .padding(.all)
            .navigationTitle("App")
            .toolbar {
                Button("Calculate") {
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
