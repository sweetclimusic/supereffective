/*
 * Copyright 2024 Ashlee Muscroft
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* TODO: Ensure PokeApi namespace contains Type namespace */
import Factory

protocol PokeApiTypeBusinessLogic {
    func getViewContents()
    func getSelected(for id: Int)
}

protocol PokeApiTypeDataStore {
    var pokemonType: String? { get set }
    var pokemonTypes: [PokemonType] { get set }
}

extension PokeApi.PokeType {
    class Interactor: PokeApiTypeDataStore {
        
        var pokemonType: String?
        
        var pokemonTypes = [PokemonType]()
        
        var presenter: PokeApiTypePresentationLogic!
        private let pokeApiGetService = Container.shared.pokeApiGetService()
    }
}

extension PokeApi.PokeType.Interactor: PokeApiTypeBusinessLogic {
    func getViewContents() {
        Task { 
            let data = try await fetchPokeTypes()
            pokemonTypes = data
            await presenter.presentViewContents(
                response: .init(
                    selectedType: pokemonType, types: data, damageRelations: nil)
            )
        }
    }

    func getSelected(for id: Int) {
        Task {
            let data = try await fetchPokeType(with: id)
            pokemonType = data.name
            print(data)
            await presenter.presentViewContents(
                response: .init(
                    selectedType: pokemonType, 
                    types: pokemonTypes,
                    damageRelations: data
                )
            )
        }
    }
    
    private func fetchPokeTypes() async throws -> [PokemonType] {
        do {
            return try await pokeApiGetService.getTypes()
        }
    }
    
    private func fetchPokeType(with typeId: Int) async throws -> PokemonTypeData {
        do {
            return try await pokeApiGetService.getType(by: typeId)
        }
    }
}
