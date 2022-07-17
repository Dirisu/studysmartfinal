//
//  HomeView.swift
//  StudySmart
//
//  Created by Marvellous Dirisu on 15/07/2022.
//

import UIKit
import FirebaseAuth
import CLTypingLabel

class HomeView : UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var logoLabel: CLTypingLabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoLabel.text = "STUDYSMART"
    }

    @IBAction func loginButton(_ sender: UIButton) {
        if let email =  emailTF.text, let password = passwordTF.text {
            activityIndicator.startAnimating()
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                
                if let error = error {
                    self.activityIndicator.stopAnimating()
                    print(error.localizedDescription)
                    let alert = UIAlertController(title: "Login error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Next", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                // segue to the welcome screen
                } else {
                    self.activityIndicator.stopAnimating()
                    self.performSegue(withIdentifier: "loginToHome", sender: self)
                    
                }
            }
                
        }
    }
    
}


