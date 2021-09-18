//
//  HomeTVC.swift
//  WereWolfram
//
//  Created by QUANG on 7/14/18.
//  Copyright © 2018 QUANG. All rights reserved.
//

import UIKit
import TagListView
import SDWebImage
import ChameleonFramework
import TBEmptyDataSet

class HomeTVC: UITableViewController, UITextFieldDelegate, TBEmptyDataSetDelegate, TBEmptyDataSetDataSource {
    
    //MARK: Outlets
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var btnAskOutlet: UIButton!
    
    //MARK: Actions
    @IBAction func btnAsk(_ sender: UIButton) {
        
        tfInput.resignFirstResponder()
        
        if !(tfInput.text?.isEmpty)! {
            
            getDataWith(search: tfInput.text!) { (data) in
                self.pods = data
                self.reloadOnceManager = [Bool](repeating: false, count: data.count)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //Variables
    var pods = [Pod]()
    var reloadOnceManager = [Bool]()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.emptyDataSetDataSource = self
        tableView.emptyDataSetDelegate = self
        
        
        //Update button UI
        
        btnAskOutlet.layer.masksToBounds = false
        btnAskOutlet.layer.cornerRadius = 10.0
        btnAskOutlet.backgroundColor = RandomFlatColor()
        btnAskOutlet.tintColor = ContrastColorOf(btnAskOutlet.backgroundColor!, returnFlat: true)
        
        tableView.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.frame.size.height), colors: [RandomFlatColorWithShade(UIShadeStyle.dark), RandomFlatColorWithShade(UIShadeStyle.dark), RandomFlatColorWithShade(UIShadeStyle.dark)])
        
        
        getDataWith(search: "Population of France") { (data) in
            self.pods = data
            self.reloadOnceManager = [Bool](repeating: false, count: data.count)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func imageForEmptyDataSet(in scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "empty")
    }
    


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pods.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pod = pods[indexPath.row]
        
        print(pod.plainText)
        
        if pod.plainText.range(of: "|") != nil {
            //Has |
            let cell = tableView.dequeueReusableCell(withIdentifier: "PodTextsOnlyCell", for: indexPath) as! PodTextsOnlyCell
            
            cell.lblTitle.text = pod.title
            cell.contents = pod.plainText.components(separatedBy: " | ")
            
            return cell
        }
        else if pod.plainText != "" {
            //Just plain text
            let cell = tableView.dequeueReusableCell(withIdentifier: "PodTextOnlyCell", for: indexPath) as! PodTextOnlyCell
            
            cell.lblTitle.text = pod.title
            cell.lblContent.text = pod.plainText
            cell.lblContent.sizeToFit()
            
            return cell
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PodCell", for: indexPath) as! PodCell
            
            
            cell.lblTitle.text = pod.title
            cell.graphImage.sd_setImage(with: pod.imageLink, completed: { (image, error, cacheType, imageURL) in
                if (self.reloadOnceManager[indexPath.row] == false) {
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                    self.reloadOnceManager[indexPath.row] = true
                }
            })
            cell.graphImage.frame = CGRect(x: cell.graphImage.frame.origin.x, y: cell.graphImage.frame.origin.y, width: cell.graphImage.frame.width, height: pod.imageHeight)
            
            return cell
        }
    }
    /*
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        let pod = pods[indexPath.row]
        /*
        if pods.count > 0 {
            //Image
            print(UIScreen.main.bounds.width)
            let newWidth = UIScreen.main.bounds.width - CGFloat(40.0)
            let scale = newWidth / pod.imageWidth
            let newHeight = pod.imageHeight * scale
            
            print(234.490350877193)
            print(newHeight + 81.5)
            return newHeight + 81.5
        }*/
        return UITableViewAutomaticDimension
    }*/
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //delegate method
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        tfInput.resignFirstResponder()
        
        if !(tfInput.text?.isEmpty)! {
            
            getDataWith(search: tfInput.text!) { (data) in
                self.pods = data
                self.reloadOnceManager = [Bool](repeating: false, count: data.count)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        return true
    }
}
