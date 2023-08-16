import React, { useEffect, useState } from "react";
import { Switch, Route} from "react-router-dom";
import Login from './Login';
import NavBar from "./NavBar";
import Header from "./Header";
import Home from "./Home";
import SignUp from "./SignUp";
import Restaurant from "./Restaurant";
import RestaurantContainer from "./RestaurantContainer";
import NewReviewForm from "./NewReviewForm";
import EditReview from "./EditReview";
import NewRestaurantForm from "./NewRestaurantForm";
import { UserProvider } from "../context/UserContext";

function App() {
  const [restaurants, setRestaurants] = useState([]);

  useEffect(() => {
    fetch(`/restaurants`)
      .then((r) => r.json())
      .then((restaurants) => setRestaurants(restaurants)); 
  }, []); 

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
          <Route exact path="/restaurants">
            <RestaurantContainer restaurants={restaurants}/>
          </Route>
          <Route exact path="/restaurants/new">
            <NewRestaurantForm restaurants={restaurants} setRestaurants={setRestaurants}/>
          </Route>
          <Route exact path="/restaurants/:id">
            <Restaurant/>
          </Route>
          <Route exact path="/restaurants/:id/review">
            <NewReviewForm restaurants={restaurants} setRestaurants={setRestaurants}/>
          </Route>
          <Route path="/reviews/:id/edit">
            <EditReview restaurants={restaurants} setRestaurants={setRestaurants}/>
          </Route>
        </Switch>
        </main>
       </UserProvider>
    </div>
  );
}

export default App;
