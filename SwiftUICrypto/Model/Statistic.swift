//
//  Statistic.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 05..
//

import Foundation
import SwiftUI

struct Statistic: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var value: String
    var percentageChange: Double?
}
