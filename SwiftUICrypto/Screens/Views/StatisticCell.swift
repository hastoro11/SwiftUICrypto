//
//  StatisticCell.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 05..
//

import SwiftUI

struct StatisticCell: View {
    var stat: Statistic
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.Theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.accentColor)
            HStack(spacing: 2) {
                Image(systemName: "triangle.fill")
                    .font(.system(size: 12))
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                Text(stat.percentageChange?.percentageFormatted ?? "")
                    .font(.caption.weight(.bold))
            }
            .foregroundColor((stat.percentageChange ?? 0) >= 0.0 ? Color.Theme.green : Color.Theme.red)
            .opacity(stat.percentageChange == nil ? 0 : 1)
        }
    }
}

struct StatisticCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticCell(stat: TestData.stat1)
                .padding()
                .preferredColorScheme(.dark)
            StatisticCell(stat: TestData.stat2)
                .padding()
                .preferredColorScheme(.dark)
            StatisticCell(stat: TestData.stat3)
                .padding()
                .preferredColorScheme(.light)
            StatisticCell(stat: TestData.stat4)
                .padding()
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
