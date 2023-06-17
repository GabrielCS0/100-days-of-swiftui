//
//  ContactDetailsView.swift
//  C5-Eventfy
//
//  Created by Gabriel on 17/06/23.
//

import SwiftUI

struct ContactDetailsView: View {
    let contact: Contact
    
    var body: some View {
        VStack {
            Image(uiImage: contact.picture)
                .resizable()
                .scaledToFit()
        }
        .navigationTitle(contact.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
