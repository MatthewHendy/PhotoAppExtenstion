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
    var ArticleArray:Array<Article> = Array()
    
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(UINib.init(nibName: "LinksTableCell", bundle: nil), forCellReuseIdentifier: cellReuseId)
        //table.register(LinksTableCell.self, forCellReuseIdentifier: cellReuseId)
        
        table.delegate = self
        table.dataSource = self
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    func fetchData() {
        let session = URLSession.shared
        let url = URL(string: "https://www.reddit.com/r/Austin/top.json")!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            //do stuff
            
            if error != nil {//if we have an error handle it
                // show some error message
                print("ERROR: \n\(error)\n\n\n")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,//if the statusCode is not a 200 handle it
                (200...299).contains(httpResponse.statusCode) else {
                    //self.handleServerError(response)
                    print("NON 200 RESPONSE\n\(response)\n\n\n")
                    return
            }
            
            guard let mime = response?.mimeType, mime == "application/json" else {//make sure data is sent back in the correct format
                //show alert for wrong mime type
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                //print("JSON: \n\n\n\n \(json)")
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                
                let dataDict = json["data"] as! [String:Any]
                let articlesArray: NSArray = dataDict["children"] as! NSArray
                for articleJson in articlesArray {
                    let castedArticleJson:[String:Any] = articleJson as! [String:Any]
                    let articleDictionary:[String:Any] = castedArticleJson["data"] as! [String : Any]
                    print(articleDictionary)
                    let art:Article = Article.init(json: articleDictionary)!
                    self.ArticleArray.append(art)
                    
                }
                
            }
            
            DispatchQueue.main.async {//must do this on main queue and not on background because it involves redrawing table (graphical update)
                self.table.reloadData()
            }
        }
        
        task.resume()//perform request
    }
    
    struct Article:Decodable {
        let title:String
        let url:String
        
        init?(json: [String:Any]) {
            guard let title = json["title"],
                let url = json["url"] else  {
                    return nil
            }
            self.title = title as! String
            self.url = url as! String
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArticleArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellReuseId)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId) as? LinksTableCell
            
        if(cell == nil) {
            cell = LinksTableCell()
        }
        
        if let art:Article = ArticleArray[indexPath.row] {
            cell?.configureWith(title: art.title, url: art.url)
        }
        
        return cell!
    }

}
