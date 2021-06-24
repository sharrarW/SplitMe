//
//  ContentView.swift
//  SplitMe
//
//  Created by Sharrar Wasit on 6/23/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercent = 2
    let tipPercentages = [10,15,18,20,25]
    
    //TIP Computed property
    var tipAmount: Double {
        let tipSelected = Double(tipPercentages[tipPercent])
        let orderAmount = Double(checkAmount) ?? 0
        
        return orderAmount/100 * tipSelected
    }
    
    //GRAND TOTAL Computed property
    var grandTotal: Double {
        let orderAmount = Double(checkAmount) ?? 0
        
        return orderAmount + tipAmount
    }
    
    
    //TOTAL PER Computed property
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 50) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("Select tip")) {
                    Picker("Select tip", selection: $tipPercent) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("Base amount: \(checkAmount)")
                    Text("Tip amount: \(tipAmount, specifier: "%.2f")")
                    Text("Total amount to be split: \(grandTotal, specifier: "%.2f")")
                }
                
                .font(.footnote)
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                
            }
            .navigationBarTitle("Split Me!")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
