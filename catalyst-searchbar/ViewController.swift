//
//  ViewController.swift
//  
//  Created by Turker Nessa Kucuk on 8/30/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import UIKit
import Composure

class ViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet private weak var mainCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>! //
    private var allTags = [TagViewModel]()
    private var displayedTags = [TagViewModel]()
    private let customDispatchQueue = DispatchQueue(label: "topDomain.company.app.dispatchqueue.custom")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureCollectionView()
        configureNotificationListening()
        initiateDataDownload()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configureNotificationListening() {
        NotificationCenter.default.addObserver(self, selector: #selector(userPerformedSearch(_:)), name: CustomNotification.toolbarSearchBarTextChanged.name, object: nil)
    }

    private func configureCollectionView() {
        mainCollectionView.collectionViewLayout = generateCompositionalLayout(with: TagsLayoutSection.allCases)
        mainCollectionView.register(TagCell.nib, forCellWithReuseIdentifier: TagCell.nibName)
        getDataSource(with: mainCollectionView)
        mainCollectionView.delegate = self
    }
    
    private func getDataSource(with collectionView: UICollectionView) {
        self.dataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: collectionView) { [weak self] (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) -> UICollectionViewCell? in
            guard let strongSelf = self else { return nil }
            guard let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.nibName, for: indexPath) as? TagCell else { return nil }
            let tagViewModel = strongSelf.displayedTags[indexPath.item]
            tagCell.configure(with: tagViewModel)
            return tagCell
        }
    }
    
    private func loadDataIntoSnapshot() {
        var currentSnapshot = NSDiffableDataSourceSnapshot<Int, String>()
        currentSnapshot.appendSections([0])
        currentSnapshot.appendItems(displayedTags.map { $0.id}, toSection: 0)
        dataSource?.apply(currentSnapshot, animatingDifferences: true)
    }
    
    
    private func initiateDataDownload() {
        customDispatchQueue.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf._downloadData()
        }
    }
    
    private func _downloadData() {
        allTags.append(TagViewModel(name: "artisan", hexColor: "B312FB"))
        allTags.append(TagViewModel(name: "accident", hexColor: "9A5A35"))
        allTags.append(TagViewModel(name: "session", hexColor: "657C1D"))
        allTags.append(TagViewModel(name: "meat", hexColor: "EBCABB"))
        allTags.append(TagViewModel(name: "development", hexColor: "037B67"))
        allTags.append(TagViewModel(name: "priority", hexColor: "233227"))
        allTags.append(TagViewModel(name: "ratio", hexColor: "43C3A2"))
        allTags.append(TagViewModel(name: "management", hexColor: "70FCD6"))
        allTags.append(TagViewModel(name: "thanks", hexColor: "D7425F"))
        allTags.append(TagViewModel(name: "conclusion", hexColor: "2DCA84"))
        allTags.append(TagViewModel(name: "guitar", hexColor: "621802"))
        allTags.append(TagViewModel(name: "potato", hexColor: "65ED82"))
        allTags.append(TagViewModel(name: "employment", hexColor: "7C2AA6"))
        allTags.append(TagViewModel(name: "height", hexColor: "466E45"))
        allTags.append(TagViewModel(name: "collection", hexColor: "F277C"))
        allTags.append(TagViewModel(name: "highway", hexColor: "821CBE"))
        allTags.append(TagViewModel(name: "emotion", hexColor: "7C0250"))
        allTags.append(TagViewModel(name: "bedroom", hexColor: "D4759B"))
        allTags.append(TagViewModel(name: "weakness", hexColor: "C43A75"))
        allTags.append(TagViewModel(name: "leadership", hexColor: "4AAF"))
        allTags.append(TagViewModel(name: "policy", hexColor: "8294DB"))
        allTags.append(TagViewModel(name: "affair", hexColor: "903BF2"))
        allTags.append(TagViewModel(name: "poet", hexColor: "E46CF9"))
        allTags.append(TagViewModel(name: "health", hexColor: "C65FE1"))
        allTags.append(TagViewModel(name: "relation", hexColor: "04E890"))
        allTags.append(TagViewModel(name: "boyfriend", hexColor: "E3FBF4"))
        allTags.append(TagViewModel(name: "director", hexColor: "4AB4DA"))
        allTags.append(TagViewModel(name: "republic", hexColor: "3A52DC"))
        allTags.append(TagViewModel(name: "celebration", hexColor: "DC619E"))
        allTags.append(TagViewModel(name: "police", hexColor: "859D32"))
        allTags.append(TagViewModel(name: "guidance", hexColor: "F64F92"))
        allTags.append(TagViewModel(name: "youth", hexColor: "E2A640"))
        allTags.append(TagViewModel(name: "night", hexColor: "9EB468"))
        allTags.append(TagViewModel(name: "assignment", hexColor: "C2152"))
        allTags.append(TagViewModel(name: "resource", hexColor: "AF3BE"))
        allTags.append(TagViewModel(name: "volume", hexColor: "D4846D"))
        allTags.append(TagViewModel(name: "recipe", hexColor: "F43159"))
        allTags.append(TagViewModel(name: "association", hexColor: "A151C7"))
        allTags.append(TagViewModel(name: "inspection", hexColor: "EA376F"))
        allTags.append(TagViewModel(name: "introduction", hexColor: "84711A"))
        allTags.append(TagViewModel(name: "professor", hexColor: "B131D7"))
        allTags.append(TagViewModel(name: "mixture", hexColor: "C4E83E"))
        allTags.append(TagViewModel(name: "requirement", hexColor: "A01EFA"))
        allTags.append(TagViewModel(name: "location", hexColor: "A07092"))
        allTags.append(TagViewModel(name: "midnight", hexColor: "552DE4"))
        allTags.append(TagViewModel(name: "queen", hexColor: "C7FEB7"))
        allTags.append(TagViewModel(name: "tension", hexColor: "48BD6B"))
        allTags.append(TagViewModel(name: "excitement", hexColor: "FEF01F"))
        allTags.append(TagViewModel(name: "event", hexColor: "0210AC"))
        allTags.append(TagViewModel(name: "story", hexColor: "A9AFA4"))
        
        displayedTags.append(contentsOf: allTags)
        
        loadDataIntoSnapshot()
    }
    
    @objc func didClickOnFavorites(_ sender: Any?) {
        print("user clicked on favorites button")
    }
    
    @objc func userPerformedSearch(_ notification: Notification) {
        if let searchedText = notification.object as? String {
            customDispatchQueue.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.apply(searchQuery: searchedText)
            }
        }
    }
    
    private func apply(searchQuery: String) {
        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString = searchQuery.trimmingCharacters(in: whitespaceCharacterSet)
        
        if strippedString.count == 0 {
            displayedTags = allTags
        } else {
            let searchComponents = strippedString.components(separatedBy: CharacterSet.whitespacesAndNewlines)
            
            displayedTags = allTags.filter { eachViewModel -> Bool in
                
                //assume first we should include this language
                var shouldIncludeThisViewModel = true
                
                //only include this language if all the search components are contained
                //this makes an "AND" search
                for eachSearchComponent in searchComponents {
                    let searchComponentContained = eachViewModel.name.localizedCaseInsensitiveContains(eachSearchComponent)
                    if !searchComponentContained {
                        shouldIncludeThisViewModel = false
                        break
                    }
                }
                return shouldIncludeThisViewModel
                
            }
        }
        loadDataIntoSnapshot()
    }
}

