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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var arrList:Array<Dictionary<String,Any>?>? = nil
    @IBOutlet weak var tablViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //activityIndicator.startAnimating()
        //self.perform(#selector(callPostAPI), with: nil, afterDelay: 10)
        self.title = "JSON Parsing"
        callPostAPI()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- Post List API
    private func callPostAPI(){
    let url = URL.init(string: strUrl)

    //Optional binding
    guard let _ = url else {
        return
    }
    activityIndicator.startAnimating()
    if let _ = url{
        let req = URLRequest.init(url: url!)
        let session = URLSession.shared

        let dataTask = session.dataTask(with: req) { (data, response, error) in
            DispatchQueue.main.async {
                //UI
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }

            if let _ = error {
                DispatchQueue.main.async {
                    self.alert(msg: ("No Internet available"))
                }
                return
            }
            if let value = data{
                do{
                    self.arrList = try JSONSerialization.jsonObject(with: value, options: .allowFragments) as?
                    Array<Dictionary<String,Any>>
                    print(self.arrList!)
                    if let _ = self.arrList,self.arrList!.count > 0
                    {
                        DispatchQueue.main.async {
                            //UI
                            self.tablViewOutlet.dataSource = self
                            self.tablViewOutlet.delegate = self
                            self.tablViewOutlet.reloadData()
                        }

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

    //MARK:-
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
                let userid = dict!["id"] as! Int

                cell.lblUserId.text = String(format: "id: %d",userid)
                cell.lblBody.text = dict!["body"]as? String
            }
        }
        return cell

    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let newVC = story.instantiateViewController(withIdentifier: "NewViewController") as! NewViewController
        if let value = arrList{
            newVC.dict = value[indexPath.row]
        }
        else{
            newVC.dict = [:]
        }
        self.navigationController?.pushViewController(newVC, animated: true)
    }

    //MARK:- AlertViewController

    private func alert(msg:String)
    {
        let alert = UIAlertController.init(title: "Error", message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "OK", style: .cancel) { (_) in
            print("Button Clicked")
        }
        let retryAction = UIAlertAction.init(title: "Retry", style: .destructive) { (_) in
            print("Retry Clicked")
            self.callPostAPI()

                }
        alert.addAction(cancelAction)
        alert.addAction(retryAction)
        self.present(alert, animated: true) {
        }
    }


}

