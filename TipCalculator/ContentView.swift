//
//  ContentView.swift
//  TipCalculator
//
//  Created by Michael DiGregorio on 1/15/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var checkAmount: Double? = nil
    @State private var tipPercentage: Int = 20
    @State private var numberOfPeople: Int = 3
    @FocusState private var checkAmountIsFocused: Bool
    
    private let tipPercentages: [Int] = [10, 15, 20, 25, 0]
    
    var totalBillAmount: Double {
        let tipSelection = Double(tipPercentage)
        guard let totalAmount = checkAmount else { return 0.0 }
            
        let tipPercent: Double = 1 + (tipSelection / 100)
        
        return totalAmount * tipPercent
    }
    
    var amountPerPerson: Double {
        
        let numPeople = Double(numberOfPeople) + 1
        return totalBillAmount / numPeople
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    // Base amount and number of people
                    TextField("Total Check Amount", value: $checkAmount, format: .currency( code: Locale.current.currencyCode ?? "USD" ) )
                        .keyboardType(.decimalPad)
                        .focused($checkAmountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(1..<100) {
                            if ($0 == 1) {
                                Text("\($0) Person")
                            } else {
                                Text("\($0) People")
                            }
                        }
                    }
                }
                
                Section {
                    // tip selector
                    Picker("Tip Amount", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much do you want to tip?")
                }
                
                Section {
                    Text(totalBillAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total Bill Amount")
                }
                Section {
                    // final calculation
                    Text(amountPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total Payment Per Person")
                }
            }
            .navigationTitle("Cost Calculator")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        checkAmountIsFocused = false
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
