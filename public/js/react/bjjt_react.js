class Technique extends React.Component {
    constructor() {
        super();
        // this.props = {color: "red"};
    }
    render() {
        return <a href="#" class="list-group-item get_techs_topic"><h4 class="list-group-item-heading">{this.props.topic}</h4></a>;
    }
}
// export default Technique;

ReactDOM.render(
    <Technique topic="foo"/>,
    document.getElementById('app')
);
