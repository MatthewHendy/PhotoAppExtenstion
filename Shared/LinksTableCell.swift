//
//  LinksTableCell.swift
//  SamplePhotosApp iOS
//
//  Created by macbook on 5/30/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

class LinksTableCell: UITableViewCell, UITextViewDelegate {
    
    var titleString:String = ""
    var urlString:String = ""
    
    @IBOutlet weak var linkButton: UIButton!
    
    override func prepareForReuse() {
        
    }
    
    public func configureWith(title: String, url: String) {
        titleString = title
        urlString = url
        
        linkButton.setTitle("Alpha Beta Gamme Delta Theta Eta Sheta Capsilon Yolo Tommy Bahama Tau Pho Rae Do La So Cholo Swaggy P JaiWolf TechnoFreak Drop Kid Cudi Alpha Beta Gamme Delta Theta Eta Sheta Capsilon Yolo Tommy Bahama Tau Pho Rae Do La So Cholo Swaggy P JaiWolf TechnoFreak Drop Kid Cudi Alpha Beta Gamme Delta Theta Eta Sheta Capsilon Yolo Tommy Bahama Tau Pho Rae Do La So Cholo Swaggy P JaiWolf TechnoFreak Drop Kid Cudi", for: UIControl.State.normal)
        //linkButton.titleLabel?.adjustsFontSizeToFitWidth = true
        linkButton.titleLabel?.numberOfLines = 0
        linkButton.sizeToFit()
        
    }
    
    @IBAction func linkButtonPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string:urlString)!, options: [:]) { (bool) in
            //do code
        }
    }
    
}