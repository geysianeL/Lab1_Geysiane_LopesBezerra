//
//  ContentView.swift
//  Lab1_Geysiane_LopesBezerra
//
//  Created by Geysiane Lopes on 2025-02-13.
//

import SwiftUI

struct ContentView: View {
    @State private var number: Int = Int.random(in: 1...100)

    var body: some View {
        VStack {
            Text("\(number)")
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            HStack {
                Button("Prime") {
                    print("Prime button")
                }
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 140, height: 50)
                .background(Color.green)
                .cornerRadius(10)
                .padding()
                
                Button("Non-Prime") {
                    print("Non-Prime button")
                }
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 140, height: 50)
                .background(Color.red)
                .cornerRadius(10)
                .padding()
            }
        }
    }
    
    func isPrimeNumber(n: Int) -> Bool {
        if n < 2 { return false }
        for i in 2..<n {
            if n % i == 0 { return false }
        }
        return true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

}
