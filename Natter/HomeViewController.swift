import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tweetButton: UIButton!
    var posts: [Post] = []
    let messagesQuery = Firestore.firestore().collection("messages").order(by: "timestamp", descending: true)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Auth.auth().currentUser != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "profile"), style: .plain, target: self, action: #selector(openProfile))
        }
        
        messagesQuery.addSnapshotListener { (snapshot, error) in
            guard let docs = snapshot?.documents else {
                    print("Error fetching document: \(error!)")
                    return
                  }
//                  print("Current data: \(docs)")
            self.posts = docs.compactMap { (docSnapshot) -> Post? in
                return Post.from(doc: docSnapshot)
            }
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
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
    
    @objc func openProfile() {
        performSegue(withIdentifier: "openProfile", sender: nil)
    }
}

