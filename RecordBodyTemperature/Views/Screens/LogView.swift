//
//  LogView.swift
//  RecordBodyTemperature
//
//  Created by 神村亮佑 on 2021/02/01.
//


import SwiftUI

struct LogView: View {
    @EnvironmentObject var  bodyTmpStore: BodyTmpStore
    
    var body: some View {
        VStack{
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
                ForEach(bodyTmpStore.bodyTmps){ bodyTmp in
                    
                    HStack(alignment: .center, spacing: 20, content : {
                        Image(uiImage: FileHelper.instance.getSavedImage(fileName: String(bodyTmp.id)))
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(20)
                        VStack(alignment: .center, spacing: 10){
                            Text(DateHelper.instance.date2String(date: bodyTmp.dateCreated))
                                .font(.callout)
                            Text("体温:\(bodyTmp.bodyTemperature)℃")
                                .font(.headline)
                        }
                        .padding([.horizontal], 20)
                    })
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(20)
                    .contextMenu {
                        Button(action: {
                            //MARK: TODO - 削除ボタン
                            bodyTmpStore.deleteData(object: bodyTmp)
                        }, label: {
                            Text("削除")
                        })
                    }
                }
                .padding()
            }
            Spacer()
        }
        .padding()
        .onAppear(perform: {
            bodyTmpStore.fetchData()
            print("fetchData終わったよ")
        })
        
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
    }
}
