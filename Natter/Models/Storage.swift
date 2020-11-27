import UIKit
import FirebaseStorage

func uploadUserImage(userId: String, image: UIImage, completion: @escaping (Error?) -> ()) {
    guard let data = image.jpegData(compressionQuality: 0.6) else {
        completion(NSError())
        return
    }
    storageRef(userId: userId).putData(data, metadata: nil) { (metadata, error) in
        completion(error)
    }
}

func downloadUserImage(userId: String, completion: @escaping (UIImage?) -> Void) {
    // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
    storageRef(userId: userId).getData(maxSize: 1 * 1024 * 1024) { data, error in
      if let error = error {
        print("Error: \(error)")
        completion(nil)
      } else {
        let image = UIImage(data: data!)
        completion(image)
      }
    }
}

fileprivate func storageRef(userId: String) -> StorageReference {
    return Storage.storage().reference(withPath: "users/\(userId).jpg")
}
