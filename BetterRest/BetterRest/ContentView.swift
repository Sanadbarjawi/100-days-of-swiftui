//
//  ContentView.swift
//  BetterRest
//
//  Created by Sanad on 15/01/2023.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount: Double = 8.0
    @State private var wakeUp: Date = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var isAlertPresented: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    private static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Please enter a time",
                               selection: $wakeUp,
                               displayedComponents: .hourAndMinute)
                    .labelsHidden()
                } header: {
                    Text("When do you want to wake up?")
                        .font(.headline)
                }
                Section {
                    Stepper("\(sleepAmount.formatted()) hours",
                            value: $sleepAmount, in: 4...12,
                            step: 0.25)
                } header : {
                    Text("Desired amount to sleep")
                        .font(.headline)
                }
                Section {
                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups",
                            value: $coffeeAmount, in: 1...12,
                            step: 1)
                } header : {
                    Text("Daily coffee intake")
                        .font(.headline)
                }
            }
            .navigationTitle("App")
            .toolbar {
                Button("Calculate") {
                    calculateBedTime()
                }
            }
            .alert(alertTitle,
                   isPresented: $isAlertPresented) {
                Button("Ok") {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let wakeUpComponents = Calendar.current.dateComponents([.hour, .minute],
                                                               from: wakeUp)
            let hour = (wakeUpComponents.hour ?? 0) * 60 * 60
            let minutes = (wakeUpComponents.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minutes),
                                                  estimatedSleep: sleepAmount,
                                                  coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is.."
            alertMessage = sleepTime.formatted(date: .omitted,
                                               time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "There was a problem calculating your bedtime"
        }
        isAlertPresented = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
