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

protocol PokeApiTypeRoutingLogic {
    func navigateToPokemonOfType()
}

protocol PokeApiTypeDataPassing {
    var dataStore: PokeApiTypeDataStore! { get }
}

extension PokeApi.PokeType {
    class Router: PokeApiTypeRoutingLogic {
        var sceneView: any View = PokeApi.PokeType.SceneState.empty
        var dataStore: PokeApiTypeDataStore!
        
        func navigateToPokemonOfType() {
//            Route to Pokemon modules
        }
        
        init(){}
        
        init(pokemonType: String, pokemonTypes:[PokemonType] = [PokemonType]()) {
            self.dataStore.pokemonType = pokemonType
            self.dataStore.pokemonTypes = pokemonTypes
        }
        
        init(sceneView: any View, dataStore: PokeApiTypeDataStore!) {
            self.sceneView = sceneView
            self.dataStore = dataStore
        }
    }
}

extension PokeApi.PokeType.Router: Displayable {
    var viewType: any View.Type {
        PokeApi.PokeType.SceneView.self
    }
    
    func setupDisplayable() -> any View {
        let obserableSceneState = PokeApi.PokeType.ObservableState()
        let sceneView = PokeApi.PokeType.SceneView(observableState: obserableSceneState)
        let interactor = PokeApi.PokeType.Interactor()
        let presenter = PokeApi.PokeType.Presenter()
        
        obserableSceneState.interactor = interactor
        obserableSceneState.router = self
        interactor.presenter = presenter
        presenter.sceneView = obserableSceneState

        self.sceneView = sceneView
        self.dataStore = interactor

        return sceneView
    }
}
