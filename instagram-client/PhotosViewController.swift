//
//  PhotosViewController.swift
//  instagram-client
//
//  Created by Gideon Goodwin on 8/26/15.
//  Copyright © 2015 Gideon Goodwin. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var mediaData: [NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 320
        tableView.dataSource = self
        tableView.delegate = self
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.ggoodwin37.instagramTableViewCell", forIndexPath: indexPath) as! InstagramTableViewCell
//        let cityState = data[indexPath.row].componentsSeparatedByString(", ")
        // TODO: resume here, need to set the real image URL for each row. could get tricky since some entries are actually videos, we might have different
        //       sets of asset resolutions for each row, etc.
        // TODO: also figure out layout for the image in each cell.
        let url = NSURL(string: "https://nadlembehresort.files.wordpress.com/2012/09/mg_2256-c3a5terstc3a4lld.jpg")!
        cell.previewImage.setImageWithURL(url)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let mediaData = self.mediaData {
            print("I have \(mediaData.count) rows")
            return mediaData.count
        }
        print("I have no rows at all")
        return 0
    }

    func loadData() {
        let clientId = "b3f395b259d3483b9e708b58adff634d"
        let url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")!
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            if (error != nil) {
                print(error)
                return
            }
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                if let json = json {
                    self.mediaData = json["data"] as? [NSDictionary]
                    print(self.mediaData)
                } else {
                    print("deserialize error")
                    return
                }
            } catch {
                print("deserialize error")
                return
            }
            self.tableView.reloadData()
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
