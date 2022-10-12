//
//  JokesTableViewCell.swift
//  FriTest
//
//  Created by Ali Gutierrez on 10/11/22.
//

import Nuke
import UIKit

class JokesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var jokeIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with joke: Joke) {
        jokeLabel.text = joke.value
        guard let url = URL(string: joke.iconURL) else { return }
        Nuke.loadImage(with: url, into: jokeIcon)
    }
}
