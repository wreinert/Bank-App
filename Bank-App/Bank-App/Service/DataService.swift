//
//  FetchDataService.swift
//  Bank-App
//
//  Created by William Reinert on 28/07/22.
//

import Foundation
import Alamofire

class DataService {
    
    // Mover transactions e userInfo para os respectivos presenters - OK
    
    func fetchStatement (url: URL, completion: @escaping (Result<[PaymentModel], Error>) -> Void) {
        AF.request(url).validate().responseDecodable(of: [PaymentModel].self) { response in
            guard let transactions = response.value else {
                return
            }
            completion(.success(transactions))
        }
    }
    
    func fetchUserInfo (url: URL, completion: @escaping (Result<[UserModel], Error>) -> Void) {
        AF.request(url).validate().responseDecodable(of: [UserModel].self) { response in
            guard let userInfo = response.value else {
                return
            }
            completion(.success(userInfo))
        }
    }
    
   
}


                                          
