//
//  PhotosViewController.swift
//  instagram-client
//
//  Created by Gideon Goodwin on 8/26/15.
//  Copyright © 2015 Gideon Goodwin. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    var mediaData: [NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()

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
//            self.photos = responseDictionary["data"] as! NSArray
//            self.tableView.reloadData()
//            print(self.photos)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
