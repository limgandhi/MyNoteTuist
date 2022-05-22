//
//  DetailNoteViewController.swift
//  MyNote
//
//  Created by Hyunyou Lim on 2022/03/28.
//

import UIKit

class DetailNoteViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var contentField: UITextView!
    
    var note: Note?
    var noteTitle: String?
    var noteContent: String?
    var selectedIndex: Int?
    var isNewNote: Bool = true
    let contentPlaceholder: String = "Please Input Content"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.noteTitle = note?.title 
        self.noteContent = note?.content ?? contentPlaceholder
        titleField.text = self.noteTitle
        titleField.font = .boldSystemFont(ofSize: 20)
        contentField.text = self.noteContent
        if contentField.text == contentPlaceholder{
            contentField.textColor = .lightGray
        }
        contentField.delegate = self
    }
    
    //Content Placeholder 추가
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(contentField.text == contentPlaceholder){
            contentField.text = nil
            contentField.textColor = .black
        }
    }
    
    //Content Placeholder 추가
    func textViewDidEndEditing(_ textView: UITextView) {
        if(contentField.text == ""){
            contentField.text = contentPlaceholder
            contentField.textColor = .lightGray
        }
    }
    
    //NoteListViewController로 unwind호출하는 메소드(save button에 이식)
    @IBAction func touchUpSaveButton(_ sender: UIBarButtonItem){
        guard let title = titleField.text, let  content = contentField.text else {
            return
        }
        if( isNewNote ){
            note = Note(title: title, content: content)
        } else {
            note?.title = title
            note?.content = content
        }
        self.performSegue(withIdentifier: "unwindToNoteListViewController", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
