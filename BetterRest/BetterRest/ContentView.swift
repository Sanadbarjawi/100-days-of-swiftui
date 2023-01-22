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
    @State private var calculatedBedTimeResult: String = "-"
    
    private static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        DatePicker("Please enter a time",
                                   selection: $wakeUp,
                                   displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .onChange(of: wakeUp) { _ in calculateBedTime() }
                    } header: {
                        Text("When do you want to wake up?")
                            .font(.headline)
                    }
                    Section {
                        Stepper("\(sleepAmount.formatted()) hours",
                                value: $sleepAmount, in: 4...12,
                                step: 0.25) { _ in
                            calculateBedTime()
                        }
                    } header : {
                        Text("Desired amount to sleep")
                            .font(.headline)
                    }
                    Section {
                        Picker(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups",
                               selection: $coffeeAmount) {
                            ForEach(Range(1...12), id: \.self) { cup in
                                Text("\(cup)")
                            }
                        }
                        .onChange(of: coffeeAmount) { _ in calculateBedTime() }

                    } header : {
                        Text("Daily coffee intake")
                            .font(.headline)
                    }
                    Section {} header : {
                        VStack(alignment: .leading) {
                            Text("Recommeneded bedtime is")
                            Text(calculatedBedTimeResult)
                        }
                        .font(.headline)
                    }
                }
            }
            .navigationTitle("App")
            .onAppear{
                calculateBedTime()
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
            calculatedBedTimeResult = sleepTime.formatted(date: .omitted,
                                               time: .shortened)
        } catch {
            calculatedBedTimeResult = "Error"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
