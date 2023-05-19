//
//  MAFullCast.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 19/05/23.
//

import Foundation

struct MAFullCast: Codable {
    
    let errorMessage : String?
    let actors : [ActorShort]?
    let directors : CastShort?
    let writers : CastShort?
    let others : [CastShort]?
}


struct CastShort: Codable
{    
    let job : String?
    let items : [CastShortItem]?
}

struct CastShortItem: Codable
{
    let id : String?
    let name : String?
    let description : String?
}

struct ActorShort: Codable
{
    let id : String?
    let image : String?
    let name : String?
    let asCharacter : String?
}
