class Technique extends React.Component {
    constructor() {
        super();
        // this.props = {color: "red"};
    }
    render() {
        return <a href="#" className="list-group-item get_techs_topic"><h4 className="list-group-item-heading">{this.props.topic}</h4></a>;
    }
}
// ReactDOM.render(
//     <Technique topic="foo"/>,
//     document.getElementById('app')
// );
