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

import UIKit
import Factory

protocol PokeApiPokemonDisplayLogic: AnyObject {
    func displayViewContents(
        viewModel: PokeApi.Pokemon.ViewContents.ViewModel
    ) async
}

protocol PokeApiPokemonViewDelegate: AnyObject {
    func didTapButton()
}

extension PokeApi.Pokemon {
    @Observable class ObservableState {
        public var viewState: PokeApi.Pokemon.SceneState = .empty
        var interactor: PokeApiPokemonBusinessLogic!
        var router: PokeApiPokemonRoutingLogic!
    }
}

extension PokeApi.Pokemon.ObservableState: PokeApiPokemonDisplayLogic, PokeApiPokemonViewDelegate {
    
    @MainActor func displayViewContents(
        viewModel: PokeApi.Pokemon.ViewContents.ViewModel
    ) {
        let scene = PokeApi.Pokemon.SceneView(
            viewModel: viewModel,
            viewStateBody: self.viewState.body,
            viewDelegate: self
        )
    }
    
    func didTapButton() {
        interactor.didTapButton()
    }
}


