import React, { useState, useEffect } from 'react';

function ScraperPage() {
  const [matches, setMatches] = useState([]);
  const [loading, setLoading] = useState(false);
  const [errorMessage, setErrorMessage] = useState(null);

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
      console.log(data);
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
      {match.user.messages && Array.isArray(match.user.messages) ? (
        <ul>
          {match.user.messages.map(message => (
            <li key={message.id}>
              Subject: {message.subject}
              <ul>
                {message.recipients.map(recipient => (
                  <li key={recipient.id}>
                    {recipient.name} ({recipient.email})
                  </li>
                ))}
              </ul>
            </li>
          ))}
        </ul>
      ) : (
        <p>No messages for this user.</p>
      )}
    </div>
  );    
  

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
  );
}

export default ScraperPage;
