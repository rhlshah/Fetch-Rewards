

import Foundation

//The response from TheMealDB API contains header "meals" in all its responses so I'm using a generic struct for decoding the JSON
struct TheMealDBNetworkResponse<T:Codable>: Codable {
    var meals: T
}
