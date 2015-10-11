//
//  ArticlesViewController.swift
//  Xploration Reader
//
//  Created by Andrea Cerra on 29/09/15.
//  Copyright © 2015 Andrea Cerra. All rights reserved.
//

import UIKit
import SwiftHTTP

class ArticlesViewController: UIViewController {

    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var rocketImage: UIImageView!
    
    var tableViewData = [Articles]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*let test = Articles(image: "",
                            title: "Analogue Transformational Acoustic\": An alternative theoretical ...",
                            date: "22/01/2015",
                            tags: ["appropriations", "hearings", "(nasa)", "orbit", "dynamics", "spacecraft", "satellite", "launching","explosions", "robot","satellite", "launching","explosions", "robot"],
                            text: "speech recognition, EMG activation and motion capture and gesture recognition.  ... providing a literature review on BMI, in the identification of the most ... This  aspect is ... electromagnetic radiation, difficulty to place and position, varying.")
        
        tableViewData.append(test)
        
        let test2 = Articles(image: "",
                            title: "Analogue Transformational Acoustic\": An alternative theoretical ...",
                            date: "22/01/2015",
            tags: ["appropriations", "hearings", "(nasa)", "orbit", "dynamics", "spacecraft", "satellite"],
            text: "Using NASA's Chandra X-ray Observatory, astronomers have studied one particular explosion that may provide clues to the dynamics of other, much larger stellar eruptions.")
        
        tableViewData.append(test2)*/
        
        // For dynamic cell height
        articlesTableView.rowHeight = UITableViewAutomaticDimension
        articlesTableView.estimatedRowHeight = 150
        
        // if no articles hidden table for show download button
        if(tableViewData.count == 0){
            articlesTableView.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "ArticlesTableViewCell"
        
        var cell: ArticleTableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? ArticleTableViewCell
        
        if cell == nil {
            tableView.registerNib(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ArticleTableViewCell
        }
        
        let article = tableViewData[indexPath.row]
        
        // cell.articleImage = UIImageView()
        cell.articleTitle.text = article.title
        cell.articleSubTitle.text = article.date
        cell.articleText.text = article.text
        
        cell.tagView.resetView()
        cell.tagViewHeightConstraint.constant = cell.tagView.setTags(article.tags)
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        return cell;

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        articlesTableView.reloadData()
    }
    
    // MARK: - Action

    @IBAction func downloadArticles(sender: AnyObject) {
        
        rocketImage.hidden = true
        downloadButton.hidden = true
        spinner.startAnimating()
        
        do {
            let opt = try HTTP.GET("http://hypermedia.projectchronos.eu/articles/v04/")
            opt.start { response in
                
                if let err = response.error {
                    
                    // print("error: \(err.localizedDescription)")
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        // update some UI
                        let alertController = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .Alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                        alertController.addAction(defaultAction)
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                        self.rocketImage.hidden = false
                        self.downloadButton.hidden = false
                        self.spinner.stopAnimating()
                    }
        
                }
                
                print("opt finished: \(response.description)")
                //print("data is: \(response.data)") access the response of the data with response.data
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    // update some UI
                    self.spinner.stopAnimating()
                    self.articlesTableView.hidden = false
                    
                    self.pasingDataAndShowOnTable(response.data)
                }
                
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
    
    func pasingDataAndShowOnTable(jsonData: NSData){
        
        do {
            if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                if let articles = json["articles"] as? NSArray {
                    for article in articles {
                        
                        let art = Articles(json: article as! NSDictionary)
                        tableViewData.append(art)
                    }
                }
            }
            
            articlesTableView.reloadData()
            
        } catch let error {
            // Something else happened.
            // Insert your domain, code, etc. when constructing the error.
            // let error: NSError = NSError(domain: "<Your domain>", code: 1, userInfo: nil)
            
            print("got an error creating the request: \(error)")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
