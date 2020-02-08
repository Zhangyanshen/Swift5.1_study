//
//  ViewController.swift
//  TestiOS
//
//  Created by 张延深 on 2020/1/2.
//  Copyright © 2020 张延深. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum DataError: Error {
    case cantParseJSON(String)
}

class ViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var usernameValidLbl: UILabel!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var passwordValidLbl: UILabel!
    @IBOutlet weak var doSomethingBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 用户名是否有效
        let usernameValid = usernameTxt.rx.text.orEmpty
            .map { $0.count >= 5 }
            .share(replay: 1, scope: .forever)
        // 用户名提示语是否隐藏
        usernameValid
            .bind(to: usernameValidLbl.rx.isHidden)
            .disposed(by: disposeBag)
        
        // 密码是否有效
        let passwordValid = passwordTxt.rx.text.orEmpty
            .map { $0.count >= 5 }
            .share(replay: 1, scope: .whileConnected)
        // 密码提示语是否隐藏
        passwordValid
            .bind(to: passwordValidLbl.rx.isHidden)
            .disposed(by: disposeBag)
        
        // 所有输入是否有效
        let everythingValid = Observable
            .combineLatest(usernameValid, passwordValid) {  $0 && $1 }
            .share(replay: 1, scope: .whileConnected)
        // 绿色按钮是否可点击
        everythingValid
            .bind(to: doSomethingBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        // 点击绿色按钮 -> 弹出提示框
        doSomethingBtn.rx.tap
            .subscribe(onNext: {
                [weak self] in
                self?.showAlert()
            })
            .disposed(by: disposeBag)
        
//        singleTest()
//        completableTest(1)
//        completableTest(0)
        maybeTest(1)
        maybeTest(2)
        maybeTest(3)
        maybeTest(5)
    }
    
    /*
     1.Single
     - 发出一个元素或一个error元素
     - 不会共享附加作用
     */
    func singleTest() {
        let single = Single<[String: Any]>.create { single in
            let url = URL(string: "https://api.github.com/repos/ReactiveX/RxSwift")!
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error {
                    single(.error(error))
                    return
                }
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                      let result = json as? [String: Any] else
                {
                    single(.error(DataError.cantParseJSON("不能解析json")))
                    return
                }
                single(.success(result))
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
        single.subscribe(onSuccess: { json in
            print("JSON:", json)
        }) { error in
            print("Error:", error)
        }.disposed(by: disposeBag)
    }
    
    /*
     2.Completable：只关心任务是否完成，而不需要在意任务返回值。它和 Observable<Void> 有点相似。
     - 发出0个元素
     - 发出一个completed事件或一个error事件
     - 不会共享附加作用
     */
    func completableTest(_ num: Int) {
        let completable = Completable.create { completable in
            if num % 2 == 0 {
                completable(.error(DataError.cantParseJSON("出错了")))
                return Disposables.create()
            }
            completable(.completed)
            return Disposables.create()
        }
        completable.subscribe(onCompleted: {
            print("Completed!")
        }) { error in
            print("Error:", error)
        }.disposed(by: disposeBag)
    }
    
    /*
     3.Maybe：如果你遇到那种可能需要发出一个元素，又可能不需要发出时，就可以使用 Maybe。
     - 发出一个元素或者一个completed事件或者一个error事件
     - 不会共享附加作用
     */
    func maybeTest(_ num: Int) {
        let maybe = Maybe<String>.create { maybe in
            if num % 2 == 0 {
                maybe(.success("RxSwift"))
                return Disposables.create()
            }
            if num % 3 == 0 {
                maybe(.completed)
                return Disposables.create()
            }
            maybe(.error(DataError.cantParseJSON("出错了！")))
            return Disposables.create()
        }
        maybe.subscribe(onSuccess: { element in
            print("Success:", element)
        }, onError: { error in
            print("Error:", error)
        }) {
            print("Completed")
        }.disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "RxExample", message: "This is amazing!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}



