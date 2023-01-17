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
    
    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted()) hours",
                    value: $sleepAmount, in: 4...12,
                    step: 0.25)
            DatePicker("Please enter a time",
                       selection: $wakeUp,
                       in: Date.now...,
                       displayedComponents: .hourAndMinute)
        }
        .padding(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
