import React, {useContext} from "react";
import { UserContext } from "../context/UserContext";
import { Link } from "react-router-dom/cjs/react-router-dom";

function Home() {
  const {user} = useContext(UserContext);

    if (user) {
      return (
    <div>
      <h1>Welcome, {user.username}!</h1>
      <Link to="/messages">View Your Messages</Link>
    </div>
    )} else {
      return (
      <>
        <h4>Please Login or Create an Account</h4>
      </>
    )}
  }
  
  export default Home;
  