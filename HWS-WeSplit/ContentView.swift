//
//  ContentView.swift
//  HWS-WeSplit
//
//  Created by Alexander Clark on 11/9/21.
//

import SwiftUI

struct ContentView: View {
    
    //Creating variables for Two Way Binding
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    //Creating Array for Tip Percentage Picker
    let tipPercentages = [10,15,20,25,0]
    
    //Calcuating total per a Person
    var totalPerPerson: Double{
        
        let peopleCount = Double(numberOfPeople+2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        let amountPerPerson = grandTotal / peopleCount
        
        
        return amountPerPerson
    }
    
    //Calculating the Total Bill
    var totalBill : Double{
        
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        
        //Creating a Navigation View to allow Picker to goto second screen to pick number of people
        NavigationView{
        Form{
            
            //Creating first section which asks for amount in Users Locale currency defaulting to USD if it cant be determined
            // Forcing the Decimal Keyboard to appear
            // Managing Focused attribute to ensure Keyboard disappears correctly.
            Section{
                TextField("Whats the Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                
                //Creating Picker for number of People. Selection is binded to numberOfPeople attribrute offers values 2-100 using ForEach
                Picker("Number of People" , selection:$numberOfPeople){
                    ForEach(2..<100){
                        Text("\($0) people")
                    }
                }
            }
            
            //Creating Second Section for Tip Percentage
            Section{
                //Creating another Picker for Tip Percentage using Segmented Style vs the new View Style
                Picker("Tip Percentage", selection: $tipPercentage){
                    ForEach(tipPercentages, id: \.self){
                        Text($0, format: .percent)
                    }
                }.pickerStyle(.segmented)
            }
            
            //Adding a header to provide more information on what the User is selecting
        header:{
                Text("Select a Tip Percentage")
            }
            
            //Creating Third Section to show Total Per a person based off totalPerPerson calcuation above
            Section{
                Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
            }header:{
                Text("Total per a Person")
            }
            
            //Creating fourth section to show Total Bill with Tip Included
            Section{
                Text(totalBill, format: .currency(code: Locale.current.currencyCode ?? "USD"))
            }header:{
                Text("Total bill with Tip")
            }
            
            //Adding App Title to Navigation View
        }.navigationTitle("We Split")
            //Adding Toolbar to Keyboard
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        ///Adding Spacer to force Done! Button to right side of the keyboard
                        Spacer()
                        //Adding Done Button when hit changes amountIsFocused to false causing keyboard to correctly disappear.
                        Button("Done!"){
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
