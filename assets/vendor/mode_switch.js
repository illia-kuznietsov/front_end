const darkModeToggle = document.getElementById('dark-mode-toggle');
const moonIcon = document.getElementById('moon-icon');
const sunIcon = document.getElementById('sun-icon');

// Check if dark mode was previously enabled and load the state
if (localStorage.getItem('darkMode') === 'enabled') {
  document.documentElement.classList.add('dark');
  moonIcon.classList.add('hidden');
  sunIcon.classList.remove('hidden');
}

// Add event listener to toggle button
darkModeToggle.addEventListener('click', () => {
  if (document.documentElement.classList.contains('dark')) {
    document.documentElement.classList.remove('dark');
    moonIcon.classList.remove('hidden');
    sunIcon.classList.add('hidden');
    localStorage.setItem('darkMode', 'disabled');
  } else {
    document.documentElement.classList.add('dark');
    moonIcon.classList.add('hidden');
    sunIcon.classList.remove('hidden');
    localStorage.setItem('darkMode', 'enabled');
  }
  
  // Dispatch the event to LiveView
  const event = new CustomEvent("toogle-darkmode");
  window.dispatchEvent(event); // Dispatch event globally
});
