//
//  RegisterView.swift
//  StudySmart
//
//  Created by Marvellous Dirisu on 15/07/2022.
//

import UIKit
import FirebaseAuth

class RegisterView: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func registerButton(_ sender: UIButton) {
        
        if let email =  emailTF.text, let password = passwordTF.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    let alert = UIAlertController(title: "Registeration error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Next", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                // segue to the welcome screen
                } else {
                    
                    self.navigationController?.popViewController(animated: true)
                    
                }
            }
        }

    }
    
}
