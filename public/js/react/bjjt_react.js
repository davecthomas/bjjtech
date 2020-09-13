      class Technique extends React.Component {
        constructor() {
          super();
          // this.props = {color: "red"};
        }
        render() {
          return <h4>{this.props.context} Technique!</h4>;
        }
      }

      ReactDOM.render(
          <Technique context="foo"/>,
          document.getElementById('app')
      );
