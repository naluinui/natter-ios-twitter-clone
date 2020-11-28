import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tweetButton: UIButton!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // TODO: check if user is logged in
        // TODO: query posts from Firestore
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // TODO: remove snapshot listener
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
        // TODO: open profile with curerent user id
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

