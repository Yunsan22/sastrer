//
//  NewJobSectionRow.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/13/23.
//

import SwiftUI

struct NewJobSectionRow: View {
    
    var section: NewJobDashboardButtons = newJobbuttonDetails[0]
    
    var body: some View {
        HStack(alignment: .top, spacing: 16){
            Image(section.logo)
                .resizable()
                .frame(width: 36,height: 36)
                .mask(Circle())
                .padding(12)
                .background(Color(UIColor.systemBackground).opacity(0.3))
                .mask(Circle())
                .overlay(CircleView(value: section.progress))
            
            VStack(alignment:.leading,spacing: 8){
                Text(section.subtitle)
                    .font(.caption.weight(.medium))
                Text(section.tittle)
                    .fontWeight(.semibold)
                Text(section.text)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
                ProgressView(value: section.progress)
                    .tint(.white)
                    .frame(maxWidth: 132)
            }
        }
        .padding(20)
        
    }
}

struct NewJobSectionRow_Previews: PreviewProvider {
    static var previews: some View {
        NewJobSectionRow()
    }
}
