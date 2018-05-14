//
//  ViewController.swift
//  ReactiveApp
//
//  Created by user on 5/13/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchResults = searchBar.rx.text.orEmpty
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[Repository]> in
                if query.isEmpty {
                    return .just([])
                }
                return searchGitHub(query)
                    .catchErrorJustReturn([])
            }
            .observeOn(MainScheduler.instance)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

