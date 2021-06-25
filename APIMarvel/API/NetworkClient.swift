import Foundation
import Alamofire

class NetworkClient {
    
    private let publicKey = "8ca7dac8fec2e7bfb749bc9766eaeb0e"
    private let privateKey = "b34b9ffc170991a55959da8ca6a61dee09f76080"
    private let baseUrl = "https://gateway.marvel.com"
    private let charactersPath = "/v1/public/characters"
    private let characterDetailPath = "/v1/public/characters/"
    
    private lazy var timestamp: Int = {
        return Int(Date().timeIntervalSince1970)
    }()
    
    private lazy var hash: String = {
        return md5Hash("\(timestamp)\(privateKey)\(publicKey)")
    }()
    
    func getCharacters(offset: Int, completion: @escaping (Result<CharacterResponse, NetworkError>) -> Void) {
        AF.request(
            "\(baseUrl)\(charactersPath)",
            method: .get,
            parameters: [
                "apikey": publicKey,
                "hash": hash,
                "ts": timestamp,
                "limit": 15,
                "offset": offset
            ]
        ).validate(statusCode: 200 ..< 299).responseJSON { serverResponse in
            guard serverResponse.error == nil else {
                completion(.failure(.serverError("Ha ocurrido algun error: \(serverResponse.error?.localizedDescription ?? "")")))
                return
            }
            guard let secureData = serverResponse.data else {
                completion(.failure(.dataError("Ha ocurrido algun error y no los datos no existen")))
                return
            }
            do {
                let json = try JSONDecoder().decode(CharacterResponse.self, from: secureData)
                //print(json.data?.results?[0])
                completion(.success(json))
            } catch {
                completion(.failure(.serializationError("Error: \(error.localizedDescription)")))
                return
            }
        }
    }
    
    func getCharacterDetail() {
        AF.request(
            "\(baseUrl)\(characterDetailPath)\(1017100)",
            method: .get,
            parameters: [
                "apikey": publicKey,
                "hash": hash,
                "ts": timestamp,
                "limit": 15,
                "offset": 0
            ]
        ).validate(statusCode: 200 ..< 299).responseJSON { serverResponse in
            guard serverResponse.error == nil else {
                //completion(.failure(.serverError("Ha ocurrido algun error: \(serverResponse.error?.localizedDescription ?? "")")))
                return
            }
            guard let secureData = serverResponse.data else {
                //completion(.failure(.dataError("Ha ocurrido algun error y no los datos no existen")))
                return
            }
            do {
                let json = try JSONDecoder().decode(CharacterResponse.self, from: secureData)
                print(json.data?.results?[0])
                //completion(.success(json))
            } catch {
                //completion(.failure(.serializationError("Error: \(error.localizedDescription)")))
                return
            }
        }
    }
    
    func getCharacterDetail(offset: Int, characterId: Int, completion: @escaping (Result<CharacterResponse, NetworkError>) -> Void) {
        AF.request(
            "\(baseUrl)\(characterDetailPath)\(1017100)",
            method: .get,
            parameters: [
                "apikey": publicKey,
                "hash": hash,
                "ts": timestamp,
                "limit": 15,
                "offset": offset
            ]
        ).validate(statusCode: 200 ..< 299).responseJSON { serverResponse in
            guard serverResponse.error == nil else {
                completion(.failure(.serverError("Ha ocurrido algun error: \(serverResponse.error?.localizedDescription ?? "")")))
                return
            }
            guard let secureData = serverResponse.data else {
                completion(.failure(.dataError("Ha ocurrido algun error y no los datos no existen")))
                return
            }
            do {
                let json = try JSONDecoder().decode(CharacterResponse.self, from: secureData)
                //print(json.data?.results?[0])
                completion(.success(json))
            } catch {
                completion(.failure(.serializationError("Error: \(error.localizedDescription)")))
                return
            }
        }
    }
}

enum NetworkError: Error, LocalizedError {
    case serverError(String)
    case dataError(String)
    case serializationError(String)
    
    public var errorDescription: String? {
        switch self {
        case .serverError(let description):
            return description
        case .dataError(let description):
            return description
        case .serializationError(let description):
        return description
        }
    }
}
