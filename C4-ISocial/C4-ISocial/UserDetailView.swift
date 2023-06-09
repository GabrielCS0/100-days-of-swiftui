//
//  UserDetailView.swift
//  C4-ISocial
//
//  Created by Gabriel on 05/06/23.
//

import SwiftUI

struct UserDetailView: View {
    let user: CachedUser
    let registeredDate: Date

    var body: some View {
        ScrollView {
            Text("\(user.wrappedName), \(user.age) years old")
                .font(.title)

            Text("Works at \(user.wrappedCompany)")
                .padding(.vertical, 3)

            Text(user.wrappedAbout)
                .padding(.bottom, 3)

            Text("Registered on \(registeredDate.formatted(date: .long, time: .omitted))")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
            
            Group {
                Text("Friends")
                    .font(.title2)
                    .padding(.top, 20)
                
                ForEach(user.friendsArray) { friend in
                    Text(friend.wrappedName)
                        .font(.subheadline)
                        .padding(.vertical, 1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
        }
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
        .padding(15)
    }
    
    init(user: CachedUser) {
        self.user = user
        self.registeredDate = ISO8601DateFormatter().date(from: user.wrappedRegistered)!
    }
}
