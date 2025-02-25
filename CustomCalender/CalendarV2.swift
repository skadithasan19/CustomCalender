//
//  CalendarV2.swift
//  CustomCalender
//
//  Created by Adit Hasan on 2/25/25.
//

import SwiftUI
 
struct CalendarView2: View {
    @State private var currentMonth: Date = Date()
    @State private var selectedDate: Date?
    
    let calendar = Calendar.current
    let eventColors: [Date: [Color]] = [
        Calendar.current.date(from: DateComponents(year: 2023, month: 7, day: 20))!: [.blue],
        Calendar.current.date(from: DateComponents(year: 2023, month: 7, day: 22))!: [.green],
        Calendar.current.date(from: DateComponents(year: 2023, month: 7, day: 23))!: [.orange]
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
                    CalendarDayView2(date: date, selectedDate: $selectedDate, eventColors: eventColors, isPastDate: isPastDate(date))
                }
            }
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

struct CalendarDayView2: View {
    let date: Date
    @Binding var selectedDate: Date?
    let eventColors: [Date: [Color]]
    let isPastDate: Bool
    let calendar = Calendar.current
    
    var body: some View {
        VStack {
            Text(dayNumber())
                .font(.headline)
                .frame(width: 30, height: 30)
                .background(selectedDate == date ? Color.blue.opacity(0.3) : Color.clear)
                .foregroundColor(isPastDate ? Color.gray : Color.primary)
                .clipShape(Circle())
                .onTapGesture {
                    if !isPastDate {
                        selectedDate = date
                    }
                }
            HStack(spacing: 2) {
                if let colors = eventColors[date] {
                    ForEach(colors, id: \..self) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 6, height: 6)
                    }
                }
            }
        }
    }
    
    func dayNumber() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
}

 
