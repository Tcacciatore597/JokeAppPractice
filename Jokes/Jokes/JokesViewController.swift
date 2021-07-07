//
//  JokesViewController.swift
//  Jokes
//
//  Created by Thomas Cacciatore on 7/6/21.
//

import UIKit

class JokesViewController: UIViewController {
    
    @IBOutlet weak var jokeTextView: UITextView!
    var jokesController: JokesController?
    var joke: Joke? {
        didSet {
            updateViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let joke = joke else { return }
        DispatchQueue.main.async {
            self.jokeTextView.text = joke.words
        }
    }
    

    @IBAction func getJokeButtonTapped(_ sender: Any) {
        jokesController?.fetchJoke(completion: { (error) in
            if let error = error {
                NSLog("Error fetching: \(error)")
                return
            }
            guard let newJoke = self.jokesController?.joke else { return }
            DispatchQueue.main.async {
                self.joke = newJoke
            }
        })
    }
    
    @IBAction func saveJokeButtonTapped(_ sender: Any) {
        guard let newJoke = joke?.words else { return }
        jokesController?.saveJoke(words: newJoke)
        self.jokeTextView.text = ""
    }
    
    // Animate bottom Label to appear and say "Saved!" then fade out.
    
}
