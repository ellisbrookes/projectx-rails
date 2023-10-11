import '@hotwired/turbo-rails';
import 'controllers';

const darkModeToggle = document.getElementById('darkModeToggle');

function setTheme(theme) {
  localStorage.setItem('theme', theme);
  document.documentElement.classList.toggle('dark', theme === 'dark');
}

function getPreferredTheme() {
  return localStorage.getItem('theme') || 'light';
}

function initializeTheme() {
  const preferredTheme = getPreferredTheme();
  const isDarkModePreferred = preferredTheme === 'dark' || (!preferredTheme && window.matchMedia('(prefers-color-scheme: dark)').matches);
  setTheme(isDarkModePreferred ? 'dark' : 'light');
  updateButtonAndIcons();
}

function updateButtonAndIcons() {
  const button = document.querySelector('label');
  const iconsWrapper = button?.querySelector('.icons-wrapper');
  const sun = iconsWrapper?.querySelector('.sun-span');
  const moon = iconsWrapper?.querySelector('.moon-span');
  const isDarkMode = getPreferredTheme() === 'dark';

  button?.classList.toggle('bg-gray-200', !isDarkMode);
  button?.classList.toggle('bg-slate-700', isDarkMode);

  iconsWrapper?.classList.toggle('translate-x-0', !isDarkMode);
  iconsWrapper?.classList.toggle('translate-x-5', isDarkMode);

  sun?.classList.toggle('opacity-100', !isDarkMode);
  sun?.classList.toggle('opacity-0', isDarkMode);
  sun?.classList.toggle('duration-200', isDarkMode);
  sun?.classList.toggle('duration-100', !isDarkMode);
  sun?.classList.toggle('ease-in', isDarkMode);
  sun?.classList.toggle('ease-out', !isDarkMode);

  moon?.classList.toggle('opacity-0', isDarkMode);
  moon?.classList.toggle('opacity-100', !isDarkMode);
  moon?.classList.toggle('duration-100', isDarkMode);
  moon?.classList.toggle('duration-200', !isDarkMode);
  moon?.classList.toggle('ease-out', isDarkMode);
  moon?.classList.toggle('ease-in', !isDarkMode);
}

function toggleTheme() {
  const currentTheme = getPreferredTheme();
  const newTheme = currentTheme === 'light' ? 'dark' : 'light';
  setTheme(newTheme);
  updateButtonAndIcons();
}

document.addEventListener('turbo:load', initializeTheme);

darkModeToggle.addEventListener('click', toggleTheme);
