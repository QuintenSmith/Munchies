//
//  InstructionsVC.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/19/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class InstructionsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK: - Outlets
    @IBOutlet weak var instructionsTableView: UITableView!
    
    
    //MARK: - Properties
    var instructionSteps = RecipeFetchController.shared.temporaryInstructionStorage
    
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(instructionsTableView)
        instructionsTableView.dataSource = self
        instructionsTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let firstItem = instructionSteps.first?.steps.count {
        if firstItem >= 1 {
            instructionsTableView.reloadData()
            instructionsTableView.scrollToRow(at: IndexPath(row: firstItem - 1 , section: 0), at: .bottom, animated: true)
        }
    }
    }

    
    //MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let stepsCount = instructionSteps.first?.steps.count else {return 0}
        return stepsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "instructionsCell", for: indexPath)
        if let step = instructionSteps.first?.steps[indexPath.row].step {
        cell.textLabel?.text = "\(indexPath.row + 1). \(step)"
        }
        return cell
    }
    

}
