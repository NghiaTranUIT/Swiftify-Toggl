//
//  NetworkService.swift
//  DesktopCore
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Foundation
import RxSwift

public enum Result<T> {

    case success(T)
    case error(NetworkError)

    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
}

public protocol NetworkServiceType {

    func request<T: Serializable>(_ route: APIRoute, modelType: T.Type) -> Observable<Result<T>>
}

public enum NetworkError: Error {
    case serverError(Error)
    case serializeFailed
}

public protocol NetworkFetcher {

    func fetch(with urlRequest: URLRequest, complete: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkFetcher {

    public func fetch(with urlRequest: URLRequest, complete: @escaping (Data?, Error?) -> Void) {
        let task = self.dataTask(with: urlRequest) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if 200...300 ~= httpResponse.statusCode {
                    complete(data, nil)
                    return
                } else {
                    let error = NSError(domain: "com.toggl", code: httpResponse.statusCode, userInfo: nil)
                    complete(nil, error)
                    return
                }
            }
            complete(data, error)
        }

        task.resume()
    }
}

public final class NetworkService: NetworkServiceType {

    // MARK: - Variable
    private let fetcher: NetworkFetcher

    // MARK: - Init
    public init(fetcher: NetworkFetcher) {
        self.fetcher = fetcher
    }

    public func request<T: Serializable>(_ route: APIRoute, modelType: T.Type) -> Observable<Result<T>> {
        return Observable.create({[unowned self] (observer) -> Disposable in
            let urlRequest = route.urlRequest
            self.fetcher.fetch(with: urlRequest) { (data, error) in

                // Error
                if let error = error {
                    observer.onNext(Result<T>.error(NetworkError.serverError(error)))
                }

                // Success
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                        let apiResponse = APIResponse<T>.serialize(json!) {
                        observer.onNext(Result.success(apiResponse.data))
                    } else {
                        observer.onNext(Result<T>.error(NetworkError.serializeFailed))
                    }
                }
            }

            observer.onCompleted()
            return Disposables.create()
        })
    }
}
