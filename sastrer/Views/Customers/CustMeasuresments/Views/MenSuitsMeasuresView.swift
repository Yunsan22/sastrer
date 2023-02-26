//
//  MenSuitsMeasuresView.swift
//  sastrer
//
//  Created by Yunior Sanchez on 2/10/23.
//

import SwiftUI

struct MenSuitsMeasuresView: View {
    
    @StateObject private var viewModel = SuitMeasuresDataCreationViewModelImpl(
        service: MeasuresServiceImpl()
    )
    @State private var displayPopupMessage: Bool = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @State var appear = [false,false,false]
    
    var namespace: Namespace.ID
    
    var measurementsButtons: MeasuresButtons = measuresButtons[0]
    @Binding var show: Bool
//    @Namespace var namespace
//    @State var show = false
    
    @State var showPreviousView = false
    @State var viewState:  CGSize = .zero
    @State var isDragable = true
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                measurements
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
        .onChange(of: show, perform: { newValue in
            fadeOut()
        })
        .background(
            ZStack{
                Color.black
                RoundedRectangle(cornerRadius: 30,style: .continuous).foregroundStyle(.linearGradient(colors: [.blue,.black], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 900,height: 400)
                    .rotationEffect(.degrees(135))
                    .offset(y:-400)
                    .matchedGeometryEffect(id: "background", in: namespace)
                
            }
            
        )
        .preferredColorScheme(.dark)
        
    }
    
    var cover: some View {
        
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .global).minY
            
            VStack{
                Spacer()
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 500 - scrollY : 500)
            .foregroundStyle(.black)
            .background(
                Group{
                    Image(measurementsButtons.background3)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(20)
                        .frame(maxWidth: 500)
                        .offset(x:70,y:-20)
                        .matchedGeometryEffect(id: "background3\(measurementsButtons.id)", in: namespace)
                        .offset(y: scrollY > 0 ? scrollY * -0.8: 0)
                    
                    Image(measurementsButtons.background2)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(20)
                        .frame(maxWidth: 500)
                        .offset(x:80,y:60)
                        .matchedGeometryEffect(id: "background2\(measurementsButtons.id)", in: namespace)
                        .offset(y: scrollY > 0 ? scrollY * -0.8: 0)
                    
                    Image(measurementsButtons.background1)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(20)
                        .frame(maxWidth: 500)
                        .offset(x:-70,y:-10)
                        .matchedGeometryEffect(id: "background\(measurementsButtons.id)", in: namespace)
                        .offset(y: scrollY > 0 ? scrollY * -0.8: 0)
                    
                    Image(measurementsButtons.background4 ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(20)
                        .frame(maxWidth: 500)
                        .offset(x:-110,y:-10)
                        .matchedGeometryEffect(id: "background4\(measurementsButtons.id)", in: namespace)
                        .offset(y: scrollY > 0 ? scrollY * -0.8: 0)
                }
                
            )
            .background(
                Image(measurementsButtons.background)
                    .resizable()
                    .aspectRatio( contentMode: .fill)
                    .matchedGeometryEffect(id: "bckgrnd\(measurementsButtons.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY: 0 )
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                    .blur(radius: scrollY / 10)
            )
            .mask(
                RoundedRectangle(cornerRadius:  appear[0] ? 0 : 30,style: .continuous)
                    .matchedGeometryEffect(id: "mask\(measurementsButtons.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY: 0 )
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
//            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.bold))
                .foregroundColor(.secondary)
                .padding(15)
                .background(.ultraThinMaterial, in: Circle())
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
        .padding(20)
//            .offset(y: 40)
        .ignoresSafeArea()
        .alert(isPresented: $displayPopupMessage){
            Alert(title: Text("Warning"),
                  message: Text("all your progress will be lost"),
                  dismissButton: .default(Text("OK"), action: {
                
                withAnimation(.closeCard.delay(0.3)) {
                    show.toggle()
                }
                isDragable = false
                print("Dis is cments tops")
                print("thisclicked")
//                    handleDismissal()
            })
            )
        }
    }
    
    var overlayContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(measurementsButtons.measuresTittle)
                .font(.largeTitle.weight(.bold))
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .matchedGeometryEffect(id: "title\(measurementsButtons.id)", in: namespace)
            
            Text(measurementsButtons.measuresSubtitle.uppercased())
                .font(.footnote.weight(.semibold))
                .frame(maxWidth: .infinity,alignment: .leading)
                .matchedGeometryEffect(id: "subtitles\(measurementsButtons.id)", in: namespace)
            
            Text(measurementsButtons.footer)
                .font(.footnote)
                .frame(maxWidth: .infinity,alignment: .leading)
                .matchedGeometryEffect(id: "text\(measurementsButtons.id)", in: namespace)
        }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
                    .matchedGeometryEffect(id: "blur\(measurementsButtons.id)", in: namespace)
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
    
    var measurements: some View {
        VStack {
            Group {
                HStack{
                    InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.back, placeholder: "Back", keyboardType: .decimalPad, sfSymbol: nil)
            
                    InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.sleeveLength, placeholder: "Sleeve Length", keyboardType: .decimalPad, sfSymbol: nil)
                }
                HStack{
                    InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.elbowWidth, placeholder: "Elbow Width", keyboardType: .decimalPad, sfSymbol: nil)
            
                    InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.fistWidth, placeholder: "Fist Width", keyboardType: .decimalPad, sfSymbol: nil)
            
                }
                HStack{
                    InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.length, placeholder: "Length", keyboardType: .decimalPad, sfSymbol: nil)
            
                    InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.baseHips, placeholder: "Base/Hips", keyboardType: .decimalPad, sfSymbol: nil)
            
                }
                HStack{
                    InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.bellyWidth, placeholder: "Belly Width", keyboardType: .decimalPad, sfSymbol: nil)
            
                    InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.neckWidth, placeholder: "Neck Width", keyboardType: .decimalPad, sfSymbol: nil)
                }
                HStack {
                    InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.vestsLength, placeholder: "Vest's Length", keyboardType: .decimalPad, sfSymbol: nil)
                }
            
            
                InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.shortSleeveLength, placeholder: "Short Sleeve Length", keyboardType: .decimalPad, sfSymbol: nil)
            
                InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.shortSleeveWidth, placeholder: "Short Sleeve Width", keyboardType: .decimalPad, sfSymbol: nil)
            
                HStack {
                    InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.armholeLength, placeholder: "Armhole length", keyboardType: .decimalPad, sfSymbol: nil)
                    InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.backWaistLength, placeholder: "Back waist Length", keyboardType: .decimalPad, sfSymbol: nil)
                }
            
            }
            Group{
                HStack {
                    InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.backOverAllLength, placeholder: "Back overall length", keyboardType: .decimalPad, sfSymbol: nil)
            
                    InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.armholeWidth, placeholder: "Armhole width", keyboardType: .decimalPad, sfSymbol: nil)
            
                }
                HStack{
                    InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.armholeRoundedWidth, placeholder: "Armhole rounded width", keyboardType: .decimalPad, sfSymbol: nil)
            
                }
            
                HStack{
                    InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.frontLength, placeholder: "Front length", keyboardType: .decimalPad, sfSymbol: nil)
            
                    InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.waist, placeholder: "Waist", keyboardType: .decimalPad, sfSymbol: nil)
            
            
                }
                HStack{
                    InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.shoulderWidth, placeholder: "Shoulder width", keyboardType: .decimalPad, sfSymbol: nil)
            
                }
                InputTextFieldView(text: $viewModel.suitMeasurementDetails.manShirtsMeasurments.chestWidth, placeholder: "Chest Width", keyboardType: .decimalPad, sfSymbol: nil)
            
                VStack{
                    ButtonView(title: "Save"){
                        withAnimation(.spring(response: 0.6,dampingFraction: 0.8)){
                            show.toggle()
                            print("button printed")
                            //                                    handleDismissal()
                        }
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topTrailing)
                    .padding(20)
                    //                            .alert(isPresented: $displayPopupMessage){
                    //                                Alert(title: Text("Warning"),
                    //                                      message: Text("This is a test"),
                    //                                      dismissButton: .default(Text("OK"), action: {
                    //                                    print("Ok Click")
                    //                                    print("this is save button clicked")
                    //                                    //save data
                    //
                    //                                    //dismiss screen
                    ////                                    handleDismissal()
                    //                                })
                    //                                )
                    //                            }
            
            
                }
            }
        }
        

    }
}

struct MenTopsMeasuresView_Previews: PreviewProvider {
    @Namespace static var namespace
//
    static var previews: some View {
        MenSuitsMeasuresView(namespace: namespace,show: .constant(true))
//        MenSuitsMeasuresView()
    }
}



extension MenSuitsMeasuresView {
    func handleDismissal(){
        if #available(iOS 15, *) {
            dismiss()
        }else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

