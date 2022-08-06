//
//  FetchDataService.swift
//  Bank-App
//
//  Created by William Reinert on 28/07/22.
//

import Foundation
import Alamofire

class DataService {
    
    var transactions: [Payments] = []
    var userInfo: [User] = []
    
    func fetchStatement (url: URL, completion: @escaping (Result<[Payments], Error>) -> Void) {
        AF.request(url).validate().responseDecodable(of: [Payments].self) { response in
            guard let transactions = response.value else {
                return
            }
            completion(.success(transactions))
        }
    }
    
    func fetchUserInfo (url: URL, completion: @escaping (Result<[User], Error>) -> Void) {
        AF.request(url).validate().responseDecodable(of: [User].self) { response in
            guard let userInfo = response.value else {
                return
            }
            completion(.success(userInfo))
        }
    }
    
   
}


                                          
