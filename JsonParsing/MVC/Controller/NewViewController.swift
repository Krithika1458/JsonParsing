//
//  NewViewController.swift
//  JsonParsing
//
//  Created by Student 09 on 16/09/18.
//  Copyright © 2018 felix. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    var dict:Dictionary<String,Any>? = nil

    @IBOutlet weak var lblBody: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblId: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appendData()
        // Do any additional setup after loading the view.
    }

    func appendData(){
        self.lblTitle.text = dict!["title"] as? String
        let id = dict!["id"] as! Int

        self.lblId.text = String(format: "id: %d",id)
        self.lblBody.text = dict!["body"]as? String

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
