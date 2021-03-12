//
//  ContentView.swift
//  RecordBodyTemperature
//
//  Created by 神村亮佑 on 2021/02/01.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedObject var avFoundationVM = AVFoundationVM()
    
    @StateObject var bodyTmpStore: BodyTmpStore = BodyTmpStore()
    
    // Show Tutorial View
    @State private var isShowTutorialView: Bool = false
    
    // Select Tab View
    @State var tabViewSelection: Int = 0
    
    // Whether to Recognized Text
    @State var isRecognizedText: Bool = true
    
    var body: some View {
        HomeView(avFoundationVM: avFoundationVM, tabViewSelection: $tabViewSelection, isRecognizedText: $isRecognizedText)
            .accentColor(Color.MyThemeColor.accentColor)
            .fullScreenCover(isPresented: $isShowTutorialView, content: {
                TutorialView()
            })
            .onAppear {
                // 初回起動時にチュートリアルViewを表示する
                firstVisitStep()
                // AVFoundationを起動
                DispatchQueue.main.async {
                    avFoundationVM.startSession()
                }
                print("startSession を始めます")
            }
            
            .onDisappear {
                // AVFoundationを終了
                DispatchQueue.main.async {
                    avFoundationVM.endSession()
                }
                bodyTmpStore.deInitData()
                print("endSession　で終了します")
            }
    }
    
    // MARK: PRIVATE FUNCTIONS
    private func firstVisitStep(){
        let visit = UserDefaults.standard.bool(forKey: CurrentUserDefault.isFirstVisit)
        if visit{
            print("Access more than once")
        }else{
            print("First access")
            addDemoData()
            isShowTutorialView.toggle()
            UserDefaults.standard.set(true, forKey: CurrentUserDefault.isFirstVisit)
            
        }
    }
    
    private func addDemoData(){
        bodyTmpStore.id = 123456
        bodyTmpStore.dateCreated = Date()
        bodyTmpStore.bodyTemperature = "36.0"
        bodyTmpStore.addData()
        print("Demo Dataを追加しました")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(bodyTmpStore: BodyTmpStore())
    }
}
