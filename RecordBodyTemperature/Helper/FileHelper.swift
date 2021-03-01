//
//  FileHelper.swift
//  RecordBodyTemperature
//
//  Created by 神村亮佑 on 2021/02/01.
//

import Foundation
import SwiftUI

struct FileHelper {
    
    static let instance = FileHelper()
    
    func saveImage(fileName: String ,image: UIImage, handler: @escaping (_ success: Bool) -> Void ) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("can't convert jpeg data")
            return
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            print("can't create directory")
            return
        }
        do {
            try imageData.write(to: directory.appendingPathComponent("\(fileName).jpeg"))
            handler(true)
        } catch {
            print(error.localizedDescription)
            handler(false)
        }
    }
    
    func getSavedImage(fileName: String) -> UIImage {
        if fileName == "123456"{
            return UIImage(named: "demoImage")!
        }else{
            if let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
                print("Exist File Directory")
                print("directory is -> \(directory)")
                //MARK: TODO - ERROR OCCURRED FROM BELOW!
                
                let directoryAndFileName = URL(fileURLWithPath: directory.absoluteString).appendingPathComponent("\(fileName).jpeg").path
                print(directoryAndFileName)
                return UIImage(contentsOfFile: URL(fileURLWithPath: directory.absoluteString).appendingPathComponent("\(fileName).jpeg").path)!
            }else{
                return UIImage(named: "logo")!
            }
        }
    }
}

