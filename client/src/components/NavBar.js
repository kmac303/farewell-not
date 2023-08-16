import React, {useContext} from "react";
import { NavLink } from "react-router-dom";
import { UserContext } from "../context/UserContext";

function NavBar() {
  const {user, setUser} = useContext(UserContext);
  function handleLogoutClick() {
    fetch("/logout", { method: "DELETE" }).then((r) => {
      if (r.ok) {
        setUser(null);
      }
    });
  }

  return (
    <header className="stacked">
      <div>
        <NavLink to="/">Home</NavLink>
        <br/>
        <NavLink to="/restaurants">Restaurants</NavLink>
      </div>
      <div>
        {user ? (
          <button onClick={handleLogoutClick}>Logout</button>
        ) : (
          <>
            <NavLink to="/signup">Signup</NavLink>
            <br />
            <NavLink to="/login">Login</NavLink>
          </>
        )}
      </div>
    </header>
  );
}

export default NavBar;
