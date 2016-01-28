import React from 'react';

export default class NewListPage extends React.Component {
    constructor(props) {
        super();
        this.state = {
            list: [
                '',
                '',
                '',
                '',
                ''
            ]
        };
    }
    render() {
        return(
            <form>
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
                <input value={this.state[num - 1]} onChange={this.handleListEntryChange(num)} />
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

    submit(e) {
        e.preventDefault();
        console.log("NewList state", this.state);
    }
}
