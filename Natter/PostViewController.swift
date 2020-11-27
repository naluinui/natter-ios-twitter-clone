import UIKit
import FirebaseFirestore

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
    
    func textIsValid() -> Bool {
        return textView.text != nil && (textView.text?.count ?? 0) <= maxLength
    }
    
    @IBAction func submit() {
        if (!textIsValid()) { return }
        Firestore.firestore().collection("posts").addDocument(data: [
            "text": textView.text ?? "",
            "timestamp": FieldValue.serverTimestamp(),
            "user": [
                "id": "abc",
                "name": "TheRealTrump"
            ],
            "userId": "abc"
        ]) { (err) in
            if let error = err {
                print("error creating post: \(error)")
            } else {
                print("post successfully!")
                self.navigationController?.popViewController(animated: true)
            }
        }
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
