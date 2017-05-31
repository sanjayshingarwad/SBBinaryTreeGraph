//
//   SBNode.swift
//  TreeGraph
//
//  Created by Sanjay Shingarwad on 5/17/17.
//  Copyright © 2017 SanjayShingarwad. All rights reserved.
//

import UIKit

class  SBNode {
    var id:String
    var name: String
    weak var parent:  SBNode? 
    var children: Array< SBNode> = [] 
    
    
    init(id:String, name: String = "") {
        self.id = id
        self.name = name 
    }
    
    // MARK: Public methods
    func addChild(_ child:  SBNode) {
        child.parent = self 
        self.children.append(child) 
    }
    
    func addChildren(_ children: Array< SBNode>) {
        for child in children {
            self.addChild(child)
        }
    }
    
    func removeChild(_ child:  SBNode) {
        guard let index = self.children.index(of: child) else {
            return 
        }
        self.children.remove(at: index) 
    }
    
    func numberOfLevels() -> Int {
        var levels: Int = 1 
        if self.children.count == 0 {
            return levels 
        }
        
        for child in self.children {
            levels = max(levels, child.numberOfLevels()) 
        }
        
        return levels+1 
    }
    
    func numberOfChildren() -> Int {
        return self.children.count 
    }
    
    func neededSize() -> CGSize {
        var size =  SBNodeView.nodeSize 
        
        if self.children.count == 0 {
            return size 
        }
        size.width = 0 
        
        for child in self.children {
            size +>= child.neededSize() 
            if (self.children.last != child) {
                size +>=  SBNodeView.separatorSize 
            }
        }
        
        size +^=  SBNodeView.separatorSize
        size +^=  SBNodeView.nodeSize
        return size
    }
    
}

extension  SBNode: Equatable {}
func == (lhs:  SBNode, rhs:  SBNode) -> Bool {
    return lhs === rhs 
}
