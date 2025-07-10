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

protocol PokeApiTypeDisplayLogic: AnyObject {
    func displayViewContents(
        viewModel: PokeApi.PokeType.ViewContents.ViewModel
    ) async
}

protocol PokeApiTypeViewDelegate: AnyObject {
    func displaySelectedType(for url: String)
    func navigateToPokemonView()
}

extension PokeApi.PokeType {
    @Observable class ObservableState: PokeApiTypeDisplayLogic, PokeApiTypeViewDelegate {
        
        public var viewState: PokeApi.PokeType.SceneState = .empty
        var interactor: PokeApiTypeBusinessLogic!
        var router: PokeApiTypeRoutingLogic!
        
        /// Mange display content based on values stored in the ViewModel
        @MainActor func displayViewContents(viewModel: PokeApi.PokeType.ViewContents.ViewModel) {
            // WIP highlight the display if a type is in viewModel.favorite.contains(theType)
            if viewModel.damageRelationViewModel != nil {
                self.viewState = .selectedType(viewModel: viewModel, viewDelegate: self)
            } else {
                self.viewState = viewModel.types.isEmpty ? .empty : .all(pokemonTypes: viewModel.types, viewDelegate: self)
            }
            _ = PokeApi.PokeType.SceneView(observableState: self)
            
        }
        
        @MainActor func displaySelectedContent(viewModel: PokeApi.PokeType.ViewContents.ViewModel){
            self.viewState = .selectedType(viewModel: viewModel,
                                           viewDelegate: self)
            _ = PokeApi.PokeType.SceneView(observableState: self)
        }
        
        func displaySelectedType(for url: String) {
            guard let selection = url.idFromUrl(Endpoint.types())
            else { return }
            interactor.getSelected(for: selection )
        }
        
        func navigateToPokemonView() {
            router.navigateToPokemonOfType()
        }
    }
}
