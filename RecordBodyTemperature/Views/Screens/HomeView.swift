//
//  HomeView.swift
//  RecordBodyTemperature
//
//  Created by 神村亮佑 on 2021/02/01.
//


import SwiftUI
import UIKit
import PopupView

struct HomeView: View {
    // For AVFoundation View Model
    @ObservedObject var avFoundationVM: AVFoundationVM
    // For Realm DB
    @StateObject var bodyTmpStore: BodyTmpStore = BodyTmpStore()
    
    // Binding Properties
    @Binding var tabViewSelection: Int
    @Binding var isRecognizedText: Bool
    
    // State Properties
    @State var selectedBodyTemperature: String = "36.5"
    @State var selectedIntPart: String = "36."
    @State var selectedDecimalPart: String = "5"
    
    // Alert Properties
    @State var isShowPopup: Bool = false
    @State var popupMessage: PopupMessage = .succeededInSaveImage
    
    var body: some View {
        ZStack{
            VStack(spacing: 15){
                HStack(){
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "rectangle.grid.1x2")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color(.purple))
                            .clipShape(Circle())
                    })
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "gearshape.fill")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color(.purple))
                            .clipShape(Circle())
                    })
                }.padding()
                Spacer()
            }
            //MARK: Camera View
            CALayerView(caLayer: avFoundationVM.previewLayer)
                .onTapGesture {
                    avFoundationVM.takePicture()
                }
        }
    }
    
    //MARK: PRIVATE FUNCTIONS
    private func performVision(uiImage: UIImage){
        // Recognied Text -> return [ Recognized Text ]
        if isRecognizedText {
            VisionHelper.instance.performVisionRecognition(uiImage: uiImage) { (recognizedStrings) in
                print("recognized Strings -> \(recognizedStrings)")
                // Format Result Strings
                VisionFormatter.instance.recognizedTextFormatter(recognizedStrings: recognizedStrings) { (returnedBodyTemperature) in
                    selectedBodyTemperature = String(returnedBodyTemperature)
                    let intPartAndDecimalPart = selectedBodyTemperature.split(separator: ".")
                    selectedIntPart = String(intPartAndDecimalPart[0]) + "."
                    selectedDecimalPart = String(intPartAndDecimalPart[1])
                    // Notification Success Vision
                    popupMessage = .succeededInVision
                    isShowPopup.toggle()
                }
            }
        }else {
            popupMessage = .requiredVisionPermission
            isShowPopup.toggle()
            print("Visionの許可がおりていません")
        }
    }
    private func pushSaveButton() {
        if avFoundationVM.image != nil{
            let bodyTemperature = String(selectedIntPart + selectedDecimalPart)
            bodyTmpStore.bodyTemperature = bodyTemperature
            print("Add Data -> \(bodyTemperature)")
            
            bodyTmpStore.id = UUID().hashValue
            bodyTmpStore.dateCreated = Date()
            
            let fileName = String(bodyTmpStore.id)
            FileHelper.instance.saveImage(fileName: fileName, image: avFoundationVM.image!) { (success) in
                if success {
                    popupMessage = .succeededInSaveImage
                    isShowPopup.toggle()
                    print("画像の保存に成功しました。")
                    
                    print(bodyTmpStore.dateCreated)
                    print(bodyTmpStore.id)
                    bodyTmpStore.addData()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                        tabViewSelection = 1
                    }
                }else{
                    popupMessage = .failedToSavePicture
                    isShowPopup.toggle()
                    print("画像の保存に失敗しました。")
                }
            }
        }else{
            popupMessage = .needTakePicture
            isShowPopup.toggle()
            print("写真を撮影してください")
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    @State static var tabViewSelection: Int = 0
    @State static var isBool = true
    
    static var previews: some View {
        Group {
            HomeView(avFoundationVM: AVFoundationVM(), tabViewSelection: $tabViewSelection, isRecognizedText: $isBool)
        }
    }
}

enum PopupMessage {
    case succeededInSaveImage // 画像を保存、成功時
    case failedToSavePicture // 画像保存、失敗時
    case needTakePicture // 写真をキャプチャしていない時
    case requiredVisionPermission // Visionの許可が降りていない時
    case succeededInVision // 認識が成功した時
    
}
