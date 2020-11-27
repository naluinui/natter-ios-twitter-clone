import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var posts: [Post] = []
    var userId: String = Auth.auth().currentUser?.uid ?? ""
    var listener: ListenerRegistration?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadUser()
        loadPosts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        listener?.remove()
    }
    
    func loadUser() {
        Firestore.firestore().collection("users").document(userId).getDocument { (snapshot, error) in
            guard let doc = snapshot, doc.exists else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let user = User.from(doc: doc) else { return }
            self.usernameLabel.text = user.name
        }
    }
    
    func loadPosts() {
        let query = Firestore.firestore().collection("messages").whereField("userId", isEqualTo: userId).order(by: "timestamp", descending: true)
        listener = query.addSnapshotListener { (snapshot, error) in
            guard let docs = snapshot?.documents else {
                print("Error fetching document: \(error!)")
                return
            }
            self.posts = docs.compactMap { Post.from(doc: $0) }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "PostCell")
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.caption
        cell.detailTextLabel?.text = "— \(post.ownerName) \(post.timeString)"
        return cell
    }
    
    
}
