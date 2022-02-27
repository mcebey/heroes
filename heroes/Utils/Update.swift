//
//  Update.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 26/2/22.
//

import Foundation
import UIKit

@propertyWrapper
struct PublishEmitter<T> {
    var data: Binding<T>

    init(_ initialValue: T ) {
        self.data = Binding<T>(initialValue)
    }

    var wrappedValue: Binding<T> { data }
    var projectedValue: PublishEmitter<T> {
        get { return self }
        mutating set { self = newValue }
    }

    func bind(listener: ((T) -> Void)?) {
        data.bind(listener: listener)
    }
}



//
//@PublishEmitter var rss: Observable<[Rss]>
//
///// @mockable
//protocol SocialNetworkViewModelProtocol {
//    var rss: Observable<[Rss]> { get }
//    var isLoading: Observable<Bool> { get }
//
//    var action: PublishSubject<RssView.Action> { get }
//}
//
//
//@propertyWrapper struct PublishEmitter<T> {
//    private let eventEmitter = PublishSubject<T>()
//    var wrappedValue: Observable<T> { eventEmitter }
//    var projectedValue: PublishEmitter<T> {
//        get { return self }
//        mutating set { self = newValue }
//    }
//
//    func onNext(_ element: T) {
//        eventEmitter.onNext(element)
//    }
//
//    func onError(_ error: Error) {
//        eventEmitter.onError(error)
//    }
//
//    func onCompleted() {
//        eventEmitter.onCompleted()
//    }
//
//    func asObservable() -> Observable<T> {
//        eventEmitter.asObservable()
//    }
//
//    func asObserver() -> AnyObserver<T> {
//        eventEmitter.asObserver()
//    }
//}
