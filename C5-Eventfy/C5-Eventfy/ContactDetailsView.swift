//
//  ContactDetailsView.swift
//  C5-Eventfy
//
//  Created by Gabriel on 17/06/23.
//

import SwiftUI

struct ContactDetailsView: View {
    @State private var pickerTab = 0
    
    let contact: Contact
    
    var body: some View {
        VStack {
            Picker("", selection: $pickerTab) {
                Text("Photo").tag(0)
                Text("Event location").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Spacer()
            
            if pickerTab == 0 {
                Image(uiImage: contact.picture)
                    .resizable()
                    .scaledToFit()
                
                Spacer()
            } else {
                if contact.eventLocation?.latitude != nil {
                    EventLocationMapView(coordinate: contact.eventLocation!)
                } else {
                    Text("The event location where you met this contact is not registered.")
                        .padding()
                    Spacer()
                }
            }
        }
        .navigationTitle(contact.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
