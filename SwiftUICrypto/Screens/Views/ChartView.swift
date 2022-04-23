//
//  ChartView.swift
//  SwiftUICrypto
//
//  Created by Gabor Sornyei on 2022. 04. 23..
//

import SwiftUI

struct ChartShape: Shape {
    var data: [Double]
    var color: Color
    var maxY: Double {
        data.max() ?? 0
    }
    var minY: Double {
        data.min() ?? 0
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for index in data.indices {
            let xPosition = rect.width / CGFloat(data.count) * CGFloat(index + 1)
            let yPosition = (1-(data[index] - minY) / (maxY - minY)) * rect.height
            if index == 0 {
                path.move(to: CGPoint.init(x: 0, y: yPosition))
            }
            path.addLine(to: CGPoint.init(x: xPosition, y: yPosition))
        }
        return path
    }
}

struct ChartView: View {
    var data: [Double]
    var updatedDate: String
    var showLines: Bool = true
    var showLegend: Bool = true
    var showDates: Bool = true
    var lineWidth: CGFloat = 2
    @State var percentage: Double = 0
    var color: Color {
        data.first ?? 0 < data.last ?? 0 ? Color.Theme.green : Color.Theme.red
    }
    private var maxY: Double {
        data.max() ?? 0
    }
    private var minY: Double {
        data.min() ?? 0
    }
    var body: some View {
        VStack {
            ChartShape(data: data, color: color)
                .trim(from: 0, to: percentage)
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth))
                .padding(4)
                .shadow(color: color, radius: 10, x: 0, y: 10)
                .shadow(color: color.opacity(0.25), radius: 10, x: 0, y: 20)
                .shadow(color: color.opacity(0.125), radius: 10, x: 0, y: 25)
                .shadow(color: color.opacity(0.0625), radius: 10, x: 0, y: 30)
                .background {
                    VStack {
                        Divider()
                        Spacer()
                        Divider()
                        Spacer()
                        Divider()
                    }
                    .padding(.horizontal, 4)
                    .opacity(showLines ? 1 : 0)
                }
                .overlay(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text(maxY.formattedWithAbbreviations())
                        Spacer()
                        Text(((maxY - minY)/2).formattedWithAbbreviations())
                        Spacer()
                        Text(minY.formattedWithAbbreviations())
                    }
                    .opacity(showLegend ? 1 : 0)
                }
            HStack {
                Text(Date.shortFormatted(updatedDate, addedDays: -7))
                Spacer()
                Text(Date.shortFormatted(updatedDate))
            }
            .opacity(showDates ? 1 : 0)
        }
        .font(.caption)
        .foregroundColor(Color.Theme.secondaryText)
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(
            data: TestData.coin(0).sparklineIn7D?.price ?? [],
            updatedDate: TestData.coin(0).lastUpdated ?? "")
            .frame(width: 400, height: 300)
//            .padding()
            .previewLayout(.sizeThatFits)
    }
}
