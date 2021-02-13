@react.component
let make = () => {
  let (state, send) = React.useReducer(JokesMachine.jokeMachine, JokesMachine.Initial)

  let getNewJokes = () => {
    open Js.Promise
    send(FetchJokes)
    let _ = JokesMachine.fetchJokes()->then_(jokes => {
      let jokeState: JokesMachine.stateContext = {
        currJoke: 0,
        jokes: jokes,
      }
      send(FetchSuccess(jokeState))
      jokeState->resolve
    }, _)
  }

  <div>
    {switch state {
    | Initial => <button onClick={_ => getNewJokes()}> {"Get Jokes"->React.string} </button>
    | Loading => <span> {"Getting Jokes"->React.string} </span>
    | Success(jokeState) => <div>
        {Belt.Array.get(jokeState.jokes, 0)
        ->Belt.Option.mapWithDefault("No joke found", j => j.setup)
        ->React.string}
      </div>
    }}
  </div>
}
