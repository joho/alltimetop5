import React from 'react';
import ReactDOM from 'react-dom';

import { Router, Route, IndexRoute, hashHistory } from 'react-router';

import Fluxible from 'fluxible';
import { provideContext, connectToStores } from 'fluxible-addons-react';

import AppContainer from './components/AppContainer';

// pages
import HomePage from './components/HomePage';
import ShowListPage from './components/ShowListPage';

// stores
import ListStore from './stores/ListStore';

const ConnectedShowListPage = connectToStores(ShowListPage, [ListStore], (context, props) => ({
    list: context.getStore(ListStore).getList()
}));

const routes = (
  <Route path="/" component={AppContainer}>
    <IndexRoute component={HomePage} />
    <Route path="all-time-top-5-star-wars-movies/1234" component={ConnectedShowListPage} />
  </Route>
);

const app = new Fluxible({
  component: routes,
  stores: [
    ListStore
  ]
});

const context = app.createContext();

const createElement = function (Component, props) {
  props.context = context.getComponentContext();
  return React.createElement(provideContext(Component), props);
}

const router = (
    <Router history={hashHistory} createElement={createElement}>
      {app.getComponent()}
    </Router>
);

ReactDOM.render(
    router,
    document.getElementById('app')
);
