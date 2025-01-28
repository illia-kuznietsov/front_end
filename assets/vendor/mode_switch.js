const darkModeToggle = document.getElementById('dark-mode-toggle');

// Check if dark mode was previously enabled
if (localStorage.getItem('darkMode') === 'enabled') {
  document.documentElement.classList.add('dark');
}

// Toggle dark mode and persist state
darkModeToggle.addEventListener('click', () => {
  const isDarkMode = document.documentElement.classList.toggle('dark');
  localStorage.setItem('darkMode', isDarkMode ? 'enabled' : 'disabled');

  // Dispatch a custom event for LiveView or other integrations
  window.dispatchEvent(new CustomEvent("toggle-darkmode", { detail: { darkMode: isDarkMode } }));
});
