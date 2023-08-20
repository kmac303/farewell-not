import React, { useState, useEffect, useContext } from 'react';
import { UserContext } from "../context/UserContext";

function ScraperPage() {
  const [matches, setMatches] = useState([]);
  const [loading, setLoading] = useState(false);
  const {user} = useContext(UserContext);

  const handleStartScraper = () => {
    setLoading(true);
    
    fetch('/start_scraper', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
    })
    .then(response => response.json())
    .then(data => {
      // console.log(data);
      setMatches(data);
      setLoading(false);
    })
    .catch(error => {
      console.error('Error:', error);
      setLoading(false);
    });
  }

  useEffect(() => {
    setLoading(true);
    fetch("/matches")
      .then((response) => response.json())
      .then((data) => {
        setMatches(data);
        setLoading(false);
      })
      .catch((error) => {
        console.error("Error fetching matches:", error);
        setLoading(false);
      });
  }, []);

  const renderMatch = (match) => (
    <div key={match.id}>
      <h3>Matched User: {match.user.first_name} {match.user.last_name}</h3>
      <p>Date of Passing: {match.date_of_passing}</p>
      <p>Obituary URL: <a href={match.obituary_url} target="_blank" rel="noopener noreferrer">{match.obituary_url}</a></p>
      <p>Summary: {match.summary}</p>
  
      <h4>Messages:</h4>
      {console.log(match)}
      {match?.user?.messages && match.user.messages.length > 0 ? (
        <ul>
        {match.user.messages.map(message => (
          <ul key={message.id}>
            Subject: {message.subject}
            <br />
            Body: {message.body}
            <ul>
            Recipients: 
              {message.recipients?.map(recipient => (
                <ul key={recipient.id}>
                  {recipient.name} ({recipient.email})
                </ul>
              ))}
            </ul>
          </ul>
          ))}
        </ul>
      ) : (
        <p>No messages for this user.</p>
      )}
    </div>
  );    

  if (user?.username === "kmac") {
    return (
    <div>
      <button onClick={handleStartScraper}>Start Web Scraper</button>

      {loading ? (
        <div>Loading...</div>
      ) : (
        <div>
          {matches.length > 0 ? (
            matches.map(renderMatch)
          ) : (
            <p>No matches found.</p>
          )}
        </div>
      )}
    </div>
  );} else {
        return (
        <>
          <h5>Please Login to an administrative account to view this page</h5>
        </>
      )}
  }

export default ScraperPage;
