//
//  Pie Chart View.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/26.
//

import SwiftUI
import Charts

struct PieChart: View {
    
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
            
            // Pie chart block
            pieChart
            // Legend block
            legend
        }
        .frame(maxWidth: .infinity)
    }
    
    // Main chart view
    var pieChart: some View {
        
        Chart {
            // Loop through each category and draw a pie slice
            ForEach(Array(filtered.enumerated()), id: \.offset) { index, item in
                //let value = values[index]
                let percent = item.value / total
                
                SectorSlice(
                    name: item.name,
                    value: item.value,
                    percent: percent,
                    color: colorSet[index % colorSet.count]
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 260) // Make the chart big enough
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
    
    // Sector Slice
    struct SectorSlice: ChartContent {
        let name: String
        let value: Double
        let percent: Double
        let color: Color

        var body: some ChartContent {
            SectorMark(
                angle: .value("Value", value),
                innerRadius: .ratio(0.35),
                angularInset: 1.5
            )
            .foregroundStyle(color)
            .annotation(position: .overlay, alignment: .center) {
                VStack(spacing: 2) {
                    if percent <= 0.1 {
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
                   
                }
            }
        }
    }
   
    
}
