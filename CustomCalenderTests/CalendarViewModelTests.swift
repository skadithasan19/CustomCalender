//
//  CalendarViewModelTests.swift
//  CustomCalenderTests
//
//  Created by Adit Hasan on 3/3/25.
//

import XCTest
import SwiftUI
@testable import CustomCalender

final class CalendarViewModelTests: XCTestCase {
    
    var viewModel: CalendarViewModel!
    
    override func setUp() {
        super.setUp()
        let today = Date()
        let availableDates = [today, Calendar.current.date(byAdding: .day, value: 1, to: today)!]
        let eventPills: [Date: [LegendType]] = [:]
        
        viewModel = CalendarViewModel(
            currentMonth: today,
            availableDatesForSelection: availableDates,
            enableDateSelection: true,
            eventPills: eventPills
        ) { _ in }
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialization() {
        XCTAssertNotNil(viewModel, "ViewModel should be initialized")
        XCTAssertEqual(viewModel.availableDatesForSelection.count, 2, "Available dates count should match")
        XCTAssertTrue(viewModel.enableDateSelection, "EnableDateSelection should be true")
    }
    
    func testGenerateCalendarDays() {
        let days = viewModel.generateCalendarDays()
        XCTAssertGreaterThan(days.count, 0, "Generated days should not be empty")
        XCTAssertEqual(days.filter { $0 != nil }.count, Calendar.current.range(of: .day, in: .month, for: viewModel.currentMonth)!.count, "Should generate correct number of days")
    }
    
    func testPreviousMonth() {
        let originalMonth = viewModel.currentMonth
        viewModel.previousMonth()
        
        let expectedMonth = Calendar.current.date(byAdding: .month, value: -1, to: originalMonth)!
        XCTAssertEqual(viewModel.currentMonth, expectedMonth, "Previous month should be correctly set")
    }
    
    func testNextMonth() {
        let originalMonth = viewModel.currentMonth
        viewModel.nextMonth()
        
        let expectedMonth = Calendar.current.date(byAdding: .month, value: 1, to: originalMonth)!
        XCTAssertEqual(viewModel.currentMonth, expectedMonth, "Next month should be correctly set")
    }
    
    func testIsFirstMonth() {
        let today = Date()
        viewModel.currentMonth = today
        XCTAssertTrue(viewModel.isFirstMonth(), "Should return true if the current month is the same as today’s month")
        
        viewModel.previousMonth()
        XCTAssertFalse(viewModel.isFirstMonth(), "Should return false if the current month is earlier than today’s month")
    }
    
    func testIsPastDate() {
        let pastDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let futureDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        
        XCTAssertTrue(viewModel.isPastDate(pastDate), "Past date should return true")
        XCTAssertFalse(viewModel.isPastDate(futureDate), "Future date should return false")
    }
}
