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

protocol PokeApiPokemonBusinessLogic {
    func getViewContents() async
    func didTapButton()
}

protocol PokeApiPokemonDataStore {
    var pokemonType: Int? { get set }
    var hasAdvantage: Bool { get set }
}

extension PokeApi.Pokemon {
    class Interactor: PokeApiPokemonDataStore {
        var pokemonType: Int?
        
        var hasAdvantage: Bool = true
        
        var presenter: PokeApiPokemonPresentationLogic!
    }
}

extension PokeApi.Pokemon.Interactor: PokeApiPokemonBusinessLogic {
    func getViewContents() async {
        await presenter.presentViewContents(
            response: .init()
        )
    }


    func didTapButton() {
        print("didTapButton")
    }
}
