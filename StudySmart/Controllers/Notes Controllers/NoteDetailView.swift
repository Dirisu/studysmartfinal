//
//  NoteDetailView.swift
//  StudySmart
//
//  Created by Marvellous Dirisu on 15/07/2022.
//

import UIKit
import CoreData

class NoteDetailView: UIViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTV: UITextView!
    @IBOutlet weak var quoteTV: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selectedNote : Note? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTF.delegate = self
        descTV.delegate = self
        view.bringSubviewToFront(activityIndicator)
        
        getQuote()
        
        // editable note
        if (selectedNote != nil) {
            titleTF.text = selectedNote?.title
            descTV.text = selectedNote?.desc
        }
            
    }
    
    
    
    
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        // create a new note
        if (selectedNote == nil) {
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
            
            let newNote = Note(entity: entity!, insertInto: context)
            
            newNote.id = noteList.count as NSNumber
            newNote.title = titleTF.text
            newNote.desc = descTV.text
            
            do {
                try context.save()
                noteList.append(newNote)
                navigationController?.popViewController(animated: true)
                
            } catch  {
                print("error saving context")
            }
        } else {
            // editing note
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            
            do {
                let results : NSArray = try context.fetch(request) as NSArray
                for result in results {
                    
                    // cast in result to note
                    let note = result as! Note
                    if (note == selectedNote) {
                        note.title = titleTF.text
                        note.desc = descTV.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            } catch  {
                
                print("error fetching request")
            }
        }
        
        
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        do {
            let results : NSArray = try context.fetch(request) as NSArray
            for result in results {
                
                // cast in result to note
                let note = result as! Note
                if (note == selectedNote) {
                    note.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        } catch  {
            
            print("error fetching request")
        }
    }
    
    func getQuote() {
        self.activityIndicator.startAnimating()
        ZenQuotesClient.getRandomQuotes { quote, error in
            
            if let error = error {
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    
                    let alertVC = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    self.present(alertVC, animated: true)
                }
            }
            
            if error == nil {
                self.quoteTV.text = quote?.quote
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
}

extension NoteDetailView : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

extension NoteDetailView : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
                textView.resignFirstResponder()
                return false
            }
            return true
    }
}
