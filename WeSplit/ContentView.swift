//
//  ContentView.swift
//  WeSplit
//
//  Created by Dominik Zehe on 09.06.24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [5, 10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body:some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))//prüft die localen settings, wenn keine verfügbar nimmt er euro
                        .keyboardType(.decimalPad) //keyboard nur mit zhahlen
                        .focused($amountIsFocused) //focusstate, wichtig für den done button weiter unten
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) { //auswahl von 2-100
                            Text("\($0) people")
                            
                            
                        }
                    }
                    // OPTIONAL .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self){ //auswahl von 0-100
                            Text($0, format: .percent)
                        }
                    }
                    //.pickerStyle(.segmented) erzeugt nebeneinander
                    .pickerStyle(.navigationLink) //neue seite mit auswahl
                }
                
                Section("Amount + tip") {
                    
                    Text(checkAmount + checkAmount / 100 * Double(tipPercentage), format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                }
                
            }
            .navigationTitle("WeSplit") //titel der app, bzw. des navigation stacks
            .toolbar { //blendet einen done button oben rechts ein wenn das amount feld im focus ist
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
