//
//  SearchTableViewController.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 27/05/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//
import Foundation
import UIKit
import Speech

class SearchTableViewController: UITableViewController {
    
    var viewModel: SearchViewType?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let audioSearchButton = AudioSearchButton()
    //needs to work with input and output audioData
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru"))
//    let supportedLocales = SFSpeechRecognizer.supportedLocales()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = SearchViewModel()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите поисковый запрос"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        setAudioSearchButtonOnKeyboard()
        
        searchController.searchBar.scopeButtonTitles = viewModel?.getArrayOfGroupNames()

        searchController.searchBar.delegate = self
 
        tableView.tableFooterView = UIView(frame: CGRect.zero)

    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let model = viewModel else { return 0 }
        if isFiltering() {
            return model.numberOfFilteredRows
        } else {
            return model.numberOfRows
        }
        
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCellId", for: indexPath) as? SearchTableViewCell

        guard let tableViewCell = cell, let model = viewModel else { return UITableViewCell() }
        if isFiltering() {
            tableViewCell.searchCellViewModel = model.getFilteredCellViewModel(forIndexPath: indexPath)
        } else {
            tableViewCell.searchCellViewModel = model.getCellViewModel(forIndexPath: indexPath)
        }

        return tableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let model = viewModel else { return }
        model.selectedIndexPath(forIndexPath: indexPath)
        
        performSegue(withIdentifier: "showItemDetailFromSearchScreen", sender: nil)
    }

    func setAudioSearchButtonOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        audioSearchButton.setImage(UIImage(named: "Compass-iphone"), for: .normal)
        audioSearchButton.addTarget(self, action: #selector(audioSearchButtonTapped), for: .touchUpInside)
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let audioSearchBarButton = UIBarButtonItem(customView: audioSearchButton)
        
//        let audioSearchBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(activateAudioSearch))
//        audioSearchBarButton
        audioSearchBarButton.image = UIImage(named: "Compass-iphone")
        keyboardToolbar.items = [flexBarButton, audioSearchBarButton]
        self.searchController.searchBar.inputAccessoryView = keyboardToolbar
    }
    
    @objc func audioSearchButtonTapped() {
        activateAudioSearching()
        //TO-DO: show popOver information menu
        
        if SFSpeechRecognizer.authorizationStatus() == .authorized {
            audioSearchButton.buttonIsOn = !audioSearchButton.buttonIsOn
            if !audioSearchButton.buttonIsOn {
                self.searchController.searchBar.placeholder = "Search recognition is activated: button is on"
                print("button is on")
                audioEngine.stop()
                request.endAudio()
                recognitionTask?.cancel()
            } else {
                self.searchController.searchBar.placeholder = "Search recognition is activated: button is off"
                print("button is off")
                startRecognition()
            }
        }
    }
    
    func activateAudioSearching() {
        SFSpeechRecognizer.requestAuthorization { [unowned self](status) in
            switch status {
            case .authorized:
                //when user accepted
                DispatchQueue.main.async {
                    [unowned self] in
                    self.searchController.searchBar.placeholder = "Search recognition is activated"
                }
            case .denied:
                //when user denied
                print("Status is denied")
            case .notDetermined:
                //when user not decided yet
                print("Status not determined")
            case .restricted:
                //when device is not supported this method
                print("Status restricted")
            }
        }
    }
    
    fileprivate func startRecognition() {
        let node = audioEngine.inputNode
        let recognitionFormat = node.outputFormat(forBus: 0)
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recognitionFormat) { [unowned self](buffer, audioTime) in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch let error {
            print("\(error.localizedDescription)")
            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: {[unowned self](result, error) in
            if let res = result {
                DispatchQueue.main.async {
                    [unowned self] in
                    self.searchController.searchBar.text = res.bestTranscription.formattedString
                }
                if res.isFinal {
                    node.removeTap(onBus: 0)
                }
            } else if let error = error {
                print("\(error.localizedDescription)")
                node.removeTap(onBus: 0)
            }
        })
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let model = viewModel else { return }
        if identifier == "showItemDetailFromSearchScreen" {
            if let dvc = segue.destination as? DetailViewController {
                dvc.screenViewModel = model.getDetailScreenViewModelForSelectedRow()
            }
        }
    }

}

extension SearchTableViewController: UISearchBarDelegate, UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        guard let model = viewModel else { return }
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = "#\(searchController.searchBar.text!)"
        model.updateFilteredItems(withText: searchText, scope: scope)
        tableView.reloadData()

    }
    
    func updateSearchResults(for searchController: SearchControllerViewController) {
        guard let model = viewModel else { return }
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = "#\(searchController.searchBar.text!)"
        model.updateFilteredItems(withText: searchText, scope: scope)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard let model = viewModel else { return }
        let searchText = "#\(searchController.searchBar.text!)"
        model.updateFilteredItems(withText: searchText, scope: searchBar.scopeButtonTitles![selectedScope])
        tableView.reloadData()

    }
}
