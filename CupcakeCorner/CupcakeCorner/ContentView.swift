//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Gabriel on 01/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order(info: OrderInfo())
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.info.type) {
                        ForEach(OrderInfo.types.indices, id: \.self) {
                            Text(OrderInfo.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.info.quantity)", value: $order.info.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.info.specialRequestEnabled.animation())
                    
                    if order.info.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.info.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.info.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
