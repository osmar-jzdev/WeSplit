//
//  ContentView.swift
//  WeSplit
//
//  Created by Osmar Juarez on 09/03/25.
//

import SwiftUI

struct ContentView: View {
//    @State private var countButton = 0
//    @State private var userName: String = ""
//    let students = ["Chris", "Jess", "Osmar", "Street", "Nikola"]
//    @State private var selectedStudent: String = ""
//    
//    
//    var body: some View {
//        NavigationStack{
//            Form {
//                Section {
//                    Text("Printing...")
//                }
//                Section{
//                    Button("Count press: \(countButton)") {
//                        countButton += 1
//                    }
//                }
//                Section{
//                    TextField("Enter your name", text: $userName )
//                    Text("User: \(userName)")
//                }
//                Section{
//                    Picker("Select your students:",  selection: $selectedStudent) {
//                        ForEach(students, id: \.self) {
//                            Text($0)
//                        }
//                    }
//                }
//            }
//            .navigationTitle("WeSplit")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//        
//    }
    @FocusState private var isAmountFocused: Bool

    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    let tipPercentages = [10,15,25,30,0]
    
    var totalsPerPerson: [Double] {
        let peopleCount: Double = Double(numberOfPeople + 2)
        let tipSelection: Double = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal: Double = checkAmount + tipValue
        
        return [tipSelection, grandTotal / peopleCount]
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section{
                    TextField("Ammount to split", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocused)
                    Picker("Number of people:",  selection: $numberOfPeople) {
                        ForEach(2..<100){
                                Text("\($0) people ")
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("How much do you wanna to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section("Totals") {
                    Text(totalsPerPerson.first!, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    Text(totalsPerPerson[1], format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isAmountFocused {
                    Button("Done") {
                        isAmountFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
