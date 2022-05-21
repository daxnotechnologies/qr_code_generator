const signInR = '''{
    "message": true,
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im11a3RhcmFiYmFzNDQ0NUBnbWFpbC5jb20iLCJpZCI6IjYyMTM5ZDBmZjNmYTAyMDAxNjU1ZjkwNiIsImlhdCI6MTY0NTk0NjE5MiwiZXhwIjoxNjQ1OTQ5NzkyfQ.ROC-SolaEQcCFwaW7vL41piyvYnb9WHw2izc8IXDUe8",
    "user": {
        "_id": "62139d0ff3fa02001655f906",
        "firstName": "Mukhtar",
        "lastName": "Abbas",
        "gender": "Male",
        "dob": "12-12-1999",
        "contact": "03331751075",
        "email": "muktarabbas4445@gmail.com",
        "password": "\$2a\$10\$783F3wvm6WUk1eaoNuoBW.IA124gnjqbckY78Hq2rojUKwZNUH0c6",
        "resetToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyMTM5ZDBmZjNmYTAyMDAxNjU1ZjkwNiIsImlhdCI6MTY0NTg4MDczMCwiZXhwIjoxNjQ1ODg0MzMwfQ.2gHALDsvPQwyaNBYZV4ksePIkKDeomezjDiMoxstm0w",
        "expires": "2022-02-26T14:05:30.465Z",
        "__v": 0
    }
}''';

const forgotPassR = '''{
    "message": true,
    "success": "Check your email"
}''';

const createMenuR = '''{
    "message": true,
    "menu": {
        "items": [
            {
                "id": "12345432",
                "name": "Spice 1",
                "price": "222",
                "description": "The Delicious Dish"
            }
        ],
        "_id": "621a238d1b118b0016e25190",
        "resturantName": "Chaghi",
        "address": "Jail Road FSD",
        "city": "Faisalabad",
        "contact": "090078601",
        "name": "Mukhtar",
        "headerImg": "",
        "backgroundImg": "",
        "qrcode": "",
        "createdAt": "2022-02-26T12:56:45.632Z",
        "updatedAt": "2022-02-26T12:56:45.632Z",
        "__v": 0
    }
}''';

const editMenuR = '''{
    "message": true,
    "menu": {
        "items": [
            {
                "id": "12345432",
                "name": "Spice 1",
                "price": "222",
                "description": "The Delicious Dish"
            }
        ],
        "_id": "621a238d1b118b0016e25190",
        "resturantName": "Chaghi",
        "address": "Jail Road FSD",
        "city": "Faisalabad",
        "contact": "090078601",
        "name": "Mukhtar Abbas",
        "headerImg": "https://lh3.googleusercontent.com/a-/AOh14GjEvLkj-QYx0Ecjhpxi7UDVyrybCk3hRxpkI4JU=s64",
        "backgroundImg": "https://images.unsplash.com/photo-1553095066-5014bc7b7f2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8d2FsbCUyMGJhY2tncm91bmR8ZW58MHx8MHx8&w=1000&q=80",
        "qrcode": "data:image/png;base64,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",
        "createdAt": "2022-02-26T12:56:45.632Z",
        "updatedAt": "2022-02-26T13:00:14.499Z",
        "__v": 0,
        "user": null
    }
}''';

const createSurveyR = '''{
    "message": true,
    "survey": {
        "_id": "621a750d6274d20016e11c54",
        "name": "Chaghi",
        "address": "Jail Road FSD",
        "city": "Faisalabad",
        "description": "Chaghi is the best restaurant",
        "image": "https://lh3.googleusercontent.com/a-/AOh14GjEvLkj-QYx0Ecjhpxi7UDVyrybCk3hRxpkI4JU=s64",
        "user": "62139d0ff3fa02001655f906",
        "createdAt": "2022-02-26T18:44:29.256Z",
        "updatedAt": "2022-02-26T18:44:29.256Z",
        "__v": 0
    }
}''';
