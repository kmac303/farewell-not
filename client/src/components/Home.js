import React, {useContext} from "react";
import { UserContext } from "../context/UserContext";
import { Link } from "react-router-dom/cjs/react-router-dom";

function Home() {
  const {user} = useContext(UserContext);

  if (user?.username === "kmac") {
    return (
      <div>
        <h1>Welcome, {user.username}!</h1>
        <Link to="/scraper">Enter the Webscraper</Link>
      </div>
    );
  } else if (user) {
    return (
      <div>
        <h1>Welcome, {user.username}!</h1>
        <Link to="/messages">View Your Messages</Link>
      </div>
    );
  } else {
    return (
      <div>
        <h4>Please Login or Create an Account</h4>
      </div>
    );
  }
}
  
  export default Home;
  