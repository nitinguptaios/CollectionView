//
//  Service.swift
//  Nitin_Gupta
//
//  Created by iPHSTech 34 on 14/05/22.
//

import Foundation

class Service: NSObject {

    
    static let shareInstance = Service()
    
    func getAllMovieData(completion: @escaping([DataModel]?, Error?) -> ()){
        let urlString = "https://fakestoreapi.com/products"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error{
                completion(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                do{
                    var arrayDataModel = [DataModel]()
                    
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode([DataModel].self, from: data)
                    
                    for data in responseModel {
                        arrayDataModel.append(DataModel.init(id: data.id!, title: data.title!, price: data.price!, description: data.description!, category: data.category!, image: data.image!, rating: data.rating!))
                    }
                    
                    completion(arrayDataModel, nil)
                }catch let jsonErr{
                    print("json error : \(jsonErr.localizedDescription)")
                }
            }
        }.resume()
    }
    
    
    
}
