//
//  RewardViewController.swift
//  mc2apps
//
//  Created by Agnes Felicia on 26/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit


class RewardViewController: UIViewController {

    @IBOutlet weak var rewardCollectionView: UICollectionView!
    @IBOutlet weak var wantButton: UIButton! {
        didSet {
            wantButton.layer.cornerRadius = 27.5
        }
    }
    
    var rewards = Rewards.fetchReward()
    var cellScale: CGFloat = 0.6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showFirstAlert()
        setLayout()
        
        rewardCollectionView.dataSource = self
        rewardCollectionView.register(UINib(nibName: "RewardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RewardCollectionViewCell")
    }
    
    func showFirstAlert() {
        let alert = UIAlertController(title: "Recommendation" , message: "Here’s some recommendation from us for ‘Self Reward’", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setLayout() {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScale)
        let cellHeight = floor(screenSize.height * cellScale)
        let instX = (view.bounds.width - cellWidth) / 2.0
        let instY = (view.bounds.height - cellHeight) / 2.0
        let layout = rewardCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        rewardCollectionView.contentInset = UIEdgeInsets(top: instY, left: instX, bottom: instY, right: instX)
        
    }
    
    @IBAction func wantButtonClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Reward Selected", message: "Please enjoy this reward", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default) { _ in
            self.popBack(4)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension RewardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rewards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RewardCollectionViewCell", for: indexPath) as! RewardCollectionViewCell
        
        let reward = rewards[indexPath.item]
        cell.reward = reward
        
        return cell
    }
    
}
