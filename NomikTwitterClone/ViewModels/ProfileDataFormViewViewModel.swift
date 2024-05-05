//
//  ProfileDataFormViewViewModel.swift
//  NomikTwitterClone
//
//  Created by Pinocchio on 2024/5/5.
//

import Foundation
import Combine


final class ProfileDataFormViewViewModel: ObservableObject {
    
    @Published var displayName: String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avartarPath: String?
}
