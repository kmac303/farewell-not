import React, { useState, useEffect, useContext } from "react";
import { UserContext } from "../context/UserContext";
import { Link } from "react-router-dom/cjs/react-router-dom";

function UserMessages() {
  const { user } = useContext(UserContext);
  const [messages, setMessages] = useState([]);

  useEffect(() => {
    if (user) {
      fetch("/messages")
        .then((response) => response.json())
        .then(setMessages);
    }
  }, [user]);

  return (
    <div>
      <h1>Your Messages</h1>
      <Link to="/messages/new">Create a New Message</Link>
      <ul>
        {messages.map((message) => (
          <li key={message.id}>
            <Link to={`/messages/${message.id}`}>
              {message.subject}
            </Link>
          </li> 
        ))}
      </ul>
    </div>
  );
}

export default UserMessages;
