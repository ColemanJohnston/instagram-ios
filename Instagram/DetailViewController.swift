//
//  DetailViewController.swift
//  Instagram
//
//  Created by Coleman Johnston on 2/27/18.
//  Copyright © 2018 Coleman Johnston. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    
    var instagramPost: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.captionLabel.text = instagramPost["caption"] as? String
        self.postImageView.file = instagramPost["media"] as? PFFile
        let author = instagramPost["author"] as? PFUser
        self.authorLabel.text = author?.username
        
        //format date
        let formatter = DateFormatter()
        // Configure the input format to parse the date string
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        // Configure output format
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        // Convert Date to String
        let createdAtString = formatter.string(from: instagramPost.createdAt!)
        
        self.timestampLabel.text = createdAtString
        self.postImageView.loadInBackground()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
