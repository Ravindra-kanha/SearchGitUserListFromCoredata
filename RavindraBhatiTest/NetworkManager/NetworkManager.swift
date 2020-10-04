//
//  NetworkManager.swift
//  RavindraBhatiSwiftApp
//
//  Created by Apple on 20/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

// BaseUrl:- To point out the server url to retrieve and Send Information on the Server
public enum BaseUrl: String{
   case gitHub = "https://api.github.com/"
}


//APIEndPoints:- End Point of the api to access Specific Information.
public enum APIEndPoints: String{
    case searchUser                        = "search/users?q="
}
