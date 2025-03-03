//
//  CustomCalenderTests.swift
//  CustomCalenderTests
//
//  Created by Adit Hasan on 2/25/25.
//

import XCTest
import SwiftUI
@testable import CustomCalender

final class CustomCalenderTests: XCTestCase {
    @State private var selectedDate: Date? = nil
    let calendar = Calendar.current
    
    func testMonthNavigation() {
        let calendarView = CalendarView()
        let initialMonth = calendarView.currentMonth
        
        calendarView.nextMonth()
        XCTAssertEqual(calendar.component(.year, from: calendarView.currentMonth), calendar.component(.year, from: initialMonth), "Next month navigation failed")
        XCTAssertEqual(calendar.component(.month, from: calendarView.currentMonth), calendar.component(.month, from: initialMonth), "Next month navigation failed")
        
        calendarView.previousMonth()
        XCTAssertEqual(calendar.component(.year, from: calendarView.currentMonth), calendar.component(.year, from: initialMonth), "Previous month navigation failed")
        XCTAssertEqual(calendar.component(.month, from: calendarView.currentMonth), calendar.component(.month, from: initialMonth), "Previous month navigation failed")
    }
    
    func testGenerateCalendarDays() {
        let calendarView = CalendarView()
        let days = calendarView.generateCalendarDays()
        XCTAssertFalse(days.isEmpty, "Calendar days should not be empty")
        XCTAssertEqual((days.count - 2), 35, "Generated days count does not match expected grid size (assuming 5 rows max)")
    }
    
    func testIsPastDate() {
        let calendarView = CalendarView()
        let pastDate = calendar.date(byAdding: .day, value: -1, to: Date())!
        let futureDate = calendar.date(byAdding: .day, value: 1, to: Date())!
        
        XCTAssertTrue(calendarView.isPastDate(pastDate), "Past date check failed")
        XCTAssertFalse(calendarView.isPastDate(futureDate), "Future date should not be past")
    }
    
    func testCalendarDayViewSelection() {
        let testDate = Date()
        let view = CalendarDayView(date: testDate, selectedDate: $selectedDate, eventColors: [:], isPastDate: false)
        selectedDate = testDate
        guard let selectedDate else { return }
        XCTAssertEqual(calendar.component(.year, from: selectedDate), calendar.component(.year, from: testDate), "Date selection did not work correctly")
        XCTAssertEqual(calendar.component(.month, from: selectedDate), calendar.component(.month, from: testDate), "Date selection did not work correctly")
        XCTAssertEqual(calendar.component(.day, from: selectedDate), calendar.component(.day, from: testDate), "Date selection did not work correctly")
    }
    
    func testEventColors() {
        let testDate = calendar.date(from: DateComponents(year: 2025, month: 2, day: 22))!
        let eventColors: [Date: [Color]] = [testDate: [.green]]
        guard let selectedDate else { return }
        let view = CalendarDayView(date: testDate, selectedDate: $selectedDate, eventColors: eventColors, isPastDate: false)
        XCTAssertNotNil(view.eventColors[testDate], "Event colors should not be nil for a date with events")
    }
}

/*
class CalendarViewModel: ObservableObject {
    @Published var currentMonth: Date = Date()
    @Published var selectedDate: Date = Date()
    @Published var availableDatesForSelection: [Date] = []
    let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    @Published var calendar = Calendar.current
    @Published var enableDateSelection: Bool = false
    var action: (Date) -> Void
    @Published var eventPills: [Date: [LegendType]]
    init(currentMonth: Date,
         availableDatesForSelection: [Date],
         enableDateSelection: Bool,
         eventPills: [Date: [LegendType]],
         action: @escaping (Date) -> Void) {
        self.currentMonth = currentMonth
        self.availableDatesForSelection = availableDatesForSelection
        self.enableDateSelection = enableDateSelection
        self.action = action
        self.eventPills = eventPills
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
    func isFirstMonth() -> Bool {
        let today = Date()
        return calendar.compare(currentMonth, to: today, toGranularity: .month) == .orderedSame
    }
    func isPastDate(_ date: Date) -> Bool {
        return calendar.compare(date, to: Date(), toGranularity: .day) == .orderedAscending
    }
}
*/
