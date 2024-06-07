document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('chat-form');
  const userInput = document.getElementById('user_input');
  const conversationDiv = document.getElementById('conversation');

  form.addEventListener('submit', (e) => {
    e.preventDefault();
    const userMessage = userInput.value;
    console.log(userMessage);
    fetch(form.action, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
      },
      body: JSON.stringify({ user_input: userMessage }),
    })
      .then(response => response.json())
      .then(data => {
        userInput.value = '';
        updateConversation(conversationDiv, userMessage, data.generated_text);
      })
      .catch(error => console.error('Error:', error));
  });

  function updateConversation(container, userMessage, botMessage) {
    container.innerHTML += `
      <p><strong>ユーザー:</strong> ${userMessage}</p>
      <p><strong>CATGPT:</strong> ${botMessage}</p>
    `;
  }
});
