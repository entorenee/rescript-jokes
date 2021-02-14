%raw(`require("./index.css")`)
switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOMRe.render(<JokesContainer />, root)
| None => ()
}
