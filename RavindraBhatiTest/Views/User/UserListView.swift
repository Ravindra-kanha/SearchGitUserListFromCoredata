//  UserListView.swift
//  RavindraBhatiSwiftApp
//  Created by Apple on 21/08/20.
//  Copyright © 2020 Apple. All rights reserved.
import SwiftUI
import Combine

//MARK: UserListView
struct UserListView: View {
    
    //MARK: Properties
    @ObservedObject var viewModel = UserListViewModel()
    
    // User name to get Information of the specific user
    var userName: String
    
    // Body
    var body: some View {
        
        UserLists(userList: viewModel.state.userList, isLoading: viewModel.state.canLoadNextPage) {
            self.viewModel.fetchNextPageIfPossible(self.userName)
            
        }.environmentObject(self.viewModel)
            .onAppear(perform: {
                DispatchQueue.main.async {
                    // to check internet Connectivity
                    guard Reachability.isConnectedToNetwork() == true else{
                        // load user list from the local storage with the specific user
                        self.viewModel.fetchDataFromLocal(self.userName)
                        return
                    }
                    
                    // get user list from the web service
                    self.viewModel.fetchNextPageIfPossible(self.userName)
                }
            })
            
            .navigationBarTitle(Text("UserList"))
    }
}


//MARK: UserLists: User List container to get  information of the User.
struct UserLists: View{
    
    //MARK: Properties
    
    /// userList: userList List information.
    var userList: [UserList]
    
    //isLoading:  if load more information from the Web service or local.
    let isLoading: Bool
    
    // to check if user scroll at the bottom of the list
    let onScrolledAtBottom: () -> Void
    
    // viewModel: get information about the user.
    @EnvironmentObject var viewModel: UserListViewModel
    
    //MARK: Body
    var body: some View {
        
        List {
            usersList
            if isLoading {
                loadingIndicator
            }
        }
    }
    
    //MAR: follower List
    private var usersList: some View {
        
        ForEach(userList, id: \.self){ user in
            NavigationLink(destination: UserDetailsView(userDetails: user).environmentObject(self.viewModel)) {
                UserCell(user: user)
            }
            .onAppear {
                if self.userList.last == user {
                    self.onScrolledAtBottom()
                }
            }
        }
        .padding([.leading,.trailing], 5)
        .padding([.top, .bottom], 2)
        
    }
    
    private var loadingIndicator: some View {
        Spinner(style: .medium)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
        
    }
}
