//
//  AritclesEntity.swift
//  Assessment
//
//  Created by Heema Boss on 5/26/20.
//  Copyright © 2020 Ibraheem. All rights reserved.
//

import Foundation

class AritclesEntity: Codable {
    var status: String?
    var copyright: String?
    var numResults: Int?
    var results = [ResultAritclesEntity?]()
    
    private enum CodingKeys: String, CodingKey {
        case status,
        copyright,
        numResults = "num_results",
        results
    }
}

class ResultAritclesEntity: Codable {
    var uri: String?
    var url: String?
    var id: Double?
    var assetId: Double?
    var source: String?
    var publishedDate: String?
    var updated: String?
    var section: String?
    var subsection: String?
    var nytdsection: String?
    var adxKeywords: String?
    var byline: String?
    var type: String?
    var title: String?
    var abstract: String?
    var desFacet = [String?]()
    var media = [MediaEntity?]()
    
    private enum CodingKeys: String, CodingKey {
        case uri,
        url,
        id ,
        assetId = "asset_id",
        source,
        publishedDate = "published_date",
        updated,
        section,
        subsection,
        nytdsection,
        adxKeywords = "adx_keywords",
        byline,
        type,
        title,
        abstract,
        desFacet = "des_facet",
        media
    }
}

class MediaEntity: Codable {
    var type: String?
    var subtype: String?
    var caption: String?
    var copyright: String?
    var approvedForSyndication: Int?
    var mediaMetadata = [MediaMetadataEntity?]()
    
    private enum CodingKeys: String, CodingKey {
        case type,
        subtype,
        caption,
        copyright,
        approvedForSyndication = "approved_for_syndication",
        mediaMetadata = "media-metadata"
    }
}

class MediaMetadataEntity: Codable {
    var url: String?
    var format: String?
    var height: Int?
    var width: Int?
}
