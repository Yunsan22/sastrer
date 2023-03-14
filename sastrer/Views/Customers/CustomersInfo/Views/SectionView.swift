//
//  SectionView.swift
//  Tailored
//
//  Created by Yunior Sanchez on 3/12/23.
//

import SwiftUI

struct SectionView: View {
    
    @StateObject private var viewModel = CustomerCreationViewModelImpl(
        service: CustDetailsAndMeasuresServiceImpl()
    )
    
    var sectionButtons: DashButtons = buttonDetails[0]
    @EnvironmentObject var model: Model
    
    @State private var displayPopupMessage: Bool = false
    
    
    @State private var shouldShowMeasures = false
    
    
    @State var showStatusBar = true
    
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    
   
  
    
    
    var body: some View {
        
        ZStack{
            ScrollView {
                cover
                content
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
        .statusBarHidden(!showStatusBar)
        
    }
    
    var cover: some View {
        VStack{
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height:500)
        .foregroundStyle(.black)
        .background(
            Image(sectionButtons.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
                .frame(maxWidth: 500)
                .offset(y:60)
            
        )
        .background(
            Image(sectionButtons.background)
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
//            withAnimation(.closeCard) {
            if viewModel.allFieldsEmpty {
                withAnimation(.closeCard.delay(0.3)) {
                  
                    handleDismissal()
               
                }
            } else {
                displayPopupMessage.toggle()
            }
                
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
                      
                        handleDismissal()
                        
                        print("Dis is customer details")
                        print("thisclicked")
                    }
                  
                })
                )
            }
    }
    var content: some View {
        VStack{
            
            clientInfo
            address
            butonview
            clearAll
        }
        

        
    }
    var overlayContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(sectionButtons.tittle)
                .font(.largeTitle.weight(.bold))
                .frame(maxWidth: .infinity,
                       alignment: .center)
 
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

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView()
    }
}

private extension SectionView {
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
                        viewModel.custumerCreation()
            
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
extension SectionView {
    func handleDismissal(){
        if #available(iOS 15, *) {
            dismiss()
        }else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
