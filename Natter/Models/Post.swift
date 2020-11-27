import Foundation
import FirebaseFirestore

struct Post: Codable {
    let caption: String
    let timestamp: Date
    let owner: User
    
    enum CodingKeys: String, CodingKey {
        case caption
        case timestamp
        case owner = "user"
    }
    
    var timeString: String {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .short
        dateformatter.timeStyle = .short
        return dateformatter.string(from: timestamp)
    }

    public static func from(doc: DocumentSnapshot) -> Post? {
        guard let data = doc.data(),
              let user = data["user"] as? [String: Any],
              let userId = user["id"] as? String,
              let username = user["name"] as? String,
              let caption = data["caption"] as? String,
              let timestamp = data["timestamp"] as? Timestamp
        else {
            return nil
        }
        
        return Post(caption: caption, timestamp: timestamp.dateValue(), owner: User(id: userId, name: username))
    }
    
    func toDict() -> [String: Any] {
        return [
            "caption": caption,
            "timestamp": Timestamp(date: timestamp),
            "user": [
                "id": owner.id,
                "name": owner.name
            ],
            "userId": owner.id
        ]
    }
}
