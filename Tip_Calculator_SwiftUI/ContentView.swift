//
//  ContentView.swift
//  Tip_Calculator_SwiftUI
//
//  Created by Elliott Larsen on 7/30/22.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    let tipPercentages = [0, 10, 15, 20, 25]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 1)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount,
                              format: .currency(code: Locale.current.currencyCode ?? "USD")).keyboardType(.decimalPad)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(1 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Enter the total bill and number of people")
                .focused($amountIsFocused)
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip would you like to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code:
                                                            Locale.current.currencyCode ?? "USD"))
                }
            }
            .navigationTitle("Tip Calculator")
            .toolbar {
              ToolbarItemGroup(placement: .keyboard) {
                  Spacer()
                Button("Done") {
                  amountIsFocused = false
            }
                  
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
