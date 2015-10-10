//
//  ArticlesViewController.swift
//  Xploration Reader
//
//  Created by Andrea Cerra on 29/09/15.
//  Copyright © 2015 Andrea Cerra. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {

    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var rocketImage: UIImageView!
    
    var tableViewData = [Articles]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let test = Articles(image: "",
                            title: "Analogue Transformational Acoustic\": An alternative theoretical ...",
                            date: "22/01/2015",
                            tags: ["appropriations", "hearings", "(nasa)", "orbit", "dynamics", "spacecraft", "satellite", "launching","explosions", "robot","satellite", "launching","explosions", "robot"],
                            text: "speech recognition, EMG activation and motion capture and gesture recognition.  ... providing a literature review on BMI, in the identification of the most ... This  aspect is ... electromagnetic radiation, difficulty to place and position, varying.")
        
        //tableViewData.append(test)
        
        let test2 = Articles(image: "",
                            title: "Analogue Transformational Acoustic\": An alternative theoretical ...",
                            date: "22/01/2015",
            tags: ["appropriations", "hearings", "(nasa)", "orbit", "dynamics", "spacecraft", "satellite"],
            text: "Using NASA's Chandra X-ray Observatory, astronomers have studied one particular explosion that may provide clues to the dynamics of other, much larger stellar eruptions.")
        
        //tableViewData.append(test2)
        
        articlesTableView.rowHeight = UITableViewAutomaticDimension
        articlesTableView.estimatedRowHeight = 150
        
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
        
        var cell: ArticlesTableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? ArticlesTableViewCell
        
        if cell == nil {
            tableView.registerNib(UINib(nibName: "ArticlesTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ArticlesTableViewCell
        }
        
        let article = tableViewData[indexPath.row]
        
        cell.articleImage = UIImageView()
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
