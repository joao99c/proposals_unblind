module.exports = {
    content: [
        './app/views/**/*.html.erb',
        './app/helpers/**/*.rb',
        './app/assets/stylesheets/**/*.css',
        './app/javascript/**/*.js',
    ],
    // make sure to safelist these classes when using purge
    safelist: [
        'w-64',
        'w-1/2',
        'rounded-l-lg',
        'rounded-r-lg',
        'bg-gray-200',
        'grid-cols-4',
        'grid-cols-7',
        'h-6',
        'leading-6',
        'h-9',
        'leading-9',
        'shadow-lg',
        'bg-opacity-50',
        'dark:bg-opacity-80',

        // Safe list bagde colors
        'bg-red-100',
        'bg-green-100',
        'bg-purple-100',
        'text-red-800',
        'text-green-800',
        'text-purple-800',
        'dark:bg-red-200',
        'dark:bg-green-200',
        'dark:bg-purple-200',
        'dark:text-red-900',
        'dark:text-green-900',
        'dark:text-purple-900',
    ],
    theme: {
        extend: {},
    },

    plugins: [
        require("flowbite/plugin")
    ],
}
