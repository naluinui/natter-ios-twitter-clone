import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.text = ""
        emailField.becomeFirstResponder()
    }
    
    @IBAction func submitPressed() {
        activityIndicator.startAnimating()
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                
                if let error = error {
                    
                } else {
                    strongSelf.activityIndicator.stopAnimating()
                    strongSelf.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }

}
