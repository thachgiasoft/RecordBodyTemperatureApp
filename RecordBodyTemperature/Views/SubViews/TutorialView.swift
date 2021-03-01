//
//  TutorialView.swift
//  RecordBodyTemperature
//
//  Created by 神村亮佑 on 2021/02/01.
//


import SwiftUI

struct TutorialView: View {
    @State var selection = 0
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if selection == 5 {
            // End of the slide show
            Button(action: {
                print("BUTTON CLICKED")
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Let's Start".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.all, 30)
                    .background(Color.MyThemeColor.accentColor)
                    .cornerRadius(10)
                    .shadow(radius: 20)
            })
            .onAppear(perform: {
                presentationMode.wrappedValue.dismiss()
            })
            
        }else{
            TabView(selection: $selection,
                    content: {
                        // MARK: TUTORIAL VIEW _ 0
                        VStack(alignment: .center, spacing: 0){
                            Spacer()
                            Text("さっそく、")
                                .bold()
                                .font(.title)
                                .foregroundColor(Color.MyThemeColor.accentColor)
                            
                            Text("チュートリアルを始めよう")
                                .bold()
                                .font(.title)
                                .foregroundColor(Color.MyThemeColor.accentColor)
                            
                            Image("humanImage")
                                .resizable()
                                .scaledToFit()
                            Text("所要時間10秒")
                                .bold()
                                .font(.title3)
                                .foregroundColor(Color.MyThemeColor.accentColor)
                            Button(action: {
                                selection += 1
                            }, label: {
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.system(size: 100))
                                    .foregroundColor(Color.MyThemeColor.accentColor)
                            })
                            Spacer()
                        }
                        .padding()
                        .tag(0)
                        // MARK: TUTORIAL VIEW _ 1
                        VStack{
                            Text("自動で読み取り")
                                .bold()
                                .font(.title)
                                .foregroundColor(Color.MyThemeColor.accentColor)
                                .padding()
                            Image("tutorialImage_1")
                                .resizable()
                                .scaledToFit()
                            
                        }
                        .tag(1)
                        
                        // MARK: TUTORIAL VIEW _ 2
                        VStack{
                            Text("タップで撮影")
                                .bold()
                                .font(.title)
                                .foregroundColor(Color.MyThemeColor.accentColor)
                                .padding()
                            ZStack{
                                Image("tutorialImage_1")
                                    .resizable()
                                    .scaledToFit()
                                
                                Image(systemName: "hand.tap.fill")
                                    .font(.system(size: 120))
                                    .foregroundColor(.orange)
                                
                            }
                        }
                        .tag(2)
                        
                        // MARK: TUTORIAL VIEW _ 3
                        VStack{
                            // too long
                            Text("データを安全保存")
                                .bold()
                                .font(.title)
                                .foregroundColor(Color.MyThemeColor.accentColor)
                                .padding()
                            Image("tutorialImage_3")
                                .resizable()
                                .scaledToFit()
                        }
                        .tag(3)
                        
                        // MARK: TUTORIAL VIEW _ 5
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Let's Start".uppercased())
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.all, 30)
                                .background(Color.MyThemeColor.accentColor)
                                .cornerRadius(10)
                                .shadow(radius: 20)
                        })
                        .tag(4)
                        
                        // MARK: TUTORIAL VIEW _ 6
                        VStack{
                            Spacer()
                        }
                        .tag(5)
                    })
                .tabViewStyle(PageTabViewStyle())
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
