//
//  NewJobsDetailsView.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/13/23.
//

import SwiftUI

struct NewJobsDetailsView: View {
    @StateObject private var viewModel = CustomerCreationViewModelImpl(
        service: CustDetailsAndMeasuresServiceImpl()
    )
    
    
    var namespace: Namespace.ID
    @Binding var shouldShowDashboard: Bool
    var NewJobDashButton: NewJobDashboardButtons = newJobbuttonDetails[0]
    
    @EnvironmentObject var model: Model
    
    @State private var displayPopupMessage: Bool = false
    
    
    @State private var shouldShowMeasures = false
    
    
    @State var showStatusBar = true
    
    @State var appear = [false,false,false]
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @State var viewState:  CGSize = .zero
    @State var isDragable = true
    
    @State var ShowSection =  false
    @State var selecteIndex = 0
    
    var body: some View {
        
        ZStack{
            ScrollView {
                cover
                contentCustomerPrimaryInfo
                    .offset(y:80)
                    .padding(.bottom,200)
                    .opacity(appear[2] ? 1 : 0)
            }
            .coordinateSpace(name: "scrollNewJob") //coordination space is added here so the background doesnt get blurring when selecting the item of the search
            .onAppear {model.showDetails = true}
            .onDisappear{model.showDetails = false }
            .mask(RoundedRectangle(cornerRadius: viewState.width / 3,style: .continuous))
            .shadow(color: .black.opacity(0.3),radius: 30,x:0,y: 10)
            .scaleEffect(viewState.width / -500 + 1 )
            .background(.black.opacity(viewState.width / 500))
            .background(.ultraThinMaterial)
            .gesture(isDragable ? drag : nil )
            .ignoresSafeArea()
            
            button
            
            
        }
        .onAppear {
            fadeIn()
        }
        .onChange(of: shouldShowDashboard, perform: { newValue in
            fadeOut()
        })
//        .statusBarHidden(!showStatusBar)
        .onChange(of: shouldShowDashboard) { newValue in
            withAnimation(.closeCard ) {
                if newValue {
                    showStatusBar = false
                } else {
                    showStatusBar = true
                }
            }

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
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scrollNewJob")).minY
            
            VStack{
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
            .foregroundStyle(.black)
            .background(
                Image(NewJobDashButton.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .frame(maxWidth: 500)
                    .offset(y:60)
                    .matchedGeometryEffect(id: "background2NewJob\(NewJobDashButton.id)", in: namespace)
                    .offset(y: scrollY > 0 ? scrollY * -0.8: 0)
            )
            .background(
                Image(NewJobDashButton.background)
                    .resizable()
                    .aspectRatio( contentMode: .fill)
                    .matchedGeometryEffect(id: "bckgrndNewJob\(NewJobDashButton.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY: 0 )
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1 )
                    .blur(radius: scrollY / 10)
            )
            .mask(
                RoundedRectangle(cornerRadius: appear[0] ? 0 : 30,style: .continuous)
                    .matchedGeometryEffect(id: "maskNewJob\(NewJobDashButton.id)", in: namespace)
                    .offset(y:  scrollY > 0 ? -scrollY: 0 )
            )
            .overlay(
                overlayContent
                    .offset(y: scrollY > 0 ? scrollY * -0.6: 0 )
            )
        }
        .frame(height: 500)
    }
    var button: some View {
        Button {
//            withAnimation(.closeCard) {
//                displayPopupMessage.toggle()
//
//            }
            withAnimation(.closeCard.delay(0.3)) {
                shouldShowDashboard.toggle()
                model.showDetails.toggle()
                
                print("Dis is customer details")
                print("thisclicked")
            }
            isDragable = false
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
//                        shouldShowDashboard.toggle()
//                        model.showDetails.toggle()
//
//                        print("Dis is customer details")
//                        print("thisclicked")
//                    }
//                    isDragable = false
//                    //                    handleDismissal()
//                })
//                )
//            }
    }
    var contentCustomerPrimaryInfo: some View {
        VStack(alignment: .leading){
            
            ForEach(Array(newJobbuttonDetails.enumerated()),id: \.offset ) { index, section in
                if index != 0 {  Divider() }
                NewJobSectionRow(section: section)
                    .onTapGesture {
                        selecteIndex = index
                        ShowSection = true
                    }
            }
           
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30,style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(20)
        .sheet(isPresented: $ShowSection) {
            
            NewJobSectionView(newjobSectionButtons: newJobbuttonDetails[selecteIndex])
//            SectionView(sectionButtons: buttonDetails[selecteIndex])
        }

        
    }
    var overlayContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(NewJobDashButton.tittle)
                .font(.largeTitle.weight(.bold))
                .frame(maxWidth: .infinity,
                       alignment: .center)
                .matchedGeometryEffect(id: "titleNewJob\(NewJobDashButton.id)", in: namespace)
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
                    .matchedGeometryEffect(id: "blurNewJob\(NewJobDashButton.id)", in: namespace)
            )
            .offset(y:250)
            .padding(20)
    }
    var drag: some Gesture {
        DragGesture(minimumDistance: 30,coordinateSpace: .local)
            .onChanged { value in
                guard value.translation.width > 0 else { return}
                
                if value.startLocation.x < 100 {
                    withAnimation(.closeCard) {
                        viewState = value.translation
                    }
                }
                
            }
            .onEnded { value in
                
                if viewState.width > 80 {
                    displayPopupMessage.toggle()
                } else {
                    withAnimation(.closeCard) {
                        viewState = .zero
                    }
                }
                
                
            }
    }
    func fadeIn(){
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        withAnimation(.easeOut.delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.5)) {
            appear[2] = true
        }
    }
    func fadeOut(){
        appear[0] = false
        appear[1] = false
        appear[2] = false
    }
    func close() {
        withAnimation(.closeCard.delay(0.3)) {
            displayPopupMessage.toggle()
            
        }
        withAnimation(.closeCard) {
            viewState = .zero
        }
    }
}

struct NewJobsDetailsView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        NewJobsDetailsView(namespace: namespace, shouldShowDashboard: .constant(true))
            .environmentObject(Model() )
    }
}
