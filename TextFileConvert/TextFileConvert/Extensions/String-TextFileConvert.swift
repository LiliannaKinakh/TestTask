//
//  String-TextFileConvert.swift
//  TextFileConvert
//
//  Created by Lilianna Kinakh on 2/28/19.
//  Copyright © 2019 Lilianna Kinakh. All rights reserved.
//

import Foundation

extension String {
    func condensingWhitespace() -> String {
        return self.components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
}
