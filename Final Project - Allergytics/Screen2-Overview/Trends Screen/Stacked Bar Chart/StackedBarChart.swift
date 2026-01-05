//
//  StackedBarChart.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 12/1/25.
//

import SwiftUI
import Charts

struct StackedBarChart: View {
    
    // Category Name
    let names: [String]
    // Count for each category
    let values: [Double]
    let title: String
    
    // Filter out zero value
    var filtered: [(name: String, value: Double)] {
        zip(names, values).filter { $0.1 > 0 }
    }
    
    // Total value used for percentage calculation
    var total: Double {
        filtered.map { $0.value }.reduce(0, +)
    }
    
    // Struct for a bar slice
    struct Slice: Identifiable {
        let id = UUID()
        let name: String
        let percent: Double
        let percentStart: Double
        let percentEnd: Double
        let color: Color
    }
    
    // Pre-calculate values needed for plotting
    var slices: [Slice] {
        var start = 0.0
        var result: [Slice] = []

        for (index, item) in filtered.enumerated() {
            let percent = item.value / total
            let end = start + percent

            result.append(
                Slice(
                    name: item.name,
                    percent: percent,
                    percentStart: start,
                    percentEnd: end,
                    color: colorSet[index % colorSet.count]
                )
            )
            start = end
        }

        return result
    }

    
    // Color set used for the slices
    private let colorSet: [Color] = [
        .yellow, .orange, .purple, .blue, .pink, .green, .red, .gray, .mint
    ]
    // Main body
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            
            // Title
            Text(title)
                .font(.headline)
                .padding(.top, 8)
                .foregroundStyle(.black)
             
            // Bar chart block
            stackedBarChart
            // Legend block
            legend
        }
        .frame(maxWidth: .infinity)
    }
    
    // Main chart view
    var stackedBarChart: some View {
        Chart {
            // Loop through each category and draw a pie slice
            ForEach(slices) { slice in
                BarSlice(
                    name: slice.name,
                    percentStart: slice.percentStart,
                    percentEnd: slice.percentEnd,
                    color: slice.color
                )
            }
        }
        .chartXAxis(.hidden)
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 80) // Make the chart big enough
        .frame(width: UIScreen.main.bounds.width - 40)
        .padding(.horizontal, 16)
    }

    
    // Legend
    var legend: some View {
        VStack(alignment: .leading, spacing: 8) {
                ForEach(Array(filtered.enumerated()), id: \.offset) { index, item in
                    //let value = values[index]
                    let percent = Int(item.value / total * 100)

                    HStack {
                        Circle()
                            .fill(colorSet[index % colorSet.count])
                            .frame(width: 14, height: 14)

                        Text(item.name)
                            .font(.subheadline)
                            .foregroundStyle(.black)

                        Spacer()

                        Text("\(percent)%")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                }
            }
            .padding(.horizontal, 18)
    }
    
    // Bar slice
    struct BarSlice: ChartContent {
        let name: String
        let percentStart: Double
        let percentEnd: Double
        let color: Color

        var body: some ChartContent {
            BarMark(
                xStart: .value("Percent Start", percentStart),
                xEnd: .value("Percent End", percentEnd)
            )
            .foregroundStyle(color)
            .annotation(position: .overlay, alignment: .center) {
                VStack(spacing: 2) {
                    let percent  = percentEnd - percentStart
                    if percent <= 0.15 {
                        Text("\(Int(percent * 100))%")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white)
                            . multilineTextAlignment(.center)
                    } else {
                        Text("\(name)\n\(Int(percent * 100))%")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    /*
                    Text("\(name)\n\(Int((percentEnd - percentStart) * 100))%")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                     */
                }
            }
        }
    }
}
