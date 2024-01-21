import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="theme"
export default class extends Controller {
  static targets = ["themeToggle", "switcher"]

  connect() {
    if (localStorage.getItem('theme') === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      // animation classes
      this.switcherTarget.classList.remove('translate-x-0');
      this.switcherTarget.classList.add('translate-x-5');

      // button bg colour classes
      this.themeToggleTarget.classList.remove('bg-gray-200');
      this.themeToggleTarget.classList.add('bg-nepal-500');

      // force dark mode when switched to dark but system preferences are dark mode
      document.documentElement.classList.add('dark');
    } else {
      // animation classes
      this.switcherTarget.classList.remove('translate-x-5');
      this.switcherTarget.classList.add('translate-x-0');

      // button bg colour classes
      this.themeToggleTarget.classList.remove('bg-nepal-500');
      this.themeToggleTarget.classList.add('bg-gray-200');

      // force light mode when switched to light but system preferences are light mode
      document.documentElement.classList.remove('dark');
    }
  }

  toggleTheme() {
    if (localStorage.getItem('theme')) {
      if (localStorage.getItem('theme') === 'light') {
        localStorage.setItem('theme', 'dark');

        document.documentElement.classList.add('dark');

        // animation classes
        this.switcherTarget.classList.remove('translate-x-0');
        this.switcherTarget.classList.add('translate-x-5');

        // button bg colour classes
        this.themeToggleTarget.classList.remove('bg-gray-200');
        this.themeToggleTarget.classList.add('bg-nepal-500');
      } else {
        localStorage.setItem('theme', 'light');

        document.documentElement.classList.remove('dark');

        // animation classes
        this.switcherTarget.classList.remove('translate-x-5');
        this.switcherTarget.classList.add('translate-x-0');

        // button bg colour classes
        this.themeToggleTarget.classList.remove('bg-nepal-500');
        this.themeToggleTarget.classList.add('bg-gray-200');
      }
    } else {
      // if NOT set via local storage previously
      if (document.documentElement.classList.contains('dark')) {
        localStorage.setItem('theme', 'light');

        document.documentElement.classList.remove('dark');

        // animation classes
        this.switcherTarget.classList.remove('translate-x-5');
        this.switcherTarget.classList.add('translate-x-0');

        // button bg colour classes
        this.themeToggleTarget.classList.remove('bg-nepal-500');
        this.themeToggleTarget.classList.add('bg-gray-200');
      } else {
        localStorage.setItem('theme', 'dark');

        document.documentElement.classList.add('dark');

        // animation classes
        this.switcherTarget.classList.remove('translate-x-0');
        this.switcherTarget.classList.add('translate-x-5');

        // button bg colour classes
        this.themeToggleTarget.classList.remove('bg-gray-200');
        this.themeToggleTarget.classList.add('bg-nepal-500');
      }
    }
  }
}
