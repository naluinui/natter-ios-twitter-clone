import UIKit

class ProfileViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var logoutButton: UIButton!
    @IBOutlet var chooseAvatarButton: UIButton!
    
    var posts: [Post] = []
    var userId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // TODO: show logout & choose avatar button to self
        
        loadUser()
        loadPosts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // TODO: remove listener
    }
    
    func loadUser() {
        // TODO: get user information from Firestore
        // TODO: download user image from Firebase Storage
    }
    
    func loadPosts() {
        // TODO: get user's post from Firestore, you might have to create indexing by following the link in log
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
        // TODO: logout with Firebase Auth
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
        // TODO: upload image to Firebase Storage
    }
}
