//
//  UserDetailView.swift
//  C4-ISocial
//
//  Created by Gabriel on 05/06/23.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    let registeredDate: Date

    var body: some View {
        ScrollView {
            Text("\(user.name), \(user.age) years old")
                .font(.title)

            Text("Works at \(user.company)")
                .padding(.vertical, 3)

            Text(user.about)
                .padding(.bottom, 3)

            Text("Registered on \(registeredDate.formatted(date: .long, time: .omitted))")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
            
            Group {
                Text("Friends")
                    .font(.title2)
                    .padding(.top, 20)
                
                ForEach(user.friends) { friend in
                    Text(friend.name)
                        .font(.subheadline)
                        .padding(.vertical, 1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
        .padding(15)
    }
    
    init(user: User) {
        self.user = user
        self.registeredDate = ISO8601DateFormatter().date(from: user.registered)!
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDetailView(user: User(
                id: "50a48fa3-2c0f-4397-ac50-64da464f9954",
                isActive: false,
                name: "Alford Rodriguez",
                age: 37,
                company: "Imkan",
                email: "alfordrodriguez@imkan.com",
                address: "907 Nelson Street, Cotopaxi, South Dakota, 5913",
                about:  "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco.",
                registered: "2015-11-10T01:47:18-00:00",
                tags: ["cillum", "consequat", "deserunt"],
                friends: [
                    Friend(
                        id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0",
                        name: "Hawkins Patel"
                    ),
                    Friend(
                        id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6",
                        name: "Jewel Sexton"
                    )
                ]
            ))
        }
    }
}
