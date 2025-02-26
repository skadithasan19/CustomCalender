//
//  CustomCalendarV3.swift
//  CustomCalender
//
//  Created by Adit Hasan on 2/26/25.
//

import SwiftUI

struct MonthlyCalendarView: View {
    @State private var currentYear: Int = Calendar.current.component(.year, from: Date())
    @State private var currentMonth: Int = Calendar.current.component(.month, from: Date())

    let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let columns = Array(repeating: GridItem(.flexible(), spacing: 5), count: 7)

    var body: some View {
        VStack {
            // Month & Year Title with Navigation Arrows
            HStack {
                Button(action: { previousMonth() }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .padding()
                }

                Text("\(Calendar.current.monthSymbols[currentMonth - 1]) \(currentYear)")
                    .font(.title)
                    .bold()

                Button(action: { nextMonth() }) {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .padding()
                }
            }
            .padding()

            // Days of the Week Header
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                }
            }
            .padding(.bottom, 5)

            // Calendar Grid
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(generateMonthDates(year: currentYear, month: currentMonth)) { dateValue in
                    if let day = dateValue.day {
                        Text("\(day)")
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(dateValue.isHighlighted ? Color.blue.opacity(0.3) : Color.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    } else {
                        Text("")
                            .frame(maxWidth: .infinity, minHeight: 40)
                    }
                }
            }
            .padding()
        }
    }

    // Function to navigate to the previous month
    private func previousMonth() {
        if currentMonth == 1 {
            currentMonth = 12
            currentYear -= 1
        } else {
            currentMonth -= 1
        }
    }

    // Function to navigate to the next month
    private func nextMonth() {
        if currentMonth == 12 {
            currentMonth = 1
            currentYear += 1
        } else {
            currentMonth += 1
        }
    }
}

// Data Model for Dates
struct DateValue: Identifiable {
    let id = UUID()
    let day: Int?
    let isHighlighted: Bool
}

// Function to generate month’s dates aligned correctly
func generateMonthDates(year: Int, month: Int) -> [DateValue] {
    var dates: [DateValue] = []
    let calendar = Calendar.current
    let components = DateComponents(year: year, month: month)
    
    guard let firstDayOfMonth = calendar.date(from: components),
          let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth) else {
        return []
    }

    let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
    let paddingDays = firstWeekday - 1

    // Add empty slots for days before the first of the month
    for _ in 0..<paddingDays {
        dates.append(DateValue(day: nil, isHighlighted: false))
    }

    // Add actual days of the month
    for day in range {
        let isHighlighted = (month == 7 && day == 20) // Highlight July 20th
        dates.append(DateValue(day: day, isHighlighted: isHighlighted))
    }

    return dates
}
 

struct MonthlyCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyCalendarView()
    }
}
