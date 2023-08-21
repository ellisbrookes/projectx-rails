// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function () {
  const darkModeToggle = document.getElementById("darkModeToggle");
  const body = document.body;

  // Check initial mode preference (you can use cookies, localStorage, or other methods)
  const prefersDark = window.matchMedia("(prefers-color-scheme: dark)").matches;
  let darkModeEnabled = prefersDark;

  // Function to toggle dark mode
  function toggleDarkMode() {
    darkModeEnabled = !darkModeEnabled;
    body.classList.toggle("dark-mode", darkModeEnabled);
    body.classList.toggle("light-mode", !darkModeEnabled);
  }

  darkModeToggle.addEventListener("click", toggleDarkMode);
});