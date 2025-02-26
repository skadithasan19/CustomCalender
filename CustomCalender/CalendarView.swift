//
//  CalendarView.swift
//  CustomCalender
//
//  Created by Adit Hasan on 2/26/25.
//


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
            // Header: Month Navigation
            HStack {
                Button(action: previousMonth) {
                    Image(systemName: "chevron.left")
                        .padding()
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
            
            // Weekday Labels
            let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                }
            }
            .padding(.bottom, 5)

            // Calendar Grid
            let days = generateCalendarDays()
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(days, id: \.self) { date in
                    if let date = date {
                        CalendarDayView(date: date, selectedDate: $selectedDate, eventColors: eventColors, isPastDate: isPastDate(date))
                    } else {
                        // Empty placeholder for padding days
                        Text("")
                            .frame(maxWidth: .infinity, minHeight: 40)
                    }
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
    
    func generateCalendarDays() -> [Date?] {
        let firstOfMonth = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: currentMonth))!
        let firstWeekday = calendar.component(.weekday, from: firstOfMonth)
        let range = calendar.range(of: .day, in: .month, for: firstOfMonth)!
        
        var days: [Date?] = Array(repeating: nil, count: firstWeekday - 1) // Padding for proper alignment
        
        for day in range {
            if let date = calendar.date(from: DateComponents(year: calendar.component(.year, from: currentMonth),
                                                             month: calendar.component(.month, from: currentMonth),
                                                             day: day)) {
                days.append(date)
            }
        }
        
        return days
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
    
    func isPastDate(_ date: Date) -> Bool {
        return calendar.compare(date, to: Date(), toGranularity: .day) == .orderedAscending
    }
}
 
 
 

 
 
