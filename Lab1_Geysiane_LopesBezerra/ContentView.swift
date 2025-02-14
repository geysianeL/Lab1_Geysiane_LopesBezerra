//
//  ContentView.swift
//  Lab1_Geysiane_LopesBezerra
//
//  Created by Geysiane Lopes on 2025-02-13.
//

import SwiftUI
import AVFoundation
import AudioToolbox

struct ContentView: View {
    @State private var number: Int = Int.random(in: 1...100)
    @State private var isCorrect: Bool? = nil
    @State private var correctAnswers = 0
    @State private var wrongAnswers = 0
    @State private var attempts = 0
    @State private var timer: Timer?
    @State private var showResults = false
    @State private var showSkipAlert = false

    
    var body: some View {
        VStack {
            Spacer()
            
            // Display Number
            Text("\(number)")
                .font(.largeTitle)
                .italic()
                .foregroundColor(.blue)
                .padding(.bottom, 20)
            
            Spacer()
            
            // Prime and Non-Prime Buttons
            HStack {
                Button("Prime") {
                    checkAnswer(isPrime: true)
                }
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 140, height: 50)
                .background(Color.green)
                .cornerRadius(10)
                .padding()
                
                Button("Non-Prime") {
                    checkAnswer(isPrime: false)
                }
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 140, height: 50)
                .background(Color.red)
                .cornerRadius(10)
                .padding()
            }
            
            Spacer()
            
            if let isCorrect = isCorrect {
                Text(isCorrect ? "Correct!" : "Wrong!")
                    .font(.title)
                    .bold()
                    .foregroundColor(isCorrect ? .green : .red)
                    .padding()
            }
            
            Spacer()
            
            // Score Display
            HStack {
                Text("✅ \(correctAnswers) | ❌ \(wrongAnswers)")
                    .font(.headline)
                    .bold()
                    .padding()
                Spacer()
            }
            
            Button("Skip") {
                showSkipAlert = true
            }
            .alert("Skip this number?", isPresented: $showSkipAlert) {
                Button("Yes") { generateNewNumber() }
                Button("Cancel", role: .cancel) { }
            }
            .padding()


            Spacer()
        }
        .onAppear {
            startTimer()
        }
        .alert(isPresented: $showResults) {
            Alert(
                title: Text("Game Over!"),
                message: Text("✅ Correct: \(correctAnswers)\n❌ Wrong: \(wrongAnswers)"),
                dismissButton: .default(Text("OK"), action: resetGame)
            )
        }

    }

    func isPrimeNumber(n: Int) -> Bool {
        if n < 2 { return false }
        if n == 2 { return true }
        if n % 2 == 0 { return false }
        
        for i in stride(from: 3, through: Int(Double(n).squareRoot()), by: 2) {
            if n % i == 0 { return false }
        }
        return true
    }

    func checkAnswer(isPrime: Bool) {
        timer?.invalidate()

        let correct = isPrime == isPrimeNumber(n: number)
        isCorrect = correct

        if correct {
            correctAnswers += 1
        } else {
            wrongAnswers += 1
        }

        attempts += 1

        if attempts >= 10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showResults = true
            }
            return
        }

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            generateNewNumber()
            startTimer()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            if isCorrect == nil {
                wrongAnswers += 1
                attempts += 1

                if attempts >= 10 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showResults = true
                    }
                } else {
                    generateNewNumber()
                    startTimer()
                }
            }
        }
    }
    func resetGame() {
        correctAnswers = 0
        wrongAnswers = 0
        attempts = 0
        generateNewNumber()
    }

    func generateNewNumber() {
        var newNumber: Int
        repeat {
            newNumber = Int.random(in: 1...100)
        } while newNumber == number
        number = newNumber
        isCorrect = nil
        startTimer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
