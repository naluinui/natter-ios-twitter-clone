import UIKit

class PostViewController: UIViewController, UITextViewDelegate {
    
    let maxLength = 140
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var submitButton: UIBarButtonItem!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var toolbar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.inputAccessoryView = toolbar
        submitButton.isEnabled = false
    }
    
    @IBAction func submit() {
        // TODO: check if user is logged in
        // TODO: create post object
        // TODO: write new post into Firestore
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let textCount = textView.text.count
        textCountLabel.text = "\(textCount)/\(maxLength)"
        placeholderLabel.isHidden = textCount > 0
        submitButton.isEnabled = textCount > 0
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= maxLength
    }
    
}
