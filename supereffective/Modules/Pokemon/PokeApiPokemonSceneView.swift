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
import Factory

extension PokeApi.Pokemon {
    public enum SceneState: Identifiable, Equatable, View {
        case empty
        case summary(
            viewModel: PokeApi.Pokemon.ViewContents.ViewModel,
            viewDelegate: PokeApiPokemonViewDelegate?)
        
        static func == (lhs: PokeApi.Pokemon.SceneState, rhs: PokeApi.Pokemon.SceneState) -> Bool {
            switch (lhs, rhs) {
            case
                (.empty, .empty),
                (.summary(_, _), .summary(_, _)):
                return true
            case _:
                return false
            }
        }
        
        public var id: String {
            switch self {
            case .empty:
                return "empty"
            case .summary:
                return  "summary"
            }
        }
        
        public var body: some View {
            switch self {
            case .empty:
                VStack {
                    EmptyView()
                }.navigationTitle(
                    Text(ViewContents.ViewModel.title)
                )
            case .summary(
                viewModel: let viewModel,
                viewDelegate: let viewDelegate
            ):
                VStack(){
                    
                }.navigationTitle(
                    Text(ViewContents.ViewModel.title)
                )
            }
            
        }
        
        
    }
    
    struct SceneView: View {
        let viewModel: PokeApi.Pokemon.ViewContents.ViewModel
        var viewStateBody: any View
        var interactor: PokeApiPokemonBusinessLogic!
        var router: PokeApiPokemonRoutingLogic!
        
        weak var viewDelegate: PokeApiPokemonViewDelegate?
        internal let inspection = Inspection<Self>()
        var body: some View {
            ScrollView(){
                AnyView(
                    viewStateBody
                )
            }.onReceive(
                inspection.notice
            ) {
                self.inspection.visit(
                    self,
                    $0
                )
            }.task {
                await interactor.getViewContents()
            }
        }
    }
}
