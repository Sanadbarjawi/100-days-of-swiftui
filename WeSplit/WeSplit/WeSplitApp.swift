//
//  WeSplitApp.swift
//  WeSplit
//
//  Created by Sanad Barjawi on 20/06/2022.
//

import SwiftUI

@main
struct WeSplitApp: App {
    var body: some Scene {
        WindowGroup {
            SurveyForm(person: .init(name: "Sam", age: 30))
        }
    }
}

struct Person {
    var name: String
    var age: Int
}

struct SurveyForm: View {
    @State var person: Person
    
    var body: some View {
        Form {
            Section {
                TextField("username", text: $person.name)
                TextField("age", value: $person.age, format: .number)
            }
            Section {
                Text("name is \(person.name), age is \(person.age)")
            }
        }
    }
}
