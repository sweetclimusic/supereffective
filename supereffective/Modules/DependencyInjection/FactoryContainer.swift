//
//  Container.swift
//  supereffective
//
//  Created by Ashlee Muscroft on 30/04/2024.
//

import Factory
import Foundation

extension Container {
    var pokeApiGetService: Factory<PokeApiGetService> {
        self { PokeTypesService() }
    }
    
    /// Marked as any FavoriteManager due to associated type in protocol
//    public static func regeisterDataStores() {
//        var pokemonTypeFavorites = PokemonTypeFavorites(storeTypeOf: .pokemonTypes )
//        
//        var pokeApiFavoriteTypeStorage: Factory<any FavoriteManager> {
//            self .init{  pokemonTypeFavorites as (any FavoriteManager) }
//        }
//        
//        @Injected(\.pokeApiFavoriteTypeStorage) private var pokeApiFavoriteTypeStorage
//    }
}

@Observable class FactoryViewModel {
    @ObservationIgnored
    @Injected(\.pokeApiGetService) private var pokeApiGetService
    
    init(pokeApiGetService: PokeApiGetService  ) {
        self.pokeApiGetService = pokeApiGetService
        
       // Container.regeisterDataStores()
    }
    
    
}
