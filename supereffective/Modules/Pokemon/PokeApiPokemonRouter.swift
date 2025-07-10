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

import SwiftUI

protocol PokeApiPokemonRoutingLogic {
    func navigateToSomewhere()
}

protocol PokeApiPokemonDataPassing {
    var dataStore: PokeApiPokemonDataStore! { get }
}

extension PokeApi.Pokemon {
    class Router: PokeApiPokemonRoutingLogic {
        var sceneView: any View = PokeApi.Pokemon.SceneState.empty
        var dataStore: PokeApiPokemonDataStore!
        func navigateToSomewhere() {
//            viewController?.navigationController?.navigateTo(displayScene: <somewhere>)
        }
        
        init() {}
        
        init(pokemonType: Int, hasAdvantage: Bool = true) {
        }
        
        init(sceneView: any View, dataStore: PokeApiPokemonDataStore!) {
            self.sceneView = sceneView
            self.dataStore = dataStore
        }
    }
}

extension PokeApi.Pokemon.Router: Displayable {
    var viewType: any View.Type {
        PokeApi.Pokemon.SceneView.self
    }

    @MainActor func setupDisplayable() -> any View {
        var obserableSceneState = PokeApi.Pokemon.ObservableState()
        var sceneView =  PokeApi.Pokemon.SceneView(
            viewModel: .init(headerViewModel: .init(subTitle: "PokeMon")),
            viewStateBody: obserableSceneState.viewState.body
        )
        let interactor = PokeApi.Pokemon.Interactor()
        let presenter = PokeApi.Pokemon.Presenter()

        sceneView.interactor = interactor
        sceneView.router = self
        interactor.presenter = presenter
        presenter.sceneView = obserableSceneState

        self.sceneView = sceneView
        self.dataStore = interactor

        return sceneView
    }
}
