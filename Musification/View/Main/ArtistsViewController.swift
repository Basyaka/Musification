//
//  ArtistsViewController.swift
//  Musification
//
//  Created by Vlad Novik on 8.04.21.
//

import UIKit
import RxSwift

class ArtistsViewController: UIViewController {
    
    var viewModel: ArtistsViewModel!
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Properties
    var input: ArtistsViewModel.Input {
        return ArtistsViewModel.Input()
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        bind(output: viewModel.transform(input))
    }
    
    //MARK: - Helpers functions
    private func bind(output: ArtistsViewModel.Output) {
        
    }
}

