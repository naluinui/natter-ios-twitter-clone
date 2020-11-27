import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailField.becomeFirstResponder()
    }
    
    @IBAction func submitPressed() {
        activityIndicator.startAnimating()
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                strongSelf.activityIndicator.stopAnimating()
                strongSelf.navigationController?.popToRootViewController(animated: true)
            }
        }
    }

}
