//
//  GameViewModel.swift
//  GameAPI
//
//  Created by Darell Legoferdanu on 16/04/21.
//

import Foundation
import Combine
import SwiftyJSON

class GameViewModel: ObservableObject {
  @Published var data = [Game]()
  
  init() {
    let url = ""
    
    let sessions = URLSession(configuration: .default)
    
    sessions.dataTask(with: URL(string: url)!){ (data, _, error) in
      //jika ada error
      if error != nil{
        print((error?.localizedDescription)!)
        return
      }
      
      let json = try! JSON(data: data!)
      let items = json["results"].array!
      
      for i in items{
        let title = i["name"].stringValue
        let released = i["released"].stringValue
        let image = i["background_image"].stringValue
        
        DispatchQueue.main.async {
          self.data.append(Game(title: title, image: image, released: released))
        }
      }
    }.resume()
  }
}
