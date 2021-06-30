//
//  ComicResponse.swift
//  APIMarvel
//
//  Created by admin on 29/6/21.
//

import Foundation

struct ComicResponse: Codable {
    let data: ComicData?
}

struct ComicData: Codable {
    let results: [ComicResult]?
}

struct ComicResult: Codable {
    let url: ApiURL?
    let thumbnail: Thumbnail?
}



/*{
    "results": [
      {
        "id": "int",
        "digitalId": "int",
        "title": "string",
        "issueNumber": "double",
        "variantDescription": "string",
        "description": "string",
        "modified": "Date",
        "isbn": "string",
        "upc": "string",
        "diamondCode": "string",
        "ean": "string",
        "issn": "string",
        "format": "string",
        "pageCount": "int",
        "textObjects": [
          {
            "type": "string",
            "language": "string",
            "text": "string"
          }
        ],
        "resourceURI": "string",
        "urls": [
          {
            "type": "string",
            "url": "string"
          }
        ],
        "series": {
          "resourceURI": "string",
          "name": "string"
        },
        "variants": [
          {
            "resourceURI": "string",
            "name": "string"
          }
        ],
        "collections": [
          {
            "resourceURI": "string",
            "name": "string"
          }
        ],
        "collectedIssues": [
          {
            "resourceURI": "string",
            "name": "string"
          }
        ],
        "dates": [
          {
            "type": "string",
            "date": "Date"
          }
        ],
        "prices": [
          {
            "type": "string",
            "price": "float"
          }
        ],
        "thumbnail": {
          "path": "string",
          "extension": "string"
        },
        "images": [
          {
            "path": "string",
            "extension": "string"
          }
        ],
        "creators": {
          "available": "int",
          "returned": "int",
          "collectionURI": "string",
          "items": [
            {
              "resourceURI": "string",
              "name": "string",
              "role": "string"
            }
          ]
        },
        "characters": {
          "available": "int",
          "returned": "int",
          "collectionURI": "string",
          "items": [
            {
              "resourceURI": "string",
              "name": "string",
              "role": "string"
            }
          ]
        },
        "stories": {
          "available": "int",
          "returned": "int",
          "collectionURI": "string",
          "items": [
            {
              "resourceURI": "string",
              "name": "string",
              "type": "string"
            }
          ]
        },
        "events": {
          "available": "int",
          "returned": "int",
          "collectionURI": "string",
          "items": [
            {
              "resourceURI": "string",
              "name": "string"
            }
          ]
        }
      }
    ]
  },
  "etag": "string"
}*/
