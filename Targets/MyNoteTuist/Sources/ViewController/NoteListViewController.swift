//
//  ViewController.swift
//  MyNote
//
//  Created by Hyunyou Lim on 2022/03/27.
//

import UIKit

class NoteListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let cellIdentifier = "cell"
    @IBOutlet weak var noteTableView: UITableView!
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var editButton: UIBarButtonItem!
    var secureView: UIView!
    
    //Edit 버튼 클릭 메소드
    @IBAction func touchUpEditButton(_ sender: UIBarButtonItem){
        self.noteTableView.setEditing(!noteTableView.isEditing, animated: true)
        self.editButton.title = noteTableView.isEditing ? "Done" : "Edit"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         Do any additional setup after loading the view.
        noteTableView.delegate = self
        noteTableView.dataSource = self
        NoteList.notes.append(Note(title: "Title1", content: "Content"))
        
    }
    
    //table row count 반환 메소드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NoteList.notes.count
    }

    //table cell 지정 메소드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = noteTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let title = NoteList.notes[indexPath.row].title
        cell.textLabel?.text = title
        cell.selectionStyle = .default
        return cell
    }
    
    
    
    //테이블에서 선택한 후 선택한 셀을 풀어주는(deselect) 메소드 / Editing mode 일경우는 선택으로 변경
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(noteTableView.isEditing){
            self.noteTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }else{
            self.noteTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    //Segue prepare 메소드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailController = segue.destination as? DetailNoteViewController else {
            return
        }
        if let index = self.noteTableView.indexPathForSelectedRow?.row{
            detailController.note = NoteList.notes[index]
            detailController.isNewNote = false
            detailController.selectedIndex = index
        }
    }
    
    //Segue 수행여부 체크 메소드
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(noteTableView.isEditing){
            return false
        }else{
            return true
        }
    }
    
    //Editing Style 삭제 기능 추가
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("deleteit!")
            NoteList.notes.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    //재정렬
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let rowToMove = NoteList.notes[sourceIndexPath.row]
//        NoteList.notes.remove(at: sourceIndexPath.row)
//        NoteList.notes.insert(rowToMove, at: destinationIndexPath.row)
//    }
//    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
//        var rowToMove = NoteList.notes[sourceIndexPath.row]
//        NoteList.notes.remove(at: sourceIndexPath.row)
//        NoteList.notes.insert(rowToMove, at: proposedDestinationIndexPath.row)
//    }

    //UnwindSegue(DetailNoteViewController -> NoteListViewController
    @IBAction func unwindToNoteListViewController(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? DetailNoteViewController{
            guard let note = sourceViewController.note else {
                return
            }
            if( sourceViewController.isNewNote ){
                NoteList.notes.insert(note, at: 0)
            } else {
                guard let index = sourceViewController.selectedIndex  else{
                    return
                }
                NoteList.notes[index].title = note.title
                NoteList.notes[index].content = note.content
            }
        }
        // Use data from the view controller which initiated the unwind segue
        
        noteTableView.reloadData()
    }

}
