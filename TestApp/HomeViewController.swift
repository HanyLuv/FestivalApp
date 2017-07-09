//
//  HomViewController.swift
//  TestApp
//
//  Created by 김환희 on 2017. 7. 9..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit

class HomeViewController.swift: UITableViewController {

    @IBOutlet var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.register(UINib.init(nibName: "", bundle: nil), forCellReuseIdentifier: )
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}
