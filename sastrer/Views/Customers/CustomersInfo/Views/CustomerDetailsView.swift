//
//  CustomerDetailsView.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//

import SwiftUI

struct CustomerDetailsView: View {
    
    @StateObject private var viewModel = CustomerCreationViewModelImpl(
        service: CustDetailsAndMeasuresServiceImpl()
    )
    
    var namespace: Namespace.ID
    @Binding var shouldShowDashboard: Bool
    var dashorButtons: DashorButtons = dashboardButtons[0]
    @EnvironmentObject var model: Model
    
    @State private var displayPopupMessage: Bool = false
    
    
    @State private var shouldShowMeasures = false
    
    
    @State var showStatusBar = true
    
    @State var appear = [false,false,false]
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @State var viewState:  CGSize = .zero
    @State var isDragable = true
    
    
    var body: some View {
        
        ZStack{
            ScrollView {
                cover
                contentCustomerPrimaryInfo
                    .offset(y:80)
                    .padding(.bottom,200)
                    .opacity(appear[2] ? 1 : 0)
            }
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
            let scrollY = proxy.frame(in: .global).minY
            
            VStack{
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
            .foregroundStyle(.black)
            .background(
                Image(dashorButtons.background2)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .frame(maxWidth: 500)
                    .offset(y:60)
                    .matchedGeometryEffect(id: "background2\(dashorButtons.id)", in: namespace)
                    .offset(y: scrollY > 0 ? scrollY * -0.8: 0)
            )
            .background(
                Image(dashorButtons.background)
                    .resizable()
                    .aspectRatio( contentMode: .fill)
                    .matchedGeometryEffect(id: "bckgrnd\(dashorButtons.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY: 0 )
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1 )
                    .blur(radius: scrollY / 10)
            )
            .mask(
                RoundedRectangle(cornerRadius: appear[0] ? 0 : 30,style: .continuous)
                    .matchedGeometryEffect(id: "mask\(dashorButtons.id)", in: namespace)
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
                displayPopupMessage.toggle()
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
            .alert(isPresented: $displayPopupMessage){
                Alert(title: Text("Warning"),
                      message: Text("All data will be deleted"),
                      dismissButton: .default(Text("OK"), action: {
                    withAnimation(.closeCard.delay(0.3)) {
                        shouldShowDashboard.toggle()
                        model.showDetails.toggle()
                        
                        print("Dis is customer details")
                        print("thisclicked")
                    }
                    isDragable = false
                    //                    handleDismissal()
                })
                )
            }
    }
    var contentCustomerPrimaryInfo: some View {
        VStack{
            
            clientInfo
            address
            butonview
            clearAll
        }
        

        
    }
    var overlayContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(dashorButtons.buttonTittle)
                .font(.largeTitle.weight(.bold))
                .frame(maxWidth: .infinity,
                       alignment: .center)
                .matchedGeometryEffect(id: "title\(dashorButtons.id)", in: namespace)
            Text(dashorButtons.ButtonSubtitle.uppercased())
                .font(.largeTitle.weight(.bold))
                .frame(maxWidth: .infinity,alignment: .center)
                .matchedGeometryEffect(id: "subtitle\(dashorButtons.id)", in: namespace)
        }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
                    .matchedGeometryEffect(id: "blur\(dashorButtons.id)", in: namespace)
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

struct MeasurementForm_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        //        MeasurementContentView{_ in}
        CustomerDetailsView(namespace: namespace,shouldShowDashboard: .constant(true))
            .environmentObject(Model() )
    }
}

private extension CustomerDetailsView {
    var clientInfo: some View {
        Section {
            InputTextFieldView(text: $viewModel.customerDetails.clientInfo.firstName, placeholder: "First Name", keyboardType: .default, sfSymbol: nil)
            
            InputTextFieldView(text: $viewModel.customerDetails.clientInfo.lastName, placeholder: "Last Name", keyboardType: .default, sfSymbol: nil)
            
            Picker("Gender", selection: $viewModel.customerDetails.clientInfo.gender) {
                ForEach(CustomersMeasurementsAndDetails.ClientInfo.Gender.allCases) { Item in
                    Text(Item.rawValue.uppercased())
                }
            }
            //            Picker("Pronouns", selection: $viewModel.customerDetails.clientInfo.pronoun) {
            //                ForEach(CustomersMeasurementsAndDetails.ClientInfo.Pronouns.allCases) { Item in
            //                    Text(Item.rawValue.uppercased())
            //                }
            //            }
            
            InputTextFieldView(text: $viewModel.customerDetails.clientInfo.phone, placeholder: "Phone", keyboardType: .phonePad, sfSymbol: nil)
            
            InputTextFieldView(text: $viewModel.customerDetails.clientInfo.comments, placeholder: "Comments", keyboardType: .default, sfSymbol: nil)
            
            
        } header: {
            Text(NSLocalizedString("Customer information", comment: "na")).font(.largeTitle).font(.footnote)
        }
        .headerProminence(.increased)
    }
    
    var address: some View {
        Section {
            
            InputTextFieldView(text: $viewModel.customerDetails.address.streetAddress, placeholder: "Street Address", keyboardType: .default, sfSymbol: nil)
            
            InputTextFieldView(text: $viewModel.customerDetails.address.city, placeholder: "City", keyboardType: .default, sfSymbol: nil)
            
            InputTextFieldView(text: $viewModel.customerDetails.address.stateProvidence, placeholder: "State/Providence", keyboardType: .default, sfSymbol: nil)
            
            InputTextFieldView(text: $viewModel.customerDetails.address.postalCode, placeholder: "Postal Code", keyboardType: .default, sfSymbol: nil)
            
            
            InputTextFieldView(text: $viewModel.customerDetails.address.country, placeholder: "Country", keyboardType: .default, sfSymbol: nil)
        } header: {
            Text(NSLocalizedString("Mailing Address", comment: "na")).font(.largeTitle).font(.footnote)
        } footer: {
            Text(LocalizedStringKey("If you go back before saving all data will be lost"))
                .font(.footnote)
        }
        .headerProminence(.increased)
    }
    
    var manShirtsMeasurments: some View {
        Section {
            HStack{
                TextField(NSLocalizedString("Back", comment: "na"),
                          text: $viewModel.customerDetails.manShirtsMeasurments.back)
                .lineLimit(1)
                Divider()
                
                TextField(NSLocalizedString("Fist Width", comment: "na"),
                          text: $viewModel.customerDetails.manShirtsMeasurments.fistWidth)
            }
            HStack{
                TextField(NSLocalizedString("Sleeve Length", comment: "na"),
                          text: $viewModel.customerDetails.manShirtsMeasurments.sleeveLength)
                Divider()
                
                TextField(NSLocalizedString("Elbow Width", comment: "na"),
                          text: $viewModel.customerDetails.manShirtsMeasurments.elbowWidth)
            }
            HStack{
                
                TextField(NSLocalizedString("Chest Width", comment: "na"),
                          text: $viewModel.customerDetails.manShirtsMeasurments.chestWidth)
                Divider()
                
                TextField(NSLocalizedString("Belly Width", comment: "na"),
                          text: $viewModel.customerDetails.manShirtsMeasurments.bellyWidth)
            }
            HStack{
                
                TextField(NSLocalizedString("Neck Width", comment: "na"),
                          text: $viewModel.customerDetails.manShirtsMeasurments.neckWidth)
                Divider()
                
                TextField(NSLocalizedString("Jacket's Length", comment: "na"),
                          text: $viewModel.customerDetails.manShirtsMeasurments.jacketsLength)
                
            }
            HStack{
                
                TextField(NSLocalizedString("Length", comment: "na"),
                          text: $viewModel.customerDetails.manShirtsMeasurments.length)
                Divider()
                
                TextField(NSLocalizedString("Short Sleeve Width", comment: "na"),
                          text: $viewModel.customerDetails.manShirtsMeasurments.shortSleeveWidth)
                .multilineTextAlignment(.center)
                
            }
        } header: {
            Text(NSLocalizedString("Guayabera/Shirt/jacket", comment: "na"))
        }
    }
    var womanShirtsMeasurments: some View {
        Section {
            HStack{
                TextField(NSLocalizedString("Back", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.back)
                .lineLimit(1)
                Divider()
                
                TextField("Length",
                          text: $viewModel.customerDetails.womanShirtsMeasurments.length)
                Divider()
                
                TextField(NSLocalizedString("Fist Width", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.fistWidth)
            }
            HStack{
                TextField(NSLocalizedString("Sleeve Length", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.sleeveLength)
                Divider()
                
                TextField(NSLocalizedString("Skirt Length", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.skirtLength)
                
            }
            HStack{
                TextField(NSLocalizedString("Neck Width", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.neckWidth)
                Divider()
                
                TextField(NSLocalizedString("Elbow Width", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.elbowWidth)
            }
            HStack{
                TextField(NSLocalizedString("Bust Width", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.chestWidth)
                Divider()
                
                TextField(NSLocalizedString("Belly Width", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.bellyWidth)
                
            }
            
            HStack{
                
                TextField(NSLocalizedString("Low Bust", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.lowBust)
                Divider()
                
                TextField(NSLocalizedString("Hight Bust", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.highBust)
            }
            
            HStack{
                TextField(NSLocalizedString("Short Sleeve Width", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.shortSleeveWidth)
                Divider()
                
                TextField(NSLocalizedString("Dress Length", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.dressLength)
            }
            
            HStack{
                TextField(NSLocalizedString("armhole width", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.armholeWidth)
                Divider()
                
                TextField(NSLocalizedString("Bust drop", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.bustDrop)
                
            }
            
            HStack{
                TextField(NSLocalizedString("Bust Separation", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.bustSeparation)
                Divider()
                
                TextField(NSLocalizedString("Jacket's Length", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.jacketsLength)
            }
            HStack{
                
                TextField(NSLocalizedString("Waist", comment: "Cintura"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.waist)
                Divider()
                
                TextField(NSLocalizedString("Hips", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.hips)
                
            }
            HStack{
                TextField(NSLocalizedString("Length from bust drop to low Bust", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.lengthfromCaidatoLowBust)
                Divider()
                
                TextField(NSLocalizedString("Mid Hips", comment: "na"),
                          text: $viewModel.customerDetails.womanShirtsMeasurments.midHips)
            }
        }header: {
            Text(NSLocalizedString("Women's Jacket/blouse/dress/skirt", comment: "na"))
        }
    }
    
    var pantsMeasurments: some View {
        Section {
            HStack{
                TextField("Back",text: $viewModel.customerDetails.pantsMeasurments.length)
                    .lineLimit(1)
                TextField("Length",text: $viewModel.customerDetails.pantsMeasurments.length)
                TextField("Fist Width",text: $viewModel.customerDetails.pantsMeasurments.length)
            }
            HStack{
                TextField("Sleeve Length",text: $viewModel.customerDetails.pantsMeasurments.length)
                TextField("Elbow Width",text: $viewModel.customerDetails.pantsMeasurments.length)
            }
            HStack{
                
                TextField("Chest Width",text: $viewModel.customerDetails.pantsMeasurments.length)
                TextField("Belly Width",text: $viewModel.customerDetails.pantsMeasurments.length)
                TextField("Neck Width",text: $viewModel.customerDetails.pantsMeasurments.length)
            }
            
        }header: {
            Text("Pants")
        }
    }
    var butonview:some View {
        ButtonView(title: "Save and Continue",
                   background: .clear,
                   border: .blue) {
            //                                shouldShowDashboard.toggle()
            showStatusBar = false
            shouldShowMeasures.toggle()
            
            print($showStatusBar)
            //this below save to Firebase
            //trying alternative way to save to firestore
            //            viewModel.custumerCreation()
            
        }
                   .fullScreenCover(isPresented: $shouldShowMeasures, content: {
                       
                       //                    MeasuresContentView()
                       theView()
                       
                   })
        //                        .disabled(!viewModel.isValid)
    }
    var clearAll: some View {
        Button(role: .destructive) {
            withAnimation {
                viewModel.clearAll()
            }
            
        }label: {
            Text(NSLocalizedString("Clear All", comment: "na"))
        }
        
    }
    
    
}
extension CustomerDetailsView {
    func handleDismissal(){
        if #available(iOS 15, *) {
            dismiss()
        }else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

