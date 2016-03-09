#if os(Linux)
  import Glibc
#else
  import Darwin
#endif

/// The basic equation for region 2.
struct Region2 {
  static private let R = 0.461526 // specific gas constant, kJ/(kg*K)
  
  //region Numerical values of the coefficients and exponents of the ideal-gas part γ^0 of the dimensionless Gibbs free energy for region 2
  static private let J0: [Double] = [ 0, 1, -5, -4, -3, -2, -1, 2, 3]
  static private let n0: [Double] = [
    -0.96927686500217 * pow(10, 1),//n1
    0.10086655968018 * pow(10, 2),//n2
    -0.56087911283020 * pow(10, -2),//n3
    0.71452738081455 * pow(10, -1),//n4
    -0.40710498223928,//n5
    0.14240819171444 * pow(10, 1),//n6
    -0.43839511319450 * pow(10, 1),//n7
    -0.28408632460772,//n8
    0.21268463753307 * pow(10, -1)//n9
  ]
  //region Numerical values of the coefficients and exponents of the residual part γ^r of the dimensionless Gibbs free energy for region 2
  static private let I: [Double] = [1, 1, 1, 1, 1, 2, 2, 2, 2, 2,
                                    3, 3, 3, 3, 3, 4, 4, 4, 5, 6,
                                    6, 6, 7, 7, 7, 8, 8, 9, 10,
                                    10, 10, 16, 16, 18, 20, 20,
                                    20, 21, 22, 23, 24, 24, 24]
  
  static private let J: [Double] = [0, 1, 2, 3, 6, 1, 2, 4, 7, 36,
                                    0, 1, 3, 6, 35, 1, 2, 3, 7, 3,
                                    16, 35, 0, 11, 25, 8, 36, 13,
                                    4, 10, 14, 29, 50, 57, 20, 35,
                                    48, 21, 53, 39, 26, 40, 58]
  
  static private let n: [Double] = [
    -0.17731742473213 * pow(10, -2),  //n1
    -0.17834862292358 * pow(10, -1),  //n2
    -0.45996013696365 * pow(10, -1),  //n3
    -0.57581259083432 * pow(10, -1),  //n4
    -0.50325278727930 * pow(10, -1),  //n5
    -0.33032641670203 * pow(10, -4),  //n6
    -0.18948987516315 * pow(10, -3),  //n7
    -0.39392777243355 * pow(10, -2),  //n8
    -0.43797295650573 * pow(10, -1),  //n9
    -0.26674547914087 * pow(10, -4),  //n10
    0.20481737692309 * pow(10, -7),   //n11
    0.43870667284435 * pow(10, -6),   //n12
    -0.32277677238570 * pow(10, -4),  //n13
    -0.15033924542148 * pow(10, -2),  //n14
    -0.40668253562649 * pow(10, -1),  //n15
    -0.78847309559367 * pow(10, -9),  //n16
    0.12790717852285 * pow(10, -7),   //n17
    0.48225372718507 * pow(10, -6),   //n18
    0.22922076337661 * pow(10, -5),   //n19
    -0.16714766451061 * pow(10, -10), //n20
    -0.21171472321355 * pow(10, -2),  //n21
    -0.23895741934104 * pow(10, 2),   //n22
    -0.59059564324270 * pow(10, -17), //n23
    -0.12621808899101 * pow(10, -5),  //n24
    -0.38946842435739 * pow(10, -1),  //n25
    0.11256211360459 * pow(10, -10),  //n26
    -0.82311340897998 * pow(10, 1),   //n27
    0.19809712802088 * pow(10, -7),   //n28
    0.10406965210174 * pow(10, -18),  //n29
    -0.10234747095929 * pow(10, -12), //n30
    -0.10018179379511 * pow(10, -8),  //n31
    -0.80882908646985 * pow(10, -10), //n32
    0.10693031879409,                 //n33
    -0.33662250574171,                //n34
    0.89185845355421 * pow(10, -24),  //n35
    0.30629316876232 * pow(10, -12),  //n36
    -0.42002467698208 * pow(10, -5),  //n37
    -0.59056029685639 * pow(10, -25), //n38
    0.37826947613457 * pow(10, -5),   //n39
    -0.12768608934681 * pow(10, -14), //n40
    0.73087610595061 * pow(10, -28),  //n41
    0.55414715350778 * pow(10, -16),  //n42
    -0.94369707241210 * pow(10, -6),  //n43
  ]
  
  // Calculation of basic equation for region 2 and its derivatives
  private static func countBasicEquation(pi: Double, _ tao: Double) -> Double {
    var gamma = log(pi)
    for i in 0..<n0.count {
      gamma += n0[i] * pow(tao, J0[i])
    }
    for i in 0..<n.count {
      gamma += n[i] * pow(pi, I[i]) * pow((tao-0.5), J[i])
    }
    return gamma
  }
  
  // ideal-gas part γ^0 derivatives
  private static func countDerivative_dGamma0_dPi(pi: Double) -> Double {
    return 1 / pi
  }
  
  private static func countDerivative_dGamma0_dTao(tao: Double) -> Double {
    var dGamma0_dTao = 0.0
    for i in 0..<n0.count {
      dGamma0_dTao += n0[i] * J0[i] * pow(tao, (J0[i]-1))
    }
    return dGamma0_dTao
  }
  
  private static func countDerivative_dGamma0_dPi2(pi: Double) -> Double {
    let dGamma0_dPi2 = -1/(pow(pi,2))
    return dGamma0_dPi2
  }
  
  private static func countDerivative_dGamma0_dTao2(tao: Double) -> Double {
    var dGamma0_dTao2 = 0.0
    for i in n0.indices {
      dGamma0_dTao2 += n0[i] * J0[i] * (J0[i]-1) * pow(tao, (J0[i] - 2))
    }
    return dGamma0_dTao2
  }
  
  private static func countDerivative_dGamma0_dPidTao() -> Double {
    return 0
  }
  
  // residual part γ^r derivatives
  private static func countDerivative_dGammaR_dPi(pi: Double, _ tao: Double) -> Double {
    var dGammaR_dPi = 0.0
    for i in n.indices {
      dGammaR_dPi += n[i] * I[i] * pow(pi, (I[i]-1)) * pow((tao - 0.5), J[i])
    }
    return dGammaR_dPi
  }
  
  private static func countDerivative_dGammaR_dTao(pi: Double, _ tao: Double) -> Double {
    var dGammaR_dTao = 0.0
    for i in n.indices {
      dGammaR_dTao += n[i] * J[i] * pow(pi, I[i]) * pow((tao - 0.5), (J[i]-1))
    }
    return dGammaR_dTao
  }
  
  private static func countDerivative_dGammaR_dPi2(pi: Double, _ tao: Double) -> Double {
    var dGammaR_dPi2 = 0.0
    for i in n.indices {
      dGammaR_dPi2 += n[i] * I[i] * (I[i] - 1) * pow(pi, (I[i] - 2)) * pow((tao - 0.5), J[i])
    }
    return dGammaR_dPi2
  }
  
  private static func countDerivative_dGammaR_dTao2(pi: Double, _ tao: Double) -> Double {
    var dGammaR_dTao2 = 0.0
    for i in n.indices {
      dGammaR_dTao2 += n[i] * J[i] * (J[i] - 1) * pow(pi, I[i]) * pow((tao - 0.5), (J[i] - 2))
    }
    return dGammaR_dTao2
  }
  
  private static func countDerivative_dGammaR_dPidTao(pi: Double, _ tao: Double) -> Double {
    var dGammaR_dPidTao = 0.0
    for i in n.indices {
      dGammaR_dPidTao += n[i] * I[i] * pow(pi, (I[i] - 1)) * J[i] * pow((tao - 0.5), (J[i]-1))
    }
    return dGammaR_dPidTao
  }
  
  // Methods for converting value to dimensionless
  private static func countDimensionless(temperature t: Double) -> Double {
    return 540 / t // 540 K
  }
  
  private static func countDimensionless(pressure p: Double) -> Double {
    return p / 1 //1 MPa
  }
  
  // Calculation of thermodynamic properties taking temperature and pressure as input
  static func calculateSpecificVolume(temperature: Double, pressure: Double) -> Double {
    let (pi, tao) = (countDimensionless(pressure: pressure), countDimensionless(temperature: temperature))
    let specificVolume = (pi * (countDerivative_dGamma0_dPi(pi) + countDerivative_dGammaR_dPi(pi, tao))) * R * temperature / (pressure*1000)
    return specificVolume
  }
  
  static func calculateSpecificEnthalpy(temperature: Double, pressure: Double) -> Double {
    let (pi, tao) = (countDimensionless(pressure: pressure), countDimensionless(temperature: temperature))
    let specificEnthalpy = (tao * (countDerivative_dGamma0_dTao(tao) + countDerivative_dGammaR_dTao(pi, tao))) * R * temperature
    return specificEnthalpy
  }
  
  static func calculateSpecificInternalEnergy(temperature: Double, pressure: Double) -> Double {
    let (pi, tao) = (countDimensionless(pressure: pressure), countDimensionless(temperature: temperature))
    let specificInternalEnergy = (tao * (countDerivative_dGamma0_dTao(tao) + countDerivative_dGammaR_dTao(pi, tao)) -
      pi * (countDerivative_dGamma0_dPi(pi) + countDerivative_dGammaR_dPi(pi, tao))) * R * temperature
    return specificInternalEnergy
  }
  
  static func calculateSpecificEntropy(temperature: Double, pressure: Double) -> Double {
    let (pi, tao) = (countDimensionless(pressure: pressure), countDimensionless(temperature: temperature))
    let specificInternalEnergy = (tao * (countDerivative_dGamma0_dTao(tao) + countDerivative_dGammaR_dTao(pi, tao)) -
      (countBasicEquation(pi, tao))) * R
    return specificInternalEnergy
  }
  
  static func specificIsobaricHeatCapacity(temperature: Double, pressure: Double) -> Double {
    let (pi, tao) = (countDimensionless(pressure: pressure), countDimensionless(temperature: temperature))
    let specificIsobaricHeatCapacity = (-pow(tao, 2) * (countDerivative_dGamma0_dTao2(tao)
      + countDerivative_dGammaR_dTao2(pi, tao))) * R
    return specificIsobaricHeatCapacity
  }
  
}
