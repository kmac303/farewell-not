import React, { useState, useEffect } from "react";
import { useParams, useHistory } from "react-router-dom/cjs/react-router-dom";

function Message() { 
    const { id } = useParams();
    const history = useHistory();
    const [messageDetails, setMessageDetails] = useState(null);
    const [isEditing, setIsEditing] = useState(false);
    const [formData, setFormData] = useState({
            subject: '',
            body: '',
            recipients: []
        });

    useEffect(() => {
        fetch(`/messages/${id}`)
        .then((response) => {
            if (!response.ok) {
                throw new Error('Not authorized to view this message.');
            }
            return response.json();
        })
        .then(data => {
            setMessageDetails(data);
            setFormData({
                subject: data.subject,
                body: data.body,
                recipients: data.recipients
            });
        })
        .catch((error) => {
            console.error(error);
        });
    }, [id]);

    const handleEditToggle = () => {
        setIsEditing(!isEditing);
    };

    const handleInputChange = (event, type, index) => {
        if (type === 'recipientName' || type === 'recipientEmail') {
            const newRecipients = [...formData.recipients];
            if (type === 'recipientName') {
                newRecipients[index].name = event.target.value;
            } else {
                newRecipients[index].email = event.target.value;
            }
            setFormData({ ...formData, recipients: newRecipients });
        } else {
            setFormData({ ...formData, [type]: event.target.value });
        }
    };

    const handleSubmit = (event) => {
        event.preventDefault();
        fetch(`/messages/${id}`, {
            method: 'PATCH',
            headers: {
            'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        })
            .then(response => response.json())
            .then(data => {
            setMessageDetails(data);
            setIsEditing(false);
            })
            .catch(error => console.error(error));
    };  

    const handleDelete = () => {
        fetch(`/messages/${id}`, {
            method: 'DELETE'
        })
        .then(response => {
            if (response.ok) {
                console.log("Message deleted successfully");
                history.push("/messages");
            } else {
                console.error("Error deleting message");
            }
        })
        .catch(error => console.error(error));
    };
    

    if (!messageDetails) return <div>Not authorized to view this message.</div>;

    return (
        <div>
            {isEditing ? (
                <form onSubmit={handleSubmit}>
                    <label>Subject:</label>
                    <input
                        type="text"
                        value={formData.subject}
                        onChange={(e) => handleInputChange(e, 'subject')}
                    />
                    <label>Body:</label>
                    <textarea
                        value={formData.body}
                        onChange={(e) => handleInputChange(e, 'body')}
                    />
                    <h3>Recipients:</h3>
                    {formData.recipients.map((recipient, index) => (
                        <div key={index}>
                            <input
                                type="text"
                                placeholder="Recipient Name"
                                value={recipient.name}
                                onChange={(e) => handleInputChange(e, 'recipientName', index)}
                            />
                            <input
                                type="text"
                                placeholder="Recipient Email"
                                value={recipient.email}
                                onChange={(e) => handleInputChange(e, 'recipientEmail', index)}
                            />
                        </div>
                    ))}
                    <button type="submit">Save Changes</button>
                    <button onClick={handleEditToggle}>Cancel</button>
                </form>
            ) : (
                <>
                    <h2>{messageDetails.subject}</h2>
                    <p>{messageDetails.body}</p>
                    <h3>Recipients:</h3>
                    <ul>
                        {messageDetails.recipients.map(recipient => (
                            <li key={recipient.id}>{recipient.name} ({recipient.email})</li>
                        ))}
                    </ul>
                    <button onClick={handleEditToggle}>Edit</button>
                    <button onClick={handleDelete}>Delete</button>
                </>
            )}
        </div>
    );
}

export default Message;
