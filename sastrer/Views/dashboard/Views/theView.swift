//
//  theView.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//

import SwiftUI

struct theView: View {
    @StateObject private var viewModel = SuitMeasuresDataCreationViewModelImpl(
        service: MeasuresServiceImpl()
    )
    
    @State var hasScrolled2 =  false
    @Namespace var namespace
    @State var show = false
    @State var showStatusBar = true
    @State var selectedID2 = UUID()
//    var namespace: Namespace.ID
//    @Binding var show: Bool
    @State private var displayPopupMessage: Bool = false
    @State private var donePopmessage: Bool = false
    
    @State var showPreviousView = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    
    
    
    
    
    var body: some View {
            ZStack {
                ScrollView {
                    scrollDetection
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 300),spacing: 20)],spacing: 20) {
                        if !show {
                            measureCards
                        } else {
                            ForEach(dashboardButtons) { buttonItem in
                                Rectangle()
                                    .fill(.white)
                                    .frame(height: 230 )
                                    .cornerRadius(30)
                                    .shadow(color: Color("Shadow"), radius: 20,x:0,y:10)
                                    .opacity(0.3)
                                    .padding(.horizontal,30)
                            }
                        }
                    }
                    .padding(.horizontal,20)
                    
                    
                }
                .preferredColorScheme(.dark)
                .coordinateSpace(name: "scrolltheView")
                .safeAreaInset(edge: .top, content: {
                    Color.clear.frame(height: 70)
                })
                .ignoresSafeArea()
                
                buttons
                
                if show {
                    details
                }

                
            }
 
            .preferredColorScheme(.dark)
            .background(
                ZStack{
                    Color.black
                    RoundedRectangle(cornerRadius: 30,style: .continuous).foregroundStyle(.linearGradient(colors: [.blue,.black], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 1200,height: 450)
                        .rotationEffect(.degrees(135))
                        .offset(y:-400)
                    
                })
            .statusBarHidden(!showStatusBar)
            .onChange(of: show) { newValue in
                withAnimation(.closeCard ) {
                    if newValue {
                        showStatusBar = false
                    } else {
                        showStatusBar = true
                    }
                }
    
            }
            
    }
    var buttons: some View {
        
            Group{
                Button {
                    withAnimation(.openCard) {
                        displayPopupMessage.toggle()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.body.weight(.bold))
                        .foregroundColor(.secondary)
                        .padding(15)
                        .background(.ultraThinMaterial, in: Circle())
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
                .padding(20)
                .offset(y:15
                )
                .alert(isPresented: $displayPopupMessage){
                    Alert(title: Text("Warning"),
                          message: Text("Are you sure you want to go back and lose your progress"),
                          dismissButton: .default(Text("OK"), action: {
                        withAnimation(.closeCard) {
                            show.toggle()
                        }
                        
                        print("Dis is customer details")
                        print("thisclicked")
                        handleDismissal()
                    })
                    )
                }
                .ignoresSafeArea()
                
                Button {
                    withAnimation(.openCard) {
                        donePopmessage.toggle()
                    }
                } label: {
                    Text( "Done")
                        .font(.body.weight(.bold))
                        .foregroundColor(.secondary)
                        .padding(15)
                        .background(.ultraThinMaterial, in: Circle())
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topTrailing)
                .padding(20)
                .offset(y:10
                )
                .alert(isPresented: $donePopmessage){
                    Alert(title: Text("Warning"),
                          message: Text("Are you sure all needed measures were taken?"),
                          primaryButton: .default(Text("Yes"), action: {
                        withAnimation(.closeCard) {
                            show.toggle()
                            print("Dis is customer details")
                            print("thisclicked")
                            handleDismissal()
                        }                        
                    }),
                          secondaryButton: .cancel(Text("No") )
                    )
                }
                .ignoresSafeArea()
            }
            
    }
    var scrollDetection: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: ScrollPreferenceKey.self,value: proxy.frame(in: .named("scrolltheView")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self,perform: { value in
            withAnimation(.easeInOut){
                if value < 0 {
                    hasScrolled2 = true
                } else {
                    hasScrolled2 = false
                }
            }
        })
        
    }
    var measureCards: some View {
        ForEach(measuresButtons) { measureButtonItem in
            MensComponent(namespace: namespace,  show: $show, measurementsButtons: measureButtonItem)
                .onTapGesture {
                    withAnimation(.openCard ) {
                        show.toggle()
                        showStatusBar = false
                        selectedID2 = measureButtonItem.id
                    }
                    
            }
        }
    }
    var details: some View {
        ForEach(measuresButtons) { measureButtonItem in
            if measureButtonItem.id == selectedID2 {
                MenSuitsMeasuresView(namespace: namespace,measurementsButtons: measureButtonItem, show: $show)
                    .zIndex(1)
                    .transition(.asymmetric(insertion: .opacity.animation(.easeInOut(duration: 0.1)), removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
            }
            
        }
    }
}

struct theView_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        
        theView()
//        theView(namespace: namespace, show: .constant(true))
    }
}

extension theView {
    func handleDismissal(){
        if #available(iOS 15, *) {
            dismiss()
        }else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

