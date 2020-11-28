import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.text = ""
        usernameField.becomeFirstResponder()
    }
    
    @IBAction func submitPressed() {
        guard let username = usernameField.text, let email = emailField.text, let password = passwordField.text else {
            errorLabel.text = "Did you miss something?"
            return
        }
        
        errorLabel.text = ""
        activityIndicator.startAnimating()
        
        // TODO: create user in Firebase Authentication
            // TODO: update user profile (displayName)
            // TODO: write user into users collection in Firestore
    }

}
