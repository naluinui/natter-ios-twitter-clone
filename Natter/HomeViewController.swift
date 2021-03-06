import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tweetButton: UIButton!
    
    var posts: [Post] = []
    var listener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Auth.auth().currentUser != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "profile"), style: .plain, target: self, action: #selector(openMyProfile))
            tweetButton.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign In", style: .plain, target: self, action: #selector(openLogin))
            tweetButton.isEnabled = false
        }
        
        let query = Firestore.firestore().collection("posts").order(by: "timestamp", descending: true)
        listener = query.addSnapshotListener { (snapshot, error) in
            guard let docs = snapshot?.documents else {
                print("Error fetching document: \(error!)")
                return
            }
            self.posts = docs.compactMap { (docSnapshot) -> Post? in
                return Post.from(doc: docSnapshot)
            }
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        listener?.remove()
    }
    
    func setupView() {
        tweetButton.layer.cornerRadius = tweetButton.frame.width/2
        tweetButton.layer.masksToBounds = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell
        let post = posts[indexPath.row]
        cell?.set(post: post)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = posts[indexPath.row].owner
        openProfile(userId: user.id)
    }
    
    @objc func openMyProfile() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        openProfile(userId: userId)
    }
    
    @objc func openProfile(userId: String) {
        performSegue(withIdentifier: "openProfile", sender: userId)
    }
    
    @objc func openLogin() {
        performSegue(withIdentifier: "login", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openProfile", let profileVC = segue.destination as? ProfileViewController, let userId = sender as? String {
            profileVC.userId = userId
        }
    }
}

