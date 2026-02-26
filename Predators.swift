import Foundation

class Predators {
    var masterApexPredators : [ApexPredator ] = []
    var apexPredators : [ApexPredator] = []
    
    init () {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData () {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                masterApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = masterApexPredators
            } catch {
                print("Error decoding JSON data : \(error)")
            }
        }
    }
    
    func sort(by alphabeticalOrder: Bool) {
        apexPredators.sort { predator1 , predator2 in
            if alphabeticalOrder {
                predator1.name < predator2.name
            } else {
                predator1.id < predator2.id
            }
        }
    }
    func filter (by type : ApexPredator.APType) {
        if type == .all {
            apexPredators = masterApexPredators
        }else {
            apexPredators = masterApexPredators.filter { predator in
                predator.type == type
            }
        }
    }
}
