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

extension PokeApi.PokeType {
    enum ViewContents {
        struct Request {
        }

        struct Response {
            let selectedType: String?
            let types: [PokemonType]
            let damageRelations: PokemonTypeData?
        }

        struct ViewModel {
            static let title = "Type TITLE"
            let types: [PokemonType]
            let damageRelationViewModel: DamageRelationViewModel?
            let favorite: [PokemonTypes]? = []
        }
        
        struct DamageRelationViewModel {
            let type: String
            let types: [String]
            let superEffective: [String]
            let notVeryEffective: [String]
            let buttonText: String = "View Pokemon Types"
            var theme: Color {
                guard let colorScheme = PokemonTypeTheme(rawValue: type.lowercased())
                else {
                    return PokemonTypeTheme.unknown()
                }
                return colorScheme()
            }
        }
    }
}
