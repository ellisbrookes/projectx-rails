import '@hotwired/turbo-rails';
import 'controllers';

const darkModeToggle = document.getElementById('darkModeToggle');

const setTheme = theme => {
  localStorage.setItem('theme', theme);
  document.documentElement.classList.toggle('dark', theme === 'dark');
};

const getPreferredTheme = () => localStorage.getItem('theme') || 'light';

const initializeTheme = () => {
  const isDarkModePreferred =
    getPreferredTheme() === 'dark' ||
    (!getPreferredTheme() && window.matchMedia('(prefers-color-scheme: dark)').matches);
  setTheme(isDarkModePreferred ? 'dark' : 'light');
  updateButtonAndIcons();
};

const updateButtonAndIcons = () => {
  const button = document.querySelector('label');
  const iconsWrapper = button?.querySelector('.icons-wrapper');
  const sun = iconsWrapper?.querySelector('.sun-span');
  const moon = iconsWrapper?.querySelector('.moon-span');
  const isDarkMode = getPreferredTheme() === 'dark';

  button?.classList.toggle('bg-white', !isDarkMode);
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
};

const toggleTheme = () => {
  const currentTheme = getPreferredTheme();
  const newTheme = currentTheme === 'light' ? 'dark' : 'light';
  setTheme(newTheme);
  updateButtonAndIcons();
};

document.addEventListener('turbo:load', initializeTheme);
darkModeToggle.addEventListener('click', toggleTheme);
