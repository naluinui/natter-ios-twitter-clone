import Foundation
import FirebaseFirestore

struct Post: Codable {
    let caption: String
    let timestamp: Date
    let ownerName: String
    
    enum CodingKeys: String, CodingKey {
        case caption = "text"
        case timestamp
        case ownerName
    }
    
    var timeString: String {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .short
        dateformatter.timeStyle = .short
        return dateformatter.string(from: timestamp)
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
        
        return Post(caption: caption, timestamp: timestamp.dateValue(), ownerName: username)
    }
}
