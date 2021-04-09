//
//  AlbumsViewController.swift
//  Musification
//
//  Created by Vlad Novik on 8.04.21.
//

import UIKit
import RxSwift

class AlbumsViewController: UIViewController {
    
    var viewModel: AlbumsViewModel!
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Properties
    var input: AlbumsViewModel.Input {
        return AlbumsViewModel.Input()
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        bind(output: viewModel.transform(input))
    }
    
    //MARK: - Helpers functions
    private func bind(output: AlbumsViewModel.Output) {
        
    }
}
