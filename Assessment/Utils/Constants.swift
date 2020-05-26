//
//  Constants.swift
//  Assessment
//
//  Created by Heema Boss on 5/26/20.
//  Copyright © 2020 Ibraheem. All rights reserved.
//

import UIKit

func getHeaders() -> [String : String]{
    var headers = [String : String]()
    headers[ApiHeaderKey.contentType.rawValue] = "application/json"
    return headers
}

struct TableCellHeight {
    static let sritcleTableCell: CGFloat = 110.0
}
