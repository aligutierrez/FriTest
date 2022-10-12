//
//  JokesViewModel.swift
//  FriTest
//
//  Created by Ali Gutierrez on 10/11/22.
//

import Alamofire
import Foundation

class JokesViewModel {

    var session = URLSession.shared
    
    func fetchJokes(completion: @escaping (Joke) -> ()) {
        let request = AF.request("https://api.chucknorris.io/jokes/random")
        
        request.responseDecodable(of: Joke.self){ response in
            switch response.result {
            case .success(let joke):
                completion(joke)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
