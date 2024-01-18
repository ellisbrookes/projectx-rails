import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="theme"
export default class extends Controller {
  static targets = ["lightIcon", "darkIcon", "themeToggle", "switcher"]

  connect() {
    if (localStorage.getItem('theme') === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      this.lightIconTarget.classList.remove('hidden');
      this.switcherTarget.classList.remove('translate-x-0');
      this.switcherTarget.classList.add('translate-x-5');
    } else {
      this.darkIconTarget.classList.remove('hidden');
      this.switcherTarget.classList.remove('translate-x-5');
      this.switcherTarget.classList.add('translate-x-0');
    }
  }

  toggleTheme() {
    console.log('theme target clicked')

    // < !--lightEnabled: "opacity-0 duration-100 ease-out", Not Enabled: "opacity-100 duration-200 ease-in" -- >
    // < !--darkEnabled: "opacity-100 duration-200 ease-in", Not Enabled: "opacity-0 duration-100 ease-out" -- >

    this.lightIconTarget.classList.toggle('hidden');
    this.darkIconTarget.classList.toggle('hidden');
    this.switcherTarget.classList.toggle('translate-x-0');

    if (localStorage.getItem('theme')) {
      if (localStorage.getItem('theme') === 'light') {
        localStorage.setItem('theme', 'dark');

        document.documentElement.classList.add('dark');
        this.switcherTarget.classList.remove('translate-x-0');
        this.switcherTarget.classList.add('translate-x-5');
      } else {
        localStorage.setItem('theme', 'light');

        document.documentElement.classList.remove('dark');
        this.switcherTarget.classList.remove('translate-x-5');
        this.switcherTarget.classList.add('translate-x-0');
      }
    } else {
      // if NOT set via local storage previously
      if (document.documentElement.classList.contains('dark')) {
        localStorage.setItem('theme', 'light');

        document.documentElement.classList.remove('dark');
        this.switcherTarget.classList.remove('translate-x-5');
        this.switcherTarget.classList.add('translate-x-0');
      } else {
        localStorage.setItem('theme', 'dark');

        document.documentElement.classList.add('dark');
        this.switcherTarget.classList.remove('translate-x-0');
        this.switcherTarget.classList.add('translate-x-5');
      }
    }
  }
}
