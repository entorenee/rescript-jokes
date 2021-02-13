type joke = {
  id: int,
  setup: string,
  punchline: string,
}

type stateContext = {
  currJoke: int,
  jokes: array<joke>,
}

type states = Initial | Loading | Success(stateContext)

type events = FetchJokes | FetchSuccess(stateContext)

module Decode = {
  open Json.Decode
  let joke = json => {
    {
      id: json->field("id", int, _),
      setup: json->field("setup", string, _),
      punchline: json->field("punchline", string, _),
    }
  }

  let jokes = array(joke)
}

let fetchJokes = () => {
  open Js.Promise
  Fetch.fetch("https://official-joke-api.appspot.com/jokes/programming/ten")
  ->then_(Fetch.Response.json, _)
  ->then_(json => json->Decode.jokes->resolve, _)
}

let jokeMachine = (state, event) =>
  switch (state, event) {
  | (Initial, FetchJokes) => Loading
  | (Loading, FetchSuccess(data)) => Success(data)
  | (Success(_), FetchJokes) => Loading
  | (Initial, FetchSuccess(_))
  | (Success(_), FetchSuccess(_))
  | (Loading, FetchJokes) => state
  }
