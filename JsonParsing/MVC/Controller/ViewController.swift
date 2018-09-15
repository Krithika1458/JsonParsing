//
//  ViewController.swift
//  JsonParsing
//
//  Created by Student 09 on 15/09/18.
//  Copyright © 2018 felix. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    let strUrl = "https://jsonplaceholder.typicode.com/posts"
    var arrList:Array<Dictionary<String,Any>?>? = nil
    @IBOutlet weak var tablViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        callPostAPI()

    }

    private func callPostAPI(){
    let url = URL.init(string: strUrl)

    //Optional binding
    if let _ = url{
        let req = URLRequest.init(url: url!)
        let session = URLSession.shared

        let dataTask = session.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                print(error!)
                return
            }
            if let value = data{
                do{
                    self.arrList = try JSONSerialization.jsonObject(with: value, options: .allowFragments) as?
                    Array<Dictionary<String,Any>>
                    print(self.arrList!)
                    if let _ = self.arrList,self.arrList!.count > 0
                    {
                        self.tablViewOutlet.dataSource = self
                        self.tablViewOutlet.delegate = self
                        self.tablViewOutlet.reloadData()
                    }

                }
                catch let err{
                    print(err.localizedDescription)

                }
            }
        }
        dataTask.resume()
    }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = arrList{
            return (arrList?.count)!
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablViewOutlet.dequeueReusableCell(withIdentifier: "PostCell") as! PostTableViewCell

        if let _ = arrList{
            let dict = arrList![indexPath.row]
            if let _ = dict {
                cell.lblTitle.text = dict!["title"] as? String
                let userid = dict!["userId"] as! Int
                cell.lblUserId.text = String(format: "UserId: %d",userid)
                cell.lblBody.text = dict!["body"]as? String
            }
        }
        return cell

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

