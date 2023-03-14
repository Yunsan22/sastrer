//
//  DashboardContentView.swift
//  sastreilor
//
//  Created by Yunior Sanchez on 2/6/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = SuitMeasuresDataCreationViewModelImpl(
        service: MeasuresServiceImpl()
    )
    
    
    @State var hasScrolled =  false
    @Namespace var namespace
    @State var show = false
    @State var showStatusBar = true
    @State var selectedID = UUID()
    @State var showITemsDue = false
    @State var selectedIndex = 0
    @AppStorage("isLiteMode") var isLiteMode =  true
    
    @EnvironmentObject var model: Model
    
    @State private var displayPopupMessage: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    
    
    
    
    var body: some View {
        
        ZStack {
            Color("Background").ignoresSafeArea()
            ScrollView {
                scrollDetection
                
                itemsDue
                
                Text("Dashboard".uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal,20)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300),spacing: 20)],spacing: 20) {
                    if !show {
                        
                       cards
                    } else {
                        ForEach(dashboardButtons) { buttonItem in
                            Rectangle()
                                .fill(.white)
                                .frame(height: 300 )
                                .cornerRadius(30)
                                .shadow(color: Color("Shadow"), radius: 20,x:0,y:10)
                                .opacity(0.3)
                                .padding(.horizontal,30)
                        }
                    }
                    
                }
                .padding(.horizontal,20)
                
                
                
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay(
                NavigationBar(title: "Items Due", hasSCrolled: $hasScrolled)
            )
            if show {
                details
            }
        }
//        .onDisappear { show.toggle()}
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
    var scrollDetection: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: ScrollPreferenceKey.self,value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self,perform: { value in
            withAnimation(.easeInOut){
                if value < 0 {
                    hasScrolled = true
                } else {
                    hasScrolled = false
                }
            }
        })
        
    }
    var itemsDue: some View {
        TabView {
            ForEach(Array(itemsDueArray.enumerated()),id: \.offset) { index,  itemsdue in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    ItemsDue(itemsdue: itemsdue)
                        .frame(maxWidth: 500)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical,40)
                        .rotation3DEffect(.degrees(minX / -10 ), axis: (x: 0, y: 1, z: 0) )
                        .shadow(color: Color("Shadow").opacity( isLiteMode ? 0: 0.3), radius: 5,x:0,y:3)
                        .blur(radius: abs(minX / 40))
                        .overlay(
                            Group{
                                Image(itemsdue.background )
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 120)
                                    .offset(x:60,y:-38)
                                    .offset(x: minX / 2 )
                                
                                Image(itemsdue.background2)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 120)
                                    .offset(x:140,y:-40)
                            }
                        )
                        .onTapGesture {
                            showITemsDue = true
                            selectedIndex = index
                        }
//                        .blur(radius: abs(minX / 40 ))
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 430)
        .background(
            RoundedRectangle(cornerRadius: 30,style: .continuous).foregroundStyle(.linearGradient(colors: [.blue,.black], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 900,height: 400)
                .rotationEffect(.degrees(135))
                .offset(x:-100,y:-200)
        )
        .sheet(isPresented: $showITemsDue) {
            
            ItemsDueListView(namespace: namespace, show: $show,itemDue: itemsDueArray[selectedIndex])
            
        }
    }
    var cards:some View {
        ForEach(dashboardButtons) { dashButtonItem in
            
            TakeMeasuresView(namespace: namespace,show: $show, dashorButtons: dashButtonItem )
                .onTapGesture {
                    withAnimation(.openCard ) {
                        show.toggle()
                        model.showDetails.toggle()
                        showStatusBar = false
                        selectedID = dashButtonItem.id
                    }
                    
                }
        }
    }
    var details: some View {
        ForEach(Array(dashboardButtons.enumerated()),id: \.offset ) { index, buttonItem in
            
            //trying to use index to put another view in the other button
            if index == 0 && buttonItem.id == selectedID {
                
                    CustomerDetailsView(namespace: namespace, shouldShowDashboard: $show,dashorButtons: buttonItem)
                        .zIndex(1)
                        .transition(.asymmetric(insertion: .opacity.animation(.easeInOut(duration: 0.1)), removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
                
            }
            else if index == 1 && buttonItem.id == selectedID {

                NewJobsDetailsView(namespace: namespace,shouldShowDashboard: $show)

            }
           
        }
    }
}

struct DashboardContentView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        HomeView()
            .environmentObject(Model())
    }
}

extension HomeView {
    func handleDismissal(){
        if #available(iOS 15, *) {
            dismiss()
        }else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
