//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Gabriel on 01/06/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.info.name)
                TextField("Street Address", text: $order.info.streetAddress)
                TextField("City", text: $order.info.city)
                TextField("Zip", text: $order.info.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.info.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(order: Order(info: OrderInfo()))
        }
    }
}
