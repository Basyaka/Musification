//
//  SongsViewController.swift
//  Musification
//
//  Created by Vlad Novik on 8.04.21.
//

import UIKit
import RxSwift

class SongsViewController: UIViewController {
    
    var viewModel: SongsViewModel!
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Properties
    var input: SongsViewModel.Input {
        return SongsViewModel.Input()
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        bind(output: viewModel.transform(input))
        
    }
    
    //MARK: - Helpers functions
    private func bind(output: SongsViewModel.Output) {
        
    }
}



