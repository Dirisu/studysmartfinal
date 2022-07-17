//
//  ViewController.swift
//  StudySmart
//
//  Created by Marvellous Dirisu on 15/07/2022.
//

import UIKit
import FirebaseAuth

class OptionView : UIViewController {

    
    @IBOutlet weak var messageIntroLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        messageIntroLabel.text = "Welcome to study smart arena where you can take quiz and use a note together."
    }

    @IBAction func logoutButton(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popViewController(animated: true)
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
}

