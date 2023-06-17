//
//  Contact.swift
//  C5-Eventfy
//
//  Created by Gabriel on 16/06/23.
//

import Foundation
import SwiftUI

struct Contact: Identifiable, Codable, Comparable {
    enum CodingKeys: CodingKey {
        case id, name, picture
    }
    
    var id = UUID()
    let name: String
    let picture: UIImage
    
    init(name: String, picture: UIImage) {
        self.name = name
        self.picture = picture
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UUID.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        
        let pictureData = try values.decode(Data.self, forKey: .picture)
        let decodedPicture = UIImage(data: pictureData) ?? UIImage()
        picture = decodedPicture
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        
        if let jpegData = picture.jpegData(compressionQuality: 0.8) {
            try container.encode(jpegData, forKey: .picture)
        }
    }
    
    static func <(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.name < rhs.name
    }
}
