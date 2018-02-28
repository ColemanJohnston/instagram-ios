//
//  FeedViewController.swift
//  Instagram
//
//  Created by Coleman Johnston on 2/26/18.
//  Copyright © 2018 Coleman Johnston. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var posts: [Post] = []
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(didPullToRefresh(_:)), for: UIControlEvents.valueChanged)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.insertSubview(refreshControl!, at: 0)
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchData()
    }
    
    func fetchData() {
        // construct PFQuery
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        // fetch data asynchronously
        
        
        query?.findObjectsInBackground(block: {(posts, error) -> Void in
            if let posts = posts {
                for post in posts{
                    print(post)
                }
                self.posts = posts as! [Post]
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
            self.refreshControl?.endRefreshing()
        })

    }
    
    @IBAction func didLogout(_ sender: Any) {
        print("logging out")
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        cell.instagramPost = posts[indexPath.row]
        
        return cell
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
