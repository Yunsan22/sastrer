//
//  ItemsDueListView.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/9/23.
//

import SwiftUI

struct ItemsDueListView: View {
    var namespace: Namespace.ID
    @Binding var show: Bool
    var itemDue: CustomerJobs = itemsDueArray[0]
    var body: some View {
        Text("More information about the item due will be display")
    }
}

struct ItemsDueListView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        ItemsDueListView(namespace: namespace , show: .constant(true))
    }
}
