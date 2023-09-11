import '@hotwired/turbo-rails'
import 'controllers'

const darkModeToggle = document.getElementById('darkModeToggle')

if (
  localStorage.theme === 'dark' ||
  (!('theme' in localStorage) &&
    window.matchMedia('(prefers-color-scheme: dark)').matches)
) {
  document.documentElement.classList.add('dark')
} else {
  document.documentElement.classList.remove('dark')
}

darkModeToggle.addEventListener('click', function () {
  if (localStorage.getItem('theme')) {
    if (localStorage.getItem('theme') === 'light') {
      document.documentElement.classList.add('dark')
      localStorage.theme = 'dark'
    } else {
      document.documentElement.classList.remove('dark')
      localStorage.theme = 'light'
    }
  } else {
    if (document.documentElement.classList.contains('dark')) {
      document.documentElement.classList.remove('dark')
      localStorage.theme = 'light'
    } else {
      document.documentElement.classList.add('dark')
      localStorage.theme = 'dark'
    }
  }

  const button = document.querySelector('label')
  const iconsWrapper = button?.querySelector('.icons-wrapper')
  const sun = iconsWrapper?.querySelector('.sun-span')
  const moon = iconsWrapper?.querySelector('.moon-span')

  button?.addEventListener('click', () => {
    // replace background
    if (button.classList.contains('bg-gray-200')) {
      button?.classList.replace('bg-gray-200', 'bg-indigo-400')
    } else {
      button?.classList.replace('bg-indigo-400', 'bg-gray-200')
    }

    // move toggle slider
    if (iconsWrapper?.classList.contains('translate-x-0')) {
      iconsWrapper?.classList.replace('translate-x-0', 'translate-x-5')
    } else {
      iconsWrapper?.classList.replace('translate-x-5', 'translate-x-0')
    }

    // toggle sun-span icon, opacity and duration
    if (sun?.classList.contains('opacity-100')) {
      sun?.classList.replace('opacity-100', 'opacity-0')
    } else {
      sun?.classList.replace('opacity-0', 'opacity-100')
    }

    if (sun?.classList.contains('duration-200')) {
      sun?.classList.replace('duration-200', 'duration-100')
    } else {
      sun?.classList.replace('duration-100', 'duration-200')
    }

    if (sun?.classList.contains('ease-in')) {
      sun?.classList.replace('ease-in', 'ease-out')
    } else {
      sun?.classList.replace('ease-out', 'ease-in')
    }

    // toggle moon-span, opacity and duration
    if (moon?.classList.contains('opacity-0')) {
      moon?.classList.replace('opacity-0', 'opacity-100')
    } else {
      moon?.classList.replace('opacity-100', 'opacity-0')
    }

    if (moon?.classList.contains('duration-100')) {
      moon?.classList.replace('duration-100', 'duration-200')
    } else {
      moon?.classList.replace('duration-200', 'duration-100')
    }

    if (moon?.classList.contains('ease-out')) {
      moon?.classList.replace('ease-out', 'ease-in')
    } else {
      moon?.classList.replace('ease-in', 'ease-out')
    }
  })
})
