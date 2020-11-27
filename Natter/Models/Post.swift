import Foundation
import FirebaseFirestore

struct Post: Codable {
    let caption: String
    let timestamp: Date
    let owner: User
    
    enum CodingKeys: String, CodingKey {
        case caption = "text"
        case timestamp
        case owner = "user"
    }
    
    var timeString: String {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .short
        dateformatter.timeStyle = .short
        return dateformatter.string(from: timestamp)
    }
    
    func toDict() -> [String: Any] {
        return [
            "text": caption,
            "timestamp": Timestamp(date: timestamp),
            "user": [
                "id": owner.id,
                "name": owner.name
            ],
            "userId": owner.id
        ]
    }

    public static func from(doc: DocumentSnapshot) -> Post? {
        print("get post from doc: \(doc.description)")        
        guard let data = doc.data(),
              let user = data["user"] as? [String: Any],
              let username = user["name"] as? String,
              let caption = data["text"] as? String,
              let timestamp = data["timestamp"] as? Timestamp
        else {
            return nil
        }
        
        return Post(caption: caption, timestamp: timestamp.dateValue(), owner: User(id: "abc", name: username))
    }
}
