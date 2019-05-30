//
//  LinksTableVC.swift
//  SamplePhotosApp iOS
//
//  Created by macbook on 5/30/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

open class LinksTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    let cellReuseId = "LinkCell"
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
        
        table.delegate = self
        table.dataSource = self
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        table.reloadData()
        
        
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellReuseId)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId)
            
        if(cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellReuseId)
        }
        
        cell!.textLabel?.text = "sdfsdfsdfsdfdf"
        return cell!
    }
    

}
