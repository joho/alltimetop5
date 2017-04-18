import React from 'react';

import createList from '../actions/createList';

class NewListPage extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            list: {
                title: null,
                entries: new Array(5)
            }
        };
    }

    render() {
        window.foo = this.context;
        if (this.props.list !== null) {
            this.context.router.pushState({}, "/foo/1");
        }

        return(
            <form>
                <label>Title<input value={this.state.list.title} onChange={this.handleTitleChange.bind(this)} /></label>
                {[1,2,3,4,5].map(this.renderFormInput.bind(this))}
                <button type="submit" onClick={this.submit.bind(this)}>
                    Save!
                </button>
            </form>
        );
    }

    renderFormInput(num) {
        return(
            <label key={num}>#{num}
                <input value={this.state.list.entries[num - 1]} onChange={this.handleListEntryChange(num)} />
            </label>
        );
    }

    handleListEntryChange(num) {
        return (e) => {
            // TODO clone?
            let newList = this.state.list;
            newList[num - 1] = e.target.value;
            this.setState({list: newList});
        };
    }

    handleTitleChange(e) {
        let newList = this.state.list;
        newList.title = e.target.value;
        this.setState({list: newList});
    }

    submit(e) {
        e.preventDefault();

        // TODO disable button e.target.disable();

        // TODO some validation
        this.context.executeAction(createList, {
            list: this.state.list
        });
    }
}

NewListPage.contextTypes = {
    executeAction: React.PropTypes.func.isRequired,
    router: React.PropTypes.func.isRequired
};

export default NewListPage;
