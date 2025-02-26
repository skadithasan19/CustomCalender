//
//  CalendarDayView.swift
//  CustomCalender
//
//  Created by Adit Hasan on 2/26/25.
//

import SwiftUI

struct CalendarDayView: View {
    let date: Date
    @Binding var selectedDate: Date?
    let eventColors: [Date: [Color]]
    let isPastDate: Bool
    let calendar = Calendar.current
    
    var body: some View {
        
        if let colors = eventColors[date] {
            VStack(spacing: 0) {
                Text(dayNumber())
                    .font(.system(size: 16))
                    .frame(width: 30, height: 30)
                    .background(selectedDate == date ? Color.blue.opacity(0.3) : Color.clear)
                    .clipShape(Circle())
                    .onTapGesture {
                        if !isPastDate {
                            selectedDate = date
                        }
                    }
                
                    ForEach(colors, id: \..self) { color in
                        Capsule()
                            .fill(color) // Change color as needed
                            .frame(width: 30, height: 8) // Adjust size
                            //.shadow(radius: 6) // Optional shadow
                    }
            }
            .padding(5)
            //.background(Color(hex: "#D8E1E9"))
            .cornerRadius(10)
        } else {
            VStack {
                Text(dayNumber())
                    .font(.system(size: 16))
                    .frame(width: 30, height: 30)
                    //.background(selectedDate == date ? Color.blue.opacity(0.3) : Color.clear)
                    .foregroundColor(isPastDate ? Color.gray : Color.primary)
                    .clipShape(Rectangle())
                    .onTapGesture {
                        if !isPastDate {
                            selectedDate = date
                        }
                    }
            }
            .padding(5)
            .background(selectedDate == date ? Color(hex: "#D8E1E9") : Color.clear)
            .cornerRadius(10)
        }
    }
    
    func dayNumber() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
}
