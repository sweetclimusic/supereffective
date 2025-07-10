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

protocol PokeApiPokemonPresentationLogic {
    func presentViewContents(response: PokeApi.Pokemon.ViewContents.Response) async
}

extension PokeApi.Pokemon {
    class Presenter {
        weak var sceneView: PokeApiPokemonDisplayLogic!
        let builder = PokeApi.Pokemon.ViewModelBuilder()
    }
}

extension PokeApi.Pokemon.Presenter: PokeApiPokemonPresentationLogic {
    func presentViewContents(response: PokeApi.Pokemon.ViewContents.Response) async {
        await sceneView.displayViewContents(
            viewModel: .init(
                headerViewModel: builder.buildHeaderViewModel(response: response)
            )
        )
    }
}
