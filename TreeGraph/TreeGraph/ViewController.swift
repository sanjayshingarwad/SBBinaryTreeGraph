//
//  ViewController.swift
//  TreeGraph
//
//  Created by Sanjay Shingarwad on 5/17/17.
//  Copyright © 2017 SanjayShingarwad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var  SBGraphScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //read and drwa tree
        if let jsonDict =  self.readJson() {
            let rootNode =  self.createNode(nodeJson: jsonDict)
            let rootView = SBNodeView.initFromXib(with: rootNode)
            rootView.drawChildrenNodes()
            
             SBGraphScrollView.contentSize = rootView.frame.size
             SBGraphScrollView.addSubview(rootView)
            rootView.frame.origin.y = 0
            rootView.frame.origin.x = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createNode(nodeJson:Dictionary<String,Any>) -> SBNode {
        let nodeId = nodeJson["id"] as! NSNumber
        let nodeName = nodeJson["name"]
        let root = SBNode.init(id:nodeId.stringValue, name: nodeName as! String)
        //childs
        if let childs  = nodeJson["child"] {
            for  child in childs as! Array<Dictionary<String, Any>> {
                let childNode =  self.createNode(nodeJson: child )
                root.addChild(childNode)
            }
        }
        return root
    }

    private func readJson() -> Dictionary<String,Any>? {
        if let path = Bundle.main.path(forResource: "SBJson", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                do{
                    let json =  try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    // JSONObjectWithData returns AnyObject so the first thing to do is to downcast to dictionary type
                    let jsonDictionary =  json as! Dictionary<String,Any>
                    return jsonDictionary["Result"] as? Dictionary<String,Any>
                }catch let error{
                    print(error.localizedDescription)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        return nil
    }

}

