//
//  ArtistsViewModel.swift
//  Musification
//
//  Created by Vlad Novik on 9.04.21.
//

import RxSwift
import RxCocoa

final class ArtistsViewModel: ViewModelType {
    
    private var disposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        
        return Output.init()
    }
}

extension ArtistsViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
}
