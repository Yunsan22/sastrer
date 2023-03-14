//
//  NewJobSectionView.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/13/23.
//

import SwiftUI

struct NewJobSectionView: View {
   
    
    var newjobSectionButtons: NewJobDashboardButtons = newJobbuttonDetails[0]
    
    @State private var displayPopupMessage: Bool = false
  
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        ZStack{
            ScrollView {
                cover
                contentCustomerPrimaryInfo
                    .offset(y:80)
                    .padding(.bottom,200)
                    
            }
            .ignoresSafeArea()
            
            button
            
            
        }
        .background(
            ZStack{
                Color.black
                RoundedRectangle(cornerRadius: 30,style: .continuous).foregroundStyle(.linearGradient(colors: [.blue,.black], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 1200,height: 450)
                    .rotationEffect(.degrees(135))
                    .offset(y:-280)

            })
        .preferredColorScheme(.dark)
    }
    
    var cover: some View {
        VStack{
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height:500)
        .foregroundStyle(.black)
        .background(
            Image(newjobSectionButtons.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
                .frame(maxWidth: 500)
                .offset(y:60)
            
        )
        .background(
            Image(newjobSectionButtons.background)
                .resizable()
                .aspectRatio( contentMode: .fill)
            
        )
        .mask(
            RoundedRectangle(cornerRadius: 0,style: .continuous)
            
        )
        .overlay(
            overlayContent
            
        )
        .frame(height: 500)
    }
       
  
    var button: some View {
        Button {
            withAnimation(.closeCard.delay(0.3)) {
              
                handleDismissal()
                
                print("Dis is customer details")
                print("thisclicked")
            }
           
            //                    handleDismissal()
//            withAnimation(.closeCard) {
//                displayPopupMessage.toggle()
//
//            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.bold))
                .foregroundColor(.secondary)
                .padding(12)
                .background(.ultraThinMaterial, in: Circle())
        }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
            .padding(20)
            .ignoresSafeArea()
//            .alert(isPresented: $displayPopupMessage){
//                Alert(title: Text("Warning"),
//                      message: Text("All data will be deleted"),
//                      dismissButton: .default(Text("OK"), action: {
//                    withAnimation(.closeCard.delay(0.3)) {
//                      
//                        handleDismissal()
//                        
//                        print("Dis is customer details")
//                        print("thisclicked")
//                    }
//                   
//                    //
//                })
//                )
//            }
    }
    var contentCustomerPrimaryInfo: some View {
        VStack{
            // here is where that event will be created for the customer item which will then tight into the calendar
            Text("here is where that event will be created for the customer item which will then tight into the calendar")
        }
        

        
    }
    var overlayContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(newjobSectionButtons.tittle)
                .font(.largeTitle.weight(.bold))
                .frame(maxWidth: .infinity,
                       alignment: .center)
                
//            Text(dashorButtons.ButtonSubtitle.uppercased())
//                .font(.largeTitle.weight(.bold))
//                .frame(maxWidth: .infinity,alignment: .center)
//                .matchedGeometryEffect(id: "subtitle\(dashorButtons.id)", in: namespace)
        }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
                    
            )
            .offset(y:250)
            .padding(20)
    }
}

struct NewJobSectionView_Previews: PreviewProvider {
    static var previews: some View {
        NewJobSectionView()
    }
}

extension NewJobSectionView {
    func handleDismissal(){
        if #available(iOS 15, *) {
            dismiss()
        }else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
