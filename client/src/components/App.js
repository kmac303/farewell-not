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

function App() {

  return (
    <div className="App">
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
