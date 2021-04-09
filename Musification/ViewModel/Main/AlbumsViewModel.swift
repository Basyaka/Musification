//
//  AlbumsViewModel.swift
//  Musification
//
//  Created by Vlad Novik on 9.04.21.
//

import RxSwift
import RxCocoa

final class AlbumsViewModel: ViewModelType {
    
    private var disposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        
        return Output.init()
    }
}

extension AlbumsViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
}
