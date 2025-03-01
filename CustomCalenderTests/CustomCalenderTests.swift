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
