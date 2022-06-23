//
//  ContentView.swift
//  WeSplit
//
//  Created by Beto Toro on 22/06/22.
//

import SwiftUI

struct ContentView: View {
  
  @State private var checkAmount = 0.0
  @State private var numberOfPeople = 2
  @State private var tipPercentage = 20
  @FocusState private var amountIsFocused: Bool
  
  let currencyCode = Locale.current.currencyCode ?? "USD"
  let tipRange = [10, 15, 20, 25, 0]
  
  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let tipSelection = Double(tipPercentage)
    
    let tipValue = checkAmount / 100 * tipSelection
    let grandTotal = checkAmount + tipValue
    let amountPerPerson = grandTotal / peopleCount
    
    return amountPerPerson
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Amount", value: $checkAmount, format: .currency(code: currencyCode))
            .keyboardType(.decimalPad)
            .focused($amountIsFocused)
          
          Picker("Number of people", selection: $numberOfPeople) {
            ForEach(2..<100) { number in
              Text("\(number) people")
            }
          }
        }
        
        Section {
          Picker("Tip Percentage", selection: $tipPercentage) {
            ForEach(tipRange, id: \.self) { percentage in
              Text(percentage, format: .percent)
            }
          }
          .pickerStyle(.segmented)
        } header: {
          Text("How much tip do you want to leave?")
        }
        
        Section {
          Text(totalPerPerson, format: .currency(code: currencyCode))
        }
      }
      .navigationTitle("WeSplit")
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
 
