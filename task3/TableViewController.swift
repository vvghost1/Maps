//
//  TableViewController.swift
//  task3
//
//  Created by Yura Vorontsov on 21.08.15.
//  Copyright (c) 2015 Yura Vorontsov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController
{

    var dataModel = DataModel()
    override func viewDidLoad()
    {
        super.viewDidLoad()

        dataModel.downloadData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refresh", name: "dataReady", object: nil)
    }
    
    func refresh()
    {
        tableView.reloadData()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataModel.data.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("defaultCell", forIndexPath: indexPath) as! TableViewCell

        cell.labelOutlet.text = dataModel.data[indexPath.row].name
        cell.localId = dataModel.data[indexPath.row].localId
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let mapVC = segue.destinationViewController as! MapViewController
        let cell = sender!.superview?!.superview as! TableViewCell
        let id = cell.localId
        let localData = dataModel.data[id]
        mapVC.title = localData.name
        mapVC.data = localData
    }
}
