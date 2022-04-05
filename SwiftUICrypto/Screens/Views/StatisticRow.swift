//
//  StatisticRow.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 05..
//

import SwiftUI

struct StatisticRow: View {
    var stats: [Statistic]
    @Binding var showPortfolio: Bool
    var body: some View {
        HStack {
            ForEach(stats) { stat in
                StatisticCell(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

struct StatisticRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticRow(stats: TestData.stats, showPortfolio: .constant(false))
            
            StatisticRow(stats: TestData.stats, showPortfolio: .constant(true))
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
