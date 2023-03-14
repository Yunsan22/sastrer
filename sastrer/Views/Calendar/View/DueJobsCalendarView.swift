//
//  DueJobsCalendarView.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/12/23.
//

import SwiftUI

struct DueJobsCalendarView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                CalendarView(interval: DateInterval(start: .distantPast, end: .distantFuture))
                    
            }
            .navigationTitle("Calendar")
        }
        .preferredColorScheme(.dark)
    }
}

struct DueJobsCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        DueJobsCalendarView()
    }
}
