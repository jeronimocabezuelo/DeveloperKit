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
        guard index >= startIndex,
              index < endIndex
        else { return nil }
        
        return self[index]
    }
    
    public func at(_ range: Range<Int>) -> [Element] {
        return range.compactMap({ at($0) })
    }
    
    public mutating func set(at index: Int, with value: Element) {
        self.setAt(index, value)
    }
    public mutating func setAt(_ index: Int, _ value: Element) {
        guard index >= 0,
              index < count
        else { return }
        
        self[index] = value
    }
    
    public func grouped<Key: Hashable>(by keyForValue: (Element) -> Key) -> [(Key, Self)] {
        Dictionary(
            grouping: self,
            by: keyForValue
        )
        .map({ ($0.key, $0.value)})
    }
    
    public func compact<T>() -> [T] where Element == T? {
        self.compactMap { $0 }
    }
}

extension Array {
    public func toDictionary<Key: Hashable, Value>() -> [Key: Value] where Element == (Key, Value) {
        Dictionary(uniqueKeysWithValues: self)
    }
}

extension Array where Element: Equatable {
    public func removingDuplicates() -> [Element] {
        self.reduce(into: [Element]()) { result, element in
            if !result.contains(element) {
                result.append(element)
            }
        }
    }
}

extension Array where Element: Collection {
    public func flatten() -> [Element.Element] {
        return self.flatMap { $0 }
    }
}

extension Collection {
    public var isNotEmpty: Bool { !isEmpty }
}

extension Collection where Element: Identifiable {
    public func find(id: Element.ID?) -> Element? {
        guard let id else { return nil }
        return first { $0.id == id }
    }
    
    public func findIndex(id: Element.ID?) -> Index? {
        guard let id else { return nil }
        return firstIndex { $0.id == id }
    }
}
