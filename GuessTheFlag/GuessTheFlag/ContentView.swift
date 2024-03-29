//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sanad Barjawi on 10/07/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland","Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var correctAnswers: Int = 0
    @State private var selectedAnswer: Int = 0
    
    //user gets asked only 8 questions
    @State private var numberofQuestions: Int = 8
    @State private var currentQuestionIndex: Int = 1
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45),
                                         location: 0.3),
                                   .init(color: Color(red: 0.76, green: 0.15, blue: 0.26),
                                                                location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .titleStyle()
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { index in
                        Button {
                            flagTapped(using: index)
                        } label: {
                            FlagImage(image: Image(countries[index]))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(correctAnswers)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                Text("Question: \(currentQuestionIndex)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
        }
            
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(correctAnswers)")
        }
    }
    
    func flagTapped(using number: Int) {
        selectedAnswer = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            correctAnswers += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[selectedAnswer])"
        }
        showingScore = true
        
        if currentQuestionIndex == numberofQuestions {//user reached 8 questions, reset game.
            correctAnswers = 0
            currentQuestionIndex = 0
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        currentQuestionIndex+=1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlagImage: View {
    let image: Image
    var body: some View {
        image
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(.largeTitle.bold())
    }
}
extension View {
    func titleStyle() -> some View {
        return modifier(TitleStyle())
    }
}
