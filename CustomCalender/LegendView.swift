//
//  LegendView.swift
//  CustomCalender
//
//  Created by Adit Hasan on 2/25/25.
//

import SwiftUI

struct LegendView: View {
    
    let items: [(color: Color, label: String)] = [
        (Color(hex: "0D2240"), "Solid"),
        (Color(hex: "2E593E"), "Organic"),
        (Color(hex: "49A2E4"), "Recycle"),
        (Color(hex: "6B4F27"), "Yard"),
        (Color(hex: "DA9D41"), "Bulk"),
        (Color(hex: "D92F3A"), "Holiday")
    ]
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 15) {
            GridRow{
                LegendItem(color: items[0].color, label: items[0].label)
                LegendItem(color: items[1].color, label: items[1].label)
                LegendItem(color: items[2].color, label: items[2].label)
                LegendItem(color: items[3].color, label: items[3].label)
            }
            GridRow {
                LegendItem(color: items[3].color, label: items[3].label)
                LegendItem(color: items[4].color, label: items[4].label)
                LegendItem(color: items[5].color, label: items[5].label, isCircle: true)
            }
        }
        .padding(.top)
    }
}

struct LegendItem: View {
    let color: Color
    let label: String
    var isCircle: Bool = false
    
    var body: some View {
        HStack {
            if isCircle {
                Circle()
                    .fill(color)
                    .frame(width: 12, height: 12)
            } else {
                Capsule()
                    .fill(color)
                    .frame(width: 30, height: 8)
            }
            Text(label)
                .font(.custom("OpenSans-Regular", size: 12))
                .foregroundColor(isCircle ? color : .black)
        }
    }
}
