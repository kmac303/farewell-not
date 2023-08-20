import React, { useEffect, useState } from "react";
import { Switch, Route} from "react-router-dom";
import Login from "./Login";
import NavBar from "./NavBar";
import Header from "./Header";
import Home from "./Home";
import SignUp from "./SignUp";
import { UserProvider } from "../context/UserContext";
import UserMessages from "./UserMessages";
import NewMessageForm from "./NewMessageForm";
import Message from "./Message";
import ScraperPage from "./ScraperPage";
// import './index.css';

function App() {
  // const [users, setUsers] = useState([]);

  // useEffect(() => {
  //   fetch(`/users`)
  //     .then((r) => r.json())
  //     .then((users) => setUsers(users)); 
  // }, []); 

  return (
    <div className="App">
      {/* <div className="blur-overlay"></div> */}
      <UserProvider>
      <NavBar />
      <Header />
        <main>
        <Switch>
          <Route exact path="/signup">
            <SignUp/>
          </Route>
          <Route exact path="/login">
            <Login />
          </Route>
          <Route exact path="/">
            <Home/>
          </Route>
          <Route exact path="/messages">
            <UserMessages/>
          </Route>
          <Route exact path="/messages/new">
            <NewMessageForm/>
          </Route>
          <Route exact path="/messages/:id">
            <Message/>
          </Route>
          <Route exact path="/scraper">
            <ScraperPage/>
          </Route>
        </Switch>
        </main>
       </UserProvider>
    </div>
  );
}

export default App;
