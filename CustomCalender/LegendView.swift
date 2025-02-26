//
//  LegendView.swift
//  CustomCalender
//
//  Created by Adit Hasan on 2/25/25.
//

import SwiftUI

// Define an Enum for Legend Types
enum LegendType: CaseIterable {
    case solid, organic, recycle, yard, bulk, holiday

    var color: Color {
        switch self {
        case .solid: return Color(hex: "0D2240")
        case .organic: return Color(hex: "2E593E")
        case .recycle: return Color(hex: "49A2E4")
        case .yard: return Color(hex: "6B4F27")
        case .bulk: return Color(hex: "DA9D41")
        case .holiday: return Color(hex: "D92F3A")
        }
    }

    var label: String {
        switch self {
        case .solid: return "Solid"
        case .organic: return "Organic"
        case .recycle: return "Recycle"
        case .yard: return "Yard"
        case .bulk: return "Bulk"
        case .holiday: return "Holiday"
        }
    }

    var isCircle: Bool {
        return self == .holiday  // Only Holiday is circular
    }
}

// SwiftUI View for the Legend
struct LegendView: View {
    let legendItems = LegendType.allCases

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 15) {
            GridRow {
                ForEach(legendItems.prefix(4), id: \.self) { item in
                    LegendItem(color: item.color, label: item.label)
                }
            }
            GridRow {
                LegendItem(color: legendItems[3].color, label: legendItems[3].label)
                LegendItem(color: legendItems[4].color, label: legendItems[4].label)
                LegendItem(color: legendItems[5].color, label: legendItems[5].label, isCircle: legendItems[5].isCircle)
            }
        }
        .padding(.top)
    }
}

// Legend Item View
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
                .font(.caption)
            Spacer()
        }
    }
}

