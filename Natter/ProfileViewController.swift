import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var logoutButton: UIButton!
    @IBOutlet var chooseAvatarButton: UIButton!
    
    var posts: [Post] = []
    var userId: String = Auth.auth().currentUser?.uid ?? ""
    var listener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (userId == Auth.auth().currentUser?.uid) {
            logoutButton.isHidden = false
            chooseAvatarButton.isHidden = false
        }
        
        loadUser()
        loadPosts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        listener?.remove()
    }
    
    func loadUser() {
        Firestore.firestore().collection("users").document(userId).getDocument { (snapshot, error) in
            guard let doc = snapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let user = User.from(doc: doc) else { return }
            self.usernameLabel.text = user.name
        }
        downloadUserImage(userId: userId) { (image) in
            if let image = image {
                self.avatarImageView.image = image
            }
        }
    }
    
    func loadPosts() {
        let query = Firestore.firestore().collection("posts").whereField("userId", isEqualTo: userId).order(by: "timestamp", descending: true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell
        let post = posts[indexPath.row]
        cell?.set(post: post)
        return cell ?? UITableViewCell()
    }
    
    @IBAction func logout() {
        try? Auth.auth().signOut()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func chooseAvatar() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            present(picker, animated: true)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        self.avatarImageView.image = image
        uploadUserImage(userId: userId, image: image) { (error) in
            if let error = error {
                print("Error: \(error)")
            }
            picker.dismiss(animated: true)
        }
    }
}
