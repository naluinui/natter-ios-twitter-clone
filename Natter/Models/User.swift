import Foundation
import FirebaseFirestore

struct User: Codable {
    let id: String
    let name: String
    let imageURL: String

    public static func from(doc: DocumentSnapshot) -> User? {
        guard let data = doc.data(),
            let name = data["name"] as? String
        else {
            return nil
        }
        
        let imageURL = data["imageUrl"] as? String ?? ""
        
        return User(id: doc.documentID, name: name, imageURL: imageURL)
    }
}
