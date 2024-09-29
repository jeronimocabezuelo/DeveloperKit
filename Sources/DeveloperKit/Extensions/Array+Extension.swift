//
//  Array+Extension.swift
//  DeveloperKit
//
//  Created by Jerónimo Cabezuelo Ruiz on 29/9/24.
//

extension Array {
    public func at(_ index: Int?) -> Element? {
        guard let index = index
        else { return nil }
        
        return at(index)
    }
    
    public func at(_ index: Int) -> Element? {
        guard index >= 0,
              index < count
        else { return nil }
        
        return self[index]
    }
    
    public func at(_ range: Range<Int>) -> [Element] {
        return range.compactMap({ at($0) })
    }
    
    public func grouped<Key: Hashable>(by keyForValue: (Element) -> Key) -> [(Key, Self)] {
        Dictionary(
            grouping: self,
            by: keyForValue
        )
        .map({ ($0.key, $0.value)})
    }
}

extension Array where Element: Collection {
    public func flatten() -> [Element.Element] {
        return self.flatMap { $0 }
    }
}
