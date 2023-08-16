import React, {useContext} from "react";
import { UserContext } from "../context/UserContext";

function Home() {
  const {user} = useContext(UserContext);

    if (user) {
      return (
    <div>
      <h1>Welcome, {user.username}!</h1>
      <h2>Want to leave a review? Click Restaurants first!</h2>
    </div>
    )} else {
      return (
      <>
        <h1>Welcome to RestaurantReviews.com</h1>
        <h5>Please Login or Create an Account to Leave a Review</h5>
      </>
    )}
  }
  
  export default Home;
  