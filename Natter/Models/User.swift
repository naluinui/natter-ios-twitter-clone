import Foundation
import FirebaseFirestore

struct User: Codable {
    let id: String
    let name: String

    public static func from(doc: DocumentSnapshot) -> User? {
        guard let data = doc.data(),
            let name = data["name"] as? String
        else {
            return nil
        }
        
        return User(id: doc.documentID, name: name)
    }
}
