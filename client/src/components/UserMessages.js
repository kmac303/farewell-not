import React, { useState, useEffect, useContext } from "react";
import { UserContext } from "../context/UserContext";
import { Link } from "react-router-dom/cjs/react-router-dom";

function UserMessages() {
  const { user } = useContext(UserContext);
  const [messages, setMessages] = useState([]);

  useEffect(() => {
    if (user) {
      fetch("/messages") // Assuming this is your endpoint that fetches the user's messages
        .then((response) => response.json())
        .then(setMessages);
    }
  }, [user]);

  return (
    <div>
      <h1>Your Messages</h1>

      {/* Link to New Message Form */}
      <Link to="/messages/new">Create a New Message</Link>

      <ul>
        {messages.map((message) => (
          <li key={message.id}>{message.subject}</li> // Adjust based on your message structure
        ))}
      </ul>
    </div>
  );
}

export default UserMessages;
