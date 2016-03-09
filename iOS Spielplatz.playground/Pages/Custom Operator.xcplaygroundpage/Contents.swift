import Darwin

postfix operator ° {}
postfix func °(degrees: Double) -> Double {return degrees * M_PI / 180.0}

infix operator ** { associativity left precedence 170 }

public func ** (num: Double, power: Double) -> Double{
  return pow(num, power)
}
public func ** (num: Double, power: Int) -> Double{
  return pow(num, Double(power))
}
public func ** (num: Int, power: Double) -> Double{
  return pow(Double(num), power)
}
public func ** (num: Float, power: Float) -> Float{
  return powf(num, power)
}
public func ** (num: Float, power: Int) -> Float{
  return powf(num, Float(power))
}
public func ** (num: Int, power: Float) -> Float{
  return powf(Float(num), power)
}
infix operator **= { associativity right precedence 90 assignment }

public func **= (inout num: Double, power: Double){
  num = pow(num, power)
}
public func **= (inout num: Double, power: Int){
  num = pow(num, Double(power))
}
public func **= (inout num: Float, power: Float){
  num = powf(num, power)
}
public func **= (inout num: Float, power: Int){
  num = powf(num, Float(power))
}



public struct Coordinate {
  public let latitude: Double, longitude: Double
  let EarthRadius = 6378.0
  public func distanceFrom(coordinate: Coordinate) -> Double {
    let (dLat, dLon) = (latitude - coordinate.latitude, longitude - coordinate.longitude)
    let (sqSinLat, sqSinLon) = (sin(dLat° / 2.0) ** 2, sin(dLon° / 2.0) ** 2)
    let α = sqSinLat + sqSinLon * cos(latitude°) * cos(coordinate.latitude°)
    return 2.0 * EarthRadius * atan2(sqrt(α), sqrt(1.0 - α))
  }
}

let cologneCathedral = Coordinate(latitude: 50.941302, longitude: 6.957189)
let cologneTelecommunicationsTower = Coordinate(latitude: 50.947269, longitude: 6.931739)
cologneCathedral.distanceFrom(cologneTelecommunicationsTower)
