//
//  ListLayout.swift
//  Moonshot
//
//  Created by Gabriel on 25/05/23.
//

import SwiftUI

struct ListLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        List(missions) { mission in
            NavigationLink {
                MissionView(mission: mission, astronauts: astronauts)
            } label: {
                Image(decorative: mission.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .padding(.trailing)
                
                VStack(alignment: .leading) {
                    Text(mission.displayName)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(mission.formattedLaunchDate)
                        .font(.caption)
                }
            }
            .listRowBackground(Color.darkBackground)
        }
        .background(.darkBackground)
        .listStyle(.plain)
    }
}

struct ListLayout_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        ListLayout(missions: missions, astronauts: astronauts)
    }
}
