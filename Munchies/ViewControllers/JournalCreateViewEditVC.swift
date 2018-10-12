//
//  JournalCreateViewEditVC.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class JournalCreateViewEditVC: UIViewController {

    
    //MARK: - Outlets
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var journalTextField: UITextView!
    //review
    
    
    //MARK: - Properties
    var journalEntryToEdit: JournalEntry? {
        didSet{
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: - Actions
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
    }
    
    @IBOutlet var starButtons: [UIButton]!
    
    @IBAction func starButtonTapped(_ sender: UIButton) {
        guard let buttonIndex = starButtons.index(of: sender) else { return }
        switch buttonIndex {
        case 0:
            starButtons[0].setTitle("⭑", for: .normal)
        case 1:
            starButtons[0].setTitle("⭑", for: .normal)
            starButtons[1].setTitle("⭑", for: .normal)
        case 2:
            starButtons[0].setTitle("⭑", for: .normal)
            starButtons[1].setTitle("⭑", for: .normal)
            starButtons[2].setTitle("⭑", for: .normal)
        case 3:
            starButtons[0].setTitle("⭑", for: .normal)
            starButtons[1].setTitle("⭑", for: .normal)
            starButtons[2].setTitle("⭑", for: .normal)
            starButtons[3].setTitle("⭑", for: .normal)
        case 4:
            starButtons[0].setTitle("⭑", for: .normal)
            starButtons[1].setTitle("⭑", for: .normal)
            starButtons[2].setTitle("⭑", for: .normal)
            starButtons[3].setTitle("⭑", for: .normal)
            starButtons[4].setTitle("⭑", for: .normal)
        default:
            break
        }
    }
    
    
    func updateViews() {
        guard let entry = journalEntryToEdit else {return}
        self.pictureView.image = entry.picture
        self.dateLabel.text = entry.date.dateAsString()
        self.journalTextField.text = entry.description
        self.titleLabel.text = entry.title
        
        switch entry.review {
        case 0:
            starButtons[0].setTitle("⭑", for: .normal)
        case 1:
            starButtons[0].setTitle("⭑", for: .normal)
            starButtons[1].setTitle("⭑", for: .normal)
        case 2:
            starButtons[0].setTitle("⭑", for: .normal)
            starButtons[1].setTitle("⭑", for: .normal)
            starButtons[2].setTitle("⭑", for: .normal)
        case 3:
            starButtons[0].setTitle("⭑", for: .normal)
            starButtons[1].setTitle("⭑", for: .normal)
            starButtons[2].setTitle("⭑", for: .normal)
            starButtons[3].setTitle("⭑", for: .normal)
        case 4:
            starButtons[0].setTitle("⭑", for: .normal)
            starButtons[1].setTitle("⭑", for: .normal)
            starButtons[2].setTitle("⭑", for: .normal)
            starButtons[3].setTitle("⭑", for: .normal)
            starButtons[4].setTitle("⭑", for: .normal)
        default:
            break
        }
        
    }
    
}
