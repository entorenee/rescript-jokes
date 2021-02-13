switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOMRe.render(<div> {"hello world"->React.string} </div>, root)
| None => ()
}
