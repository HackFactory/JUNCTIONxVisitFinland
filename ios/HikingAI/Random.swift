//
//  Random.swift
//  HikingAI
//
//  Created by Yaroslav Spirin on 17/11/2019.
//  Copyright © 2019 Yaroslav Spirin. All rights reserved.
//

import Foundation

extension Array {
    public func random() -> Element? {
        if self.count == 0 {
            return nil
        }
        
        let index = Int(arc4random()) % self.count
        return self[index]
    }
}
