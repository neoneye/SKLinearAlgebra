//
//  LinearAlgebra.swift
//  SKLinearAlgebra
//
//  Created by Cameron Little on 2/23/15.
//  Copyright (c) 2015 Cameron Little. All rights reserved.
//

import Foundation
import SceneKit

let EPSILON: Float = 0.00001

public protocol Copyable {
    func copy() -> Self
}

public protocol Comparable {
    static func ~=(lhs: Self, rhs: Self) -> Bool
    static func !~=(lhs: Self, rhs: Self) -> Bool
}

public protocol Vector: Equatable, CustomStringConvertible, Copyable, Comparable {
    static func +(lhs: Self, rhs: Self) -> Self
    static func +=(lhs: inout Self, rhs: Self)
    static func -(lhs: Self, rhs: Self) -> Self
    static func -=(lhs: inout Self, rhs: Self)

    static func *(lhs: Self, rhs: Self) -> Float

    static func *(lhs: Float, rhs: Self) -> Self
    static func *(lhs: Self, rhs: Float) -> Self
    static func *=(lhs: inout Self, rhs: Float)
    static func *(lhs: Int, rhs: Self) -> Self
    static func *(lhs: Self, rhs: Int) -> Self
    static func *=(lhs: inout Self, rhs: Int)

    static func /(lhs: Self, rhs: Float) -> Self
    static func /=(lhs: inout Self, rhs: Float)
    static func /(lhs: Self, rhs: Int) -> Self
    static func /=(lhs: inout Self, rhs: Int)

    static func ×(lhs: Self, rhs: Self) -> Self
}

public protocol Matrix: Equatable, CustomStringConvertible, Copyable, Comparable {
    static func *(lhs: Float, rhs: Self) -> Self
    static func *(lhs: Self, rhs: Float) -> Self
    static func *=(lhs: inout Self, rhs: Float)
    static func *(lhs: Int, rhs: Self) -> Self
    static func *(lhs: Self, rhs: Int) -> Self
    static func *=(lhs: inout Self, rhs: Int)

    static func /(lhs: Self, rhs: Float) -> Self
    static func /=(lhs: inout Self, rhs: Float)
    static func /(lhs: Self, rhs: Int) -> Self
    static func /=(lhs: inout Self, rhs: Int)
}

infix operator × // Cross product

//infix operator ~= // Equivalent

infix operator !~= // Not equivalent

public func cross<T: Vector> (_ a: T, _ b: T) -> T {
    return a × b
}

public func magnitude<T: Vector> (_ vec: T) -> Float {
    return sqrt(vec * vec)
}

public func normalize<T: Vector> (_ vec: T) -> T {
    let vmag = magnitude(vec)
    if vmag == 0 {
        fatalError("Zero vector provided to normalize")
    }
    return vec / vmag
}

public func angle<T: Vector> (_ left: T, _ right: T) -> Float {
    let ml = magnitude(left)
    let mr = magnitude(right)
    if ml == 0 || mr == 0 {
        fatalError("Zero vector provided to angle")
    }
    return acos((left * right) / (ml * mr))
}

/* comp_{b} a
 * result is the length of vector a on vector b
 *
 *              b
 *              |
 *              |
 *            { |   / a
 * comp(a, b) { |  /
 *            { | /
 *
 */
public func component<T:Vector> (_ a: T, _ b: T) -> Float {
    let bmag = magnitude(b)
    if bmag == 0 {
        fatalError("Zero vector provided to component")
    }
    return (a * b) / bmag
}

/* proj_{b} a 
 */
public func projection<T:Vector> (_ a: T, _ b: T) -> T {
    let magb = magnitude(b)
    if magb == 0 {
        fatalError("Zero vector provided to projection")
    }
    let adotb = a * b
    return (adotb / pow(magb, 2)) * b
}
