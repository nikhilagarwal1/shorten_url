The REST API endpoints are:-

1) Creating a shortened url:-

  Request Type :- POST

  Endpoint:- /shorteners

  Body :- {"shortener": {"url": "google.com" } }

  Response:-
    [
      {
          "id": 1,
          "url": "google.com",
          "shorten_url": "jSdeYz",
          "created_at": "2018-07-18T13:36:01.665Z",
          "updated_at": "2018-07-18T13:36:01.665Z",
          "sanitized_url": "http://google.com"
      }
  ]

2) Fetching list of shortened urls:-

Request Type :- GET

Endpoint:- /shorteners

Response:-
  [
      {
          "id": 10,
          "url": "google.com",
          "shorten_url": "jSdeYz",
          "created_at": "2018-07-18T13:36:01.665Z",
          "updated_at": "2018-07-18T13:36:01.665Z",
          "sanitized_url": "http://google.com"
      }
  ]


3) Fetching original url from a shortened url:-

Request Type :- GET

Endpoint:- /shortners/original_url?shorten_url="abcd"

Response:-

  {
    "original_url": "google.com"
  }

4) Deleting shortened-urls:-

Request Type :- DELETE

Endpoint:- /shortners/{:id}
