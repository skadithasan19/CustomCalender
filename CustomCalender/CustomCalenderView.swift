//
//  CustomCalenderView.swift
//  CustomCalender
//
//  Created by Adit Hasan on 2/25/25.
//

import SwiftUI

import SwiftUI

struct CalendarView: View {
    @State private var currentMonth: Date = Date()
    @State private var selectedDate: Date?
    
    let calendar = Calendar.current
    let eventColors: [Date: [Color]] = [
        Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 20))!: [.blue],
        Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 22))!: [.green],
        Calendar.current.date(from: DateComponents(year: 2025, month: 2, day: 23))!: [.orange]
    ]
    
    var body: some View {
        VStack {
            HStack {
                Button(action: previousMonth) {
                    Image(systemName: "chevron.left")
                        .padding()
                        .disabled(isFirstMonth())
                }
                Spacer()
                Text(monthYearString())
                    .font(.title2)
                Spacer()
                Button(action: nextMonth) {
                    Image(systemName: "chevron.right")
                        .padding()
                }
            }
            .padding(.horizontal)
            
            let days = generateCalendarDays()
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(days, id: \..self) { date in
                    CalendarDayView(date: date, selectedDate: $selectedDate, eventColors: eventColors, isPastDate: isPastDate(date))
                }
            }
            
            LegendView()
        }
    }
    
    func monthYearString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentMonth)
    }
    
    func generateCalendarDays() -> [Date] {
        let range = calendar.range(of: .day, in: .month, for: currentMonth)!
        return range.compactMap { day -> Date? in
            return calendar.date(from: DateComponents(year: calendar.component(.year, from: currentMonth),
                                                      month: calendar.component(.month, from: currentMonth),
                                                      day: day))
        }
    }
    
    func previousMonth() {
        if let newMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth) {
            currentMonth = newMonth
        }
    }
    
    func nextMonth() {
        if let newMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth) {
            currentMonth = newMonth
        }
    }
    
    func isFirstMonth() -> Bool {
        let today = Date()
        return calendar.compare(currentMonth, to: today, toGranularity: .month) == .orderedSame
    }
    
    func isPastDate(_ date: Date) -> Bool {
        return calendar.compare(date, to: Date(), toGranularity: .day) == .orderedAscending
    }
}

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

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

 

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
