//
//  BitbucketDetailViewController.swift
//  BitbucketRepo
//
//  Created by KoingDev on 9/2/20.
//  Copyright © 2020 koing.dev. All rights reserved.
//

import UIKit

class BitbucketDetailViewController: UIViewController {
    
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var openWebsiteButton: UIButton!
    private let showWebsiteIdentifier = "showWebsite"
    var bitbucket: Bitbucket?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let bitbucket = bitbucket {
            textView.text = """
            Name: \(bitbucket.name)\n\n
            Description: \(bitbucket.description)\n\n
            Type: \(bitbucket.type)\n\n
            Language: \(bitbucket.language)\n\n
            Size: \(bitbucket.size)\n\n
            Website: \(bitbucket.website)\n\n
            """
            
            openWebsiteButton.isHidden = bitbucket.website.isEmpty
        }
    }
    
    @IBAction func openWebsitePressed(_ sender: Any) {
        performSegue(withIdentifier: showWebsiteIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showWebsiteIdentifier {
            guard let website = bitbucket?.website, let url = URL(string: website), let controller = segue.destination as? BitbucketWebViewController else { return }
            controller.url = url
        }
    }
    
}
