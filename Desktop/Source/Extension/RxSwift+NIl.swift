//
//  RxSwift+NIl.swift
//  Desktop
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Foundation
import RxSwift

extension Observable {

    func filterNil() -> Observable<Element> {
        return self.flatMap { Observable.from(optional: $0) }
    }
}
