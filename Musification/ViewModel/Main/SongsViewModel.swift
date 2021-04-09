//
//  SongsViewModel.swift
//  Musification
//
//  Created by Vlad Novik on 9.04.21.
//

import RxSwift
import RxCocoa

final class SongsViewModel: ViewModelType {
    
    private var disposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        
        return Output.init()
    }
}

extension SongsViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
}
