//
//  JokesController.swift
//  Jokes
//
//  Created by Thomas Cacciatore on 7/6/21.
//

import Foundation

class JokesController {
    
    var jokes: [Joke] = [Joke(words: "Why did the chicken cross the road?"), Joke(words: "Another Joke")]
    var joke: Joke?
    
    init() {
        loadFromPersistentStore()
    }
    //create function to fetch a new joke
    //network call
//    let baseURL = URL(string: "https://icanhazdadjoke.com/")!
    let baseURL = URL(string: "https://jokes-with-at.herokuapp.com/")!

    func fetchJoke(completion: @escaping (Error?) -> Void) {
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching joke: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Error: no data returned")
                completion(NSError())
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let requestJoke = try decoder.decode(Joke.self, from: data)
                self.joke = requestJoke
                
                completion(nil)
            } catch {
                NSLog("Error decoding joke from data: \(error)")
                completion(error)
            }
        }.resume()
    }
    //create function to delete a joke
    func deleteJoke(index: Int) {
        jokes.remove(at: index)
        saveToPersistentStore()
        
    }
    //create function to save a joke
    func saveJoke(words: String) {
        let newJoke = Joke(words: words)
        jokes.append(newJoke)
        saveToPersistentStore()
        
    }
    
    func saveToPersistentStore() {
        guard let url = jokesURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let jokesData = try encoder.encode(jokes)
            try jokesData.write(to: url)
        } catch {
            print("Error Saving Jokes. Error: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = jokesURL, fileManager.fileExists(atPath: url.path)
        else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedJokes = try decoder.decode([Joke].self, from: data)
            jokes = decodedJokes
        } catch {
            print("Error loading data from disk: \(error)")
        }
    }
    
    private var jokesURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("jokes.plist")
    }
    
}
