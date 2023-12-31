import React, { useState, useContext } from "react";
import { useHistory } from "react-router-dom/cjs/react-router-dom.min";
import { UserContext } from "../context/UserContext"; // Adjust the path if needed

function NewMessageForm() {
    const [formData, setFormData] = useState({
        subject: '',
        body: '',
      });    
    const [recipients, setRecipients] = useState([{ name: "", email: "" }]);
    const history = useHistory();
    const {setUser } = useContext(UserContext);

    function handleNameChange(event, idx) {
        const updatedRecipients = [...recipients];
        updatedRecipients[idx].name = event.target.value;
        setRecipients(updatedRecipients);
    }

    function handleEmailChange(event, idx) {
        const updatedRecipients = [...recipients];
        updatedRecipients[idx].email = event.target.value;
        setRecipients(updatedRecipients);
    }

    function addRecipient() {
        setRecipients([...recipients, { name: "", email: "" }]);
    }

    function submissionError() {
        return (
          window.confirm("Please make sure all sections are filled to create a message!")
        );
      }

    function handleSubmit(e) {
        e.preventDefault();
    
        fetch("/messages", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                message: {
                    subject: formData.subject,
                    body: formData.body,
                    recipients: recipients  // sending the recipients data
                }
            }),
        })
        .then((response) => {
            if (response.ok) {
                return response.json();
            } else {
                submissionError();
            }
        })
        .then((data) => {
            console.log("Message saved successfully!");
        
            // Update the user's messages
            setUser((currentUser) => ({
                ...currentUser,
                messages: currentUser.messages ? [...currentUser.messages, data] : [data]
            }));
            history.push('/messages')               
        
        })
        .catch((error) => {
            console.error("Error saving message:", error);
        });
    }
    
    return (
        <form onSubmit={handleSubmit}>
            <div>
                <label>Email Subject:</label>
                <input 
                    type="text"
                    value={formData.subject}
                    onChange={(e) => setFormData({...formData, subject: e.target.value})}
                    placeholder="Title to your email"
                />
            </div>

            <div>
                <label>Message Body:</label>
                <textarea 
                    value={formData.body} 
                    onChange={(e) => setFormData({...formData, body: e.target.value})}
                    placeholder="Write your message here"
                />
            </div>
            {recipients.map((recipient, idx) => (
                <div key={idx}>
                    <label>Recipient Name:</label>
                    <input 
                        placeholder="John Doe" 
                        value={recipient.name} 
                        onChange={(e) => handleNameChange(e, idx)} 
                    />
                    <label>Recipient Email:</label>
                    <input 
                        placeholder="johndoe@gmail.com" 
                        value={recipient.email} 
                        onChange={(e) => handleEmailChange(e, idx)} 
                    />
                </div>
            ))}
            <button type="button" onClick={addRecipient}>Add another recipient</button>
            <button type="submit">Save Message</button>
        </form>
    );
}

export default NewMessageForm;
