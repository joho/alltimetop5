import React from 'react'

import {
  BrowserRouter as Router,
  Route,
  Link
} from 'react-router-dom'

import { observable } from 'mobx'
import { observer } from 'mobx-react'

import './App.css';

const listStore = observable({ lists: null })

const getLists = () => {
  if (!listStore.lists) {

    const lists = [];
    for (let i = 1; i < 10; i++) {
      let list = {
        id: i,
        title: `all time top 5 ${Math.random() * 10}`,
        items: []
      }
      for(let j=0; j<5; j++) {
        list.items.push(`thing ${j}`)
      }

      lists.push(list)
    }

    listStore.lists = lists
  }
}

const getList = (id) => {
  if (!listStore.lists) {
    getLists()
  }

  return listStore.lists.find( (list) => {
    console.log(list.id)
    console.log(id)
    return list.id === parseInt(id, 10)
  })
}

const Home = observer(() => {
  getLists()
  return(
    <div>
      <h2>Welcome to alltimetop5</h2>
      {listStore.lists && listStore.lists.map( (list, i) =>
        <Link key={i} to={ `/list/${list.id}` }>{list.title}</Link>
      )}
    </div>
  )
})

const UserList = ( { match } ) => {
  const list = getList(match.params.listId)
  if (!list) {
    console.log(match)
    console.log(listStore.lists)
    return(<h2>404</h2>)
  }

  return(<div>
    <Link to="/">&lt; home</Link>
    <h2>Top 5 foo</h2>
    <ol>
      {list.items.map( (item, i) => <li key={i}>{item}</li> )}
    </ol>
  </div>)
}

const App = () => {
  return(
    <Router>
      <div>
        <Route exact path="/" component={Home} />
        <Route path={"/list/:listId"} component={UserList} />
      </div>
    </Router>
  )
}

export default App;
