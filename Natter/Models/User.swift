import Foundation
import FirebaseFirestore

struct User {
    let id: String
    let name: String
    let imageURL: String

    public static func from(doc: DocumentSnapshot) -> User? {
        guard let data = doc.data(),
            let name = data["name"] as? String,
            let imageURL = data["imageUrl"] as? String
        else {
            return nil
        }
        
        return User(id: doc.documentID, name: name, imageURL: imageURL)
    }
}
