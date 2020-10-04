//
//  UserListViewModel.swift
//  RavindraBhatiSwiftApp
//
//  Created by Apple on 20/08/20.
//  Copyright © 2020 Apple. All rights reserved.

import Foundation
import Combine
import SwiftUI


//MARK: UserListViewModel
/// Handle all the activities regarding the UserList in  and perform operation on the User List
/// CoreDataManager:- To implement core data Operation on the  User List  to ge variant Information.
class UserListViewModel: CoreDataManager, ObservableObject{
    
    //MARK: Properties

    /// state:- to maintain user List information
    @Published private(set) var state = State()
    
    // userList: user List reference in the allocation area.
     private var userList = Set<AnyCancellable>()
    
}

extension UserListViewModel{
    
    // State to contain information about the userList and Page Number of the List  or can be load More pages in the list or not.
    struct State {
        var userList: [UserList] = []
        var page: Int = 1
        var canLoadNextPage = true
    }

    
    
    /// fetchNextPageIfPossible:- Fetch Possible Pages from the url
    /// - Parameter userName: Get Information of the user using the User Name.
    func fetchNextPageIfPossible(_ userName: String?) {
           guard state.canLoadNextPage else { return }
           UserListAPI.getUserListResponse(userName, page: state.page)
           .sink(receiveCompletion: onReceive, receiveValue: onReceive)
           .store(in: &userList)

       }
    
    
    /// fetchDataFromLocal
    /// - Parameter userName: perform operation on the local data base and  get variant Information from the Local storage.
    func fetchDataFromLocal(_ userName: String){
        let userNamePredicate =   NSPredicate(format: "login CONTAINS[cd] %@", userName)
        guard let searchedUser =  query(UserList.self, search: userNamePredicate, sort: nil, multiSort: nil) else { return  }
        state.userList =  searchedUser
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
    /// - Parameter batch: to pass information in the State information  and pass the User List.
    private func onReceive(_ batch: [UserList]) {
        state.userList += batch
        state.page += 1
        state.canLoadNextPage = batch.count == UserListAPI.pageSize
    }
}

//MARK: UserListAPI to get all the user Information from the Api.
enum UserListAPI{

    static let pageSize = 10

    static func getUserListResponse(_ userName: String?, page: Int?) -> AnyPublisher<[UserList], Error>{

        let gitUserName = userName?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        let userListUrl = BaseUrl.gitHub.rawValue + APIEndPoints.searchUser.rawValue + "\(gitUserName ?? "")&page=\(page ?? 1)"

        let url = URL(string: userListUrl)!
        var userListData: Data?
        let userListRequest = URLRequest(url: url)

        return URLSession.shared.dataTaskPublisher(for: userListRequest)
            .handleEvents(receiveOutput: {
                let jsonResponse = try? JSONSerialization.jsonObject(with: $0.data, options: .mutableLeaves) as? [String: Any]
                
                if let jsonList = jsonResponse?["items"] {
                    if let jsonData = try? JSONSerialization.data(withJSONObject: jsonList, options: []){
                        print(jsonData)
                        userListData = jsonData
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
                    
                    let userList  = try decoder.decode([UserList].self, from: userListData ?? Data())
                    try managedObjectContext.save()
                    print(userList)
                    return userList
                } catch {
                   print(error)
                }
                return [UserList]()
        }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
