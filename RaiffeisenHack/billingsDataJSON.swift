//
//  billingsDataJSON.swift
//  RaiffeisenHack
//
//  Created by Alexander on 01/04/2017.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import Foundation

var billingsDataJSON: JSON = [
    [
        "type": "Карты",
        "entities": [
            [
                "name" : "Visa Classic",
                "number": "0000000000003542",
                "balance": 10452,
                "currency": "₽",
                "logo": "visa",
            ],
            [
                "name" : "MasterCard World",
                "number": "0000000000003420",
                "balance": 236,
                "currency": "$",
                "logo": "mastercard",
            ],
            [
                "name" : "Maestro",
                "number": "0000000000009880",
                "balance": 5482,
                "currency": "₽",
                "logo": "maestro",
            ]
        ]
    ],
    [
        "type": "Вклады и счета",
        "entities": [
            [
                "name" : "Рассчетный счет",
                "info": "Бессрочный",
                "rate": 0,
                "balance": 142452,
                "currency": "₽",
                "logo": "safe",
                ],
            [
                "name" : "Накопительный вклад",
                "info": "До 16 Апр. 2017",
                "rate": 6.5,
                "balance": 500000,
                "currency": "₽",
                "logo": "safe",
            ]
        ]
    ],
    [
        "type": "Кредиты",
        "entities": [
            [
                "name" : "Образовательный кредит",
                "info": "4 Апр. к оплате",
                "rate": 15,
                "toPay": 302,
                "balance": 120000,
                "currency": "₽",
                "logo": "wallet",
            ]
        ]
    ]
]
