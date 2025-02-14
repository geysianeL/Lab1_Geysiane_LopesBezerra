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
    @State private var showSkipAlert = false
    @State private var showResults = false
    
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
                Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(isCorrect ? .green : .red)
                    .font(.system(size: 80))
                    .padding()
            }
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
        isCorrect = isPrime == isPrimeNumber(n: number)
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            wrongAnswers += 1
            number = Int.random(in: 1...100)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
