//
//  ProfileViewController.swift
//  Musification
//
//  Created by Vlad Novik on 8.04.21.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController {
    
    var viewModel: ProfileViewModel!
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Properties
    var input: ProfileViewModel.Input {
        return ProfileViewModel.Input()
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        bind(output: viewModel.transform(input))
    }
    
    //MARK: - Helpers functions
    private func bind(output: ProfileViewModel.Output) {
        
    }
}

