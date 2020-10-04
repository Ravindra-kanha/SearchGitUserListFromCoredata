//
//  FollowerListViewModel.swift
//  RavindraBhatiSwiftApp
//
//  Created by Apple on 21/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

//MARK: FollowerListViewModel
/// Handle all the activities regarding the FollowerList in  and perform operation on the FollowerList.
/// CoreDataManager:- To implement core data Operation on the  FollowerList  to ge variant Information.
class FollowerListViewModel: CoreDataManager, ObservableObject{
    
    //MARK: Properties

    /// state:- to maintain user List information
    @Published private(set) var state = State()
    
    // followerList: follower List reference in the allocation area.
    private var followerList = Set<AnyCancellable>()
    
}

extension FollowerListViewModel{
    
    
      // State to contain information about the userList and Page Number of the List  or can be load More pages in the list or not.
    struct State {
        var followerList: [FollowerList] = []
        var page: Int = 1
        var canLoadNextPage = true
    }

    /// fetchNextPageIfPossible:- Fetch Possible Pages from the url
       /// - Parameter userName: Get Information of the user using the following Url
    func fetchNextPageIfPossible(_ followerUrl: String) {
            guard state.canLoadNextPage else { return }
            FollowerListAPI.getFollowerListResponse(followerUrl, page: state.page)
            .sink(receiveCompletion: onReceive, receiveValue: onReceive)
            .store(in: &followerList)
        }
    
    /// fetchDataFromLocal
    func fetchDataFromLocal(){
        guard let searchedFollowerUser =  query(FollowerList.self, search: nil, sort: nil, multiSort: nil) else { return  }
        state.followerList =  searchedFollowerUser
    }
    
    /// onReceive :- Get Information from the  Url Session .
    /// - Parameter completion: give the reference and task information about to load more or not.
        private func onReceive(_ completion: Subscribers.Completion<Error>) {
            switch completion {
            case .finished:
                break
            case .failure:
                state.canLoadNextPage = false
            }
        }
    
    /// onReceive
     /// - Parameter batch: to pass information in the State information  and pass the Follower List.
        private func onReceive(_ batch: [FollowerList]) {
            state.followerList += batch
            state.page += 1
            state.canLoadNextPage = batch.count == FollowerListAPI.pageSize
        }
}

//MARK: FollowerListAPI to get all the Follower List Information from the Api.
enum FollowerListAPI{

    static let pageSize = 10

    static func getFollowerListResponse(_ followerUrl: String?, page: Int?) -> AnyPublisher<[FollowerList], Error>{
        let url = URL(string: followerUrl ?? "")!
        var followerListData: Data?
        let followerListRequest = URLRequest(url: url)

        return URLSession.shared.dataTaskPublisher(for: followerListRequest)
            .handleEvents(receiveOutput: {
                let jsonResponse = try? JSONSerialization.jsonObject(with: $0.data, options: .allowFragments) as? [Any]
                
                if let jsonList = jsonResponse{
                    if let jsonData = try? JSONSerialization.data(withJSONObject: jsonList, options: []){
                        print(jsonData)
                        followerListData = jsonData
                    }
                }
            })
            .tryMap { _ in
                             
                do {
                    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context else {
                        fatalError("Failed to retrieve managed object context")
                    }
                    let managedObjectContext = CoreDataManager.shared.manageObjectContext
                    let decoder = JSONDecoder()
                    decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
                    let followerList  = try decoder.decode([FollowerList].self, from: followerListData ?? Data())
                    try managedObjectContext.save()
                    return followerList
                } catch {
                   print(error)
                }
                return [FollowerList]()
        }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
