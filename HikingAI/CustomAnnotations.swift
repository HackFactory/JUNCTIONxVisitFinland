//
//  CustomAnnotations.swift
//  HikingAI
//
//  Created by Yaroslav Spirin on 17/11/2019.
//  Copyright © 2019 Yaroslav Spirin. All rights reserved.
//

import MapKit
import UIKit

class CustomPointAnnotation: MKPointAnnotation {
    var imagePath: String?
}

class Routes {
    static let lowerIntroTravel =
        [[60.309679, 24.520173],
         [60.311664, 24.502928],
         [60.309671, 24.501522],
         [60.310134, 24.499806],
         [60.310070, 24.497607],
         [60.310707, 24.496491],
         [60.311186, 24.495375],
         [60.312084, 24.494463],
         [60.313178, 24.493025],
         [60.313954, 24.493969],
         [60.314156, 24.495160],
         [60.315298, 24.496298],
         [60.316616, 24.495032],
         [60.317689, 24.495740],
         [60.318858, 24.497263],
         [60.320048, 24.495893],
         [60.320633, 24.494252],
         [60.322715, 24.492460],
         [60.323697, 24.492948],
         [60.324903, 24.489418],
         [60.324935, 24.487906],
         [60.326638, 24.485417],
         [60.325119, 24.482810],
         [60.324179, 24.481555],
         [60.322819, 24.479001],
         [60.321061, 24.477349],
         [60.320089, 24.473036],
         [60.318479, 24.470354],
         [60.316912, 24.467435],
         [60.315748, 24.463873],
         [60.314234, 24.463101],
         [60.313240, 24.460848],
         [60.311784, 24.461953],
         [60.310562, 24.464925],
         [60.309032, 24.466974],
         [60.307315, 24.468186],
         [60.304121, 24.470901],
         [60.302282, 24.472102],
         [60.301538, 24.473926],
         [60.301548, 24.475686],
         [60.301038, 24.479334],
         [60.300049, 24.481887],
         [60.299730, 24.482552],
         [60.299800, 24.489065],
         [60.300193, 24.492466],
         [60.301128, 24.496318],
         [60.300993, 24.502463],
         [60.300650, 24.509471],
         [60.303066, 24.507892],
         [60.305103, 24.506688],
         [60.306967, 24.502642],
         [60.307671, 24.502191],
         [60.309567, 24.501355]
         ]
    
    static let lowerHypeTravel = [
        [60.293331, 24.559089],
        [60.293989, 24.557549],
        [60.295024, 24.554964],
        [60.295867, 24.553249],
        [60.296604, 24.552551],
        [60.299297, 24.551270],
        [60.300273, 24.550913],
        [60.301057, 24.551548],
        [60.302652, 24.551559],
        [60.303684, 24.550646],
        [60.304660, 24.548597],
        [60.306480, 24.548601],
        [60.307775, 24.549030],
        [60.308805, 24.546941],
        [60.312993, 24.545892],
        [60.314588, 24.543293],
        [60.315615, 24.542209],
        [60.316586, 24.538005],
        [60.317979, 24.536936],
        [60.320339, 24.522903],
        [60.320353, 24.516131],
        [60.323085, 24.509997],
        [60.321585, 24.505820],
        [60.321616, 24.501755],
        [60.327449, 24.495601],
        [60.325460, 24.492904],
        [60.323847, 24.493023],
        [60.323280, 24.492283],
        [60.322905, 24.492372],
        [60.320511, 24.495332],
        [60.318938, 24.497219],
        [60.316734, 24.494843],
        [60.315480, 24.496218],
        [60.314106, 24.493942],
        [60.312992, 24.492897],
        [60.309926, 24.497747],
        [60.309644, 24.501300],
        [60.311401, 24.501994],
        [60.313989, 24.503829],
        [60.314969, 24.506652],
        [60.311237, 24.512090],
        [60.309390, 24.519603],
        [60.309963, 24.520964],
        [60.309207, 24.526761],
        [60.307390, 24.531552],
        [60.306793, 24.536360],
        [60.308128, 24.540969],
        [60.307834, 24.543549],
        [60.308735, 24.547061]
        ]
    
    static let lowerPeacefulTravel = [[60.306141, 24.530708],
    [60.305270, 24.526534],
    [60.305121, 24.525697],
    [60.305546, 24.522983],
    [60.305195, 24.521266],
    [60.304999, 24.519679],
    [60.305309, 24.517049],
    [60.305383, 24.515310],
    [60.305926, 24.513846],
    [60.305672, 24.512120],
    [60.306284, 24.511280],
    [60.305678, 24.508994],
    [60.305158, 24.506685],
    [60.305764, 24.503828],
    [60.306388, 24.503046],
    [60.307625, 24.502125],
    [60.307816, 24.500966],
    [60.308932, 24.499454],
    [60.309942, 24.498488],
    [60.310093, 24.497028],
    [60.310698, 24.496159],
    [60.311947, 24.494314],
    [60.313116, 24.493005],
    [60.314042, 24.494032],
    [60.314861, 24.495964],
    [60.315672, 24.495945],
    [60.316809, 24.494615],
    [60.318180, 24.495709],
    [60.319014, 24.496890],
    [60.320459, 24.495195],
    [60.320756, 24.494047],
    [60.322882, 24.492222],
    [60.323762, 24.492710],
    [60.324939, 24.489296],
    [60.325292, 24.487534],
    [60.326624, 24.485552],
    [60.326301, 24.484071],
    [60.325228, 24.482698],
    [60.327460, 24.478930],
    [60.328916, 24.477006],
    [60.329887, 24.469852],
    [60.328610, 24.465640],
    [60.328593, 24.462772],
    [60.327600, 24.460648],
    [60.326336, 24.460079],
    [60.324519, 24.457483],
    [60.322410, 24.454961],
    [60.321215, 24.452472],
    [60.321050, 24.448771],
    [60.316791, 24.446881],
    [60.314092, 24.446752],
    [60.312157, 24.446581],
    [60.312710, 24.452825],
    [60.313640, 24.457417],
    [60.311727, 24.461593],
    [60.309950, 24.465702],
    [60.305026, 24.469453],
    [60.302055, 24.472584],
    [60.300828, 24.480002],
    [60.300502, 24.487250],
    [60.300754, 24.499477],
    [60.302133, 24.506140],
    [60.304997, 24.507103],
    [60.306413, 24.510902],
    [60.308611, 24.513120],
    [60.309914, 24.517719]
    ]
}

