import UIKit

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
        guard let email = emailField.text, let password = passwordField.text else { return }
        
        activityIndicator.startAnimating()
    
        // TODO: sign in
    }

}
