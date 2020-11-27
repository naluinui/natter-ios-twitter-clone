import UIKit
import FirebaseAuth
import FirebaseFirestore

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
        
        // Create user in Firebase Authentication
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            guard let authResult = authResult else {
                strongSelf.errorLabel.text = error!.localizedDescription
                print("Error creating user: \(error!)")
                return
            }
            
            let changeRequest = authResult.user.createProfileChangeRequest()
            changeRequest.displayName = username
            changeRequest.commitChanges { (error) in
                if let error = error {
                    print("Error updating profile: \(error)")
                } else {
                    // Complete (we are logged in!)
                    strongSelf.activityIndicator.stopAnimating()
                    strongSelf.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }

}
